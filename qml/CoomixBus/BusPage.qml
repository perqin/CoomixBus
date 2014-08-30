import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.nokia.extras 1.0
//import Qt.labs.components 1.0
import "components"
import "parser_bus.js" as Js

Page{
    id:page
    tools: ToolBarLayout{
        id:busTools
        ToolButtonWithTip {
            toolTipText: "返回"
            iconSource: "toolbar-back"
            onClicked: {
                pageStack.pop();
            }
        }
    }
    function repositionCarIcon(cx) {
        if(carIconX0 == 0) {
            carIcon0.opacity = 0;
        }else{
            carIcon0.opacity = 1;
            carIcon0.x = carIconX0 - cx;
        }
        if(carIconX1 == 0) {
            carIcon1.opacity = 0;
        }else{
            carIcon1.opacity = 1;
            carIcon1.x = carIconX1 - cx;
        }
        if(carIconX2 == 0) {
            carIcon2.opacity = 0;
        }else{
            carIcon2.opacity = 1;
            carIcon2.x = carIconX2 - cx;
        }
        if(carIconX3 == 0) {
            carIcon3.opacity = 0;
        }else{
            carIcon3.opacity = 1;
            carIcon3.x = carIconX3 - cx;
        }
    }

    function refreshLine(){
/*sublineid=99566
citycode=860515
lastmodi=0
lat=4.9E-324
lng=4.9E-324*/
        busHeader.loading=true;
        Js.u_citycode=s_citycode
        Js.u_lastmodi="0";
        Js.u_lat="22.773094";
        Js.u_lng="114.351272";
        Js.u_sublineid=busData.id;
        console.log(Js.getUrl("line"))
        Network.setReqUrl(Js.getUrl("line"))
        Network.setReqType("line")
        Network.setCitycode(s_citycode)
        Network.retrieveData()
    }
    function refreshDirection(d){
        busHeader.loading=true;
        Js.u_citycode=s_citycode;
        Js.u_lastmodi="0";
        Js.u_lat=Js.o_line.data.station.lat;
        Js.u_lng=Js.o_line.data.station.lng;
        Js.u_sublineid=Js.o_line.data.dir[d].id;
        console.log(Js.getUrl("line"));
        Network.setReqUrl(Js.getUrl("line"));
        Network.setReqType("line");
        Network.setCitycode(s_citycode);
        Network.retrieveData();
    }
    function getLine(){
        Js.parseJson("line", jsondata);
        if(fromHome){
            Js.d_direction=busData.direction;
        }else{
            if(Js.o_line.data.dir[0].id==Js.u_sublineid){
                Js.d_direction=0;
            }else{
                Js.d_direction=1;
            }
        }
        busHeader.textR2="全程"+Js.o_line.data.dir[Js.d_direction].price+"元";
        if(Js.d_direction==0){
            toBtnClmn.checkedButton=to0Btn;
        }else{
            toBtnClmn.checkedButton=to1Btn;
        }
        to0Btn.text="开往 "+Js.o_line.data.dir[0].end_station;
        to1Btn.text="开往 "+Js.o_line.data.dir[1].end_station;
        myStationText.text="候车站点："+Js.o_line.data.station.name+"（点击刷新）";
        busHeader.loading=false;
        stationList.model=Js.o_line.data.dir[Js.d_direction].stations;
        carList.carsData=Js.o_line.data.cars;
        carList.sl=Js.o_line.data.dir[Js.d_direction].stations;
        carList.stationData=Js.o_line.data.station;
        carList.updateIt();
        repositionCarIcon(stationList.contentX);
        stationList.currentIndex=Js.getSeq();
        if(s_refreshfrequency != 0){
            timerP = 0;
            refreshBusTimer.running = true;
        }
    }
    function refreshWait(){
        //method=getnearcarinfo&cn=gm&ids=&sublineid=99426&stationId=1907898&mapType=BAIDU&citycode=860515
        busHeader.loading=true;
        Js.u_sublineid=Js.o_line.data.dir[Js.d_direction].id;
        Js.u_stationId=Js.o_line.data.station.id;
        Js.u_citycode=s_citycode;
        Network.setReqUrl(Js.getUrl("wait"));
        Network.setReqType("wait");
        Network.setCitycode(s_citycode);
        Network.retrieveData();
    }
    function getWait(){
        Js.parseJson("wait", jsondata);
        carList.carsData=Js.o_bus.data;
        carList.sl=Js.o_line.data.dir[Js.d_direction].stations;
        carList.stationData=Js.o_line.data.station;
        carList.updateIt();
        repositionCarIcon(stationList.contentX);
        busHeader.loading=false;
        if(s_refreshfrequency != 0) {
            timerP = 0;
            refreshBusTimer.running = true;
        }
    }
    function refreshStation(){
        //method=getnearcarinfo&cn=gm&ids=&sublineid=99426&stationId=1907898&mapType=BAIDU&citycode=860515
        busHeader.loading=true;
        Js.u_sublineid=Js.o_line.data.dir[Js.d_direction].id;
        Js.u_stationId=Js.o_line.data.dir[Js.d_direction].stations[stationList.currentIndex].id;
        Js.u_citycode=s_citycode;
        Network.setReqUrl(Js.getUrl("station"));
        Network.setReqType("station");
        Network.setCitycode(s_citycode);
        Network.retrieveData();
    }
    function getStation(){
        Js.parseJson("wait", jsondata);
        carList.carsData=Js.o_bus.data;
        carList.sl=Js.o_line.data.dir[Js.d_direction].stations;
        Js.o_line.data.station=Js.o_line.data.dir[Js.d_direction].stations[stationList.currentIndex];
        carList.stationData=Js.o_line.data.station;
        carList.updateIt();
        repositionCarIcon(stationList.contentX);
        myStationText.text="候车站点："+Js.o_line.data.station.name+"（点击刷新）";
        busHeader.loading=false;
        if(s_refreshfrequency != 0) {
            timerP = 0;
            refreshBusTimer.running = true;
        }
    }
    Timer {
        id: refreshBusTimer; interval: 5000; repeat: true; running: false
        onTriggered: {
            if(s_refreshfrequency == 0) {
                running = false;
            }
            timerP = timerP + 1;
            if(Js.getTimerP(s_refreshfrequency) == timerP) {
                refreshWait();
                running = false;
            }
        }
    }/*
    Timer {
        id: tttt; interval: 1000; repeat: true; running: true
        onTriggered: console.log(stationList.contentX);
    }*/

    BusHeader {
        id: busHeader; icon: "images/transfer.svg" ;loading: false
        textL: busData.original_name=="" ? busData.name : busData.name+"(原"+busData.original_name+")"
        textR1: "首末班"+busData.service_time; textR2: "全程?元"
    }
    Flickable {
        anchors.top: busHeader.bottom; anchors.topMargin: 15; anchors.bottom: parent.bottom
        width: parent.width; clip: true; focus:true
        contentHeight: busPageClmn.height
        Column {
            id: busPageClmn; width: parent.width
            ButtonColumn {
                id: toBtnClmn
                anchors.left: parent.left; anchors.leftMargin: 15
                anchors.right: parent.right; anchors.rightMargin: 15
                Button {
                    id: to0Btn
                    text: "开往 "
                    width: parent.width
                    onClicked: {
                        fromHome=false;
                        refreshBusTimer.running = false;
                        refreshDirection(0);
                    }
                }
                Button {
                    id: to1Btn
                    text: "开往 "
                    width: parent.width
                    onClicked: {
                        fromHome=false;
                        refreshBusTimer.running = false;
                        refreshDirection(1);
                    }
                }
            }
            ListItem {
                id: myStationListItem
                anchors.left: parent.left; anchors.right: parent.right
                anchors.top: toBtnClmn.bottom; anchors.topMargin: 15
                ListItemText {
                    id: myStationText
                    mode: myStationListItem.mode
                    role: "Title"
                    text: "候车站点： (点击刷新)"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left; anchors.leftMargin: 15
                }
                onClicked: {
                    refreshBusTimer.running = false;
                    refreshWait();
                }
            }
            CarList {
                id: carList
            }
            Image {
                id: carIcon0; width: 60; height: 40
                anchors.top: carList.bottom; x: 0//; anchors.topMargin: 25
                source: carPass0 ? "images/carIconG.png" : "images/carIconB.png"; opacity: 1
            }
            Image {
                id: carIcon1; width: 60; height: 40
                anchors.top: carList.bottom; x: 0//; anchors.topMargin: 25
                source: carPass1 ? "images/carIconG.png" : "images/carIconB.png"; opacity: 1
            }
            Image {
                id: carIcon2; width: 60; height: 40
                anchors.top: carList.bottom; x: 0//; anchors.topMargin: 25
                source: carPass2 ? "images/carIconG.png" : "images/carIconB.png"; opacity: 1
            }
            Image {
                id: carIcon3; width: 60; height: 40
                anchors.top: carList.bottom; x: 0//; anchors.topMargin: 25
                source: carPass3 ? "images/carIconG.png" : "images/carIconB.png"; opacity: 1
            }
            ListView {
                id: stationList; width: 360; height: 300
                anchors.left: parent.left; orientation: ListView.Horizontal
                anchors.top: carList.bottom; anchors.topMargin: 20
                delegate: stationListDelegate; focus: true
                onContentXChanged: {
                    repositionCarIcon(contentX);
                }
            }
        }
    }
    Component {
        id: stationListDelegate
        Item {
            id: stationListDelegateRoot; width: 60; height: stationListDelegateClmn.height
            Column {
                id: stationListDelegateClmn
                Item {
                    id: stationListDelegateLine; width: 60; height: 60
                    //anchors.top: stationListDelegateImg.bottom
                    Rectangle {
                        anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter
                        width: 30; height: 6; color: "White"
                        opacity: index==0 ? 0.0 : 1.0
                    }
                    Rectangle {
                        anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
                        width: 30; height: 6; color: "White"
                        opacity: index==(Js.o_line.data.dir[Js.d_direction].stations.length-1)?0.0:1.0
                    }
                    Rectangle {
                        anchors.centerIn: parent; width: 24; height: 24; color: "#1080dd"; radius: 12
                        //opacity: ListView.isCurrentItem ? 1.0 : 0.0
                        visible: stationListDelegateRoot.ListView.isCurrentItem ? true : false
                    }
                    Rectangle {
                        anchors.centerIn: parent; width: 12; height: 12; color: "White"; radius: 6
                    }
                }
                Item {
                    //anchors.top: stationListDelegateLine.bottom;
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 20; height: 200
                    Text {
                        text: modelData.name
                        font.pixelSize: 20; anchors.fill: parent; wrapMode: Text.Wrap
                        color: stationListDelegateRoot.ListView.isCurrentItem ? "#1080dd" : "White"
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stationList.currentIndex  = index;
                    console.log(stationList.currentIndex);
                    refreshStation();
                }
            }
        }
    }
    /*Timer {
        id: tttt; interval: 100; repeat: true; running: true
        onTriggered: {
            console.log(carList.height);
        }
    }*/
}
