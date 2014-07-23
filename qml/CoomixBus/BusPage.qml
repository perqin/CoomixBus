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
        stationList.currentIndex=Js.getSeq();
    }
    function refreshWait(){
/*sublineid=99566
citycode=860515
lastmodi=0
lat=4.9E-324
lng=4.9E-324
//
method=getnearcarinfo
&cn=gm
&ids=970637,970769,961864,970713---
&sublineid=99570---
&stationId=1792591---
&mapType=BAIDU
&citycode=860515---
*/
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
        busHeader.loading=false;
        //stationList.model=Js.o_line.data.dir[Js.d_direction].stations;
        carList.carsData=Js.o_bus.data.cars;
        Js.setIds();
        //carList.sl=Js.o_line.data.dir[Js.d_direction].stations;
        //carList.stationData=Js.o_line.data.station;
        carList.updateIt();
    }
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
                        refreshDirection(0);
                    }
                }
                Button {
                    id: to1Btn
                    text: "开往 "
                    width: parent.width
                    onClicked: {
                        fromHome=false;
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
            }
            CarList {
                id: carList
            }
            ListView {
                id: stationList; width: 360; height: 300
                anchors.left: parent.left; orientation: ListView.Horizontal
                delegate: stationListDelegate; focus: true
            }
        }
    }
    Component {
        id: stationListDelegate
        Item {
            id: stationListDelegateRoot; width: 60; height: stationListDelegateClmn.height
            Column {
                id: stationListDelegateClmn
                Image {
                    id: stationListDelegateImg
                    width: 60; height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "images/quit.svg"; opacity: 1
                }
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
                        anchors.centerIn: parent; width: 24; height: 24; color: "Red"; radius: 12
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
                        color: stationListDelegateRoot.ListView.isCurrentItem ? "Red" : "White"
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stationList.currentIndex  = index;
                    console.log(stationList.currentIndex);
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

    /*{
    "direction":"0",
    "end_station":"大唐芙蓉园南门",
    "id":"109682",
    "isopen":"1",
    "name":"237",
    "original_name":"237路",
    "start_station":"北陈村",
    "service_time":"06:30-19:30"
    }*/
    /*
    SelectionDialog {
        id: citySelect
        titleText: "选择你在的城市"
        model: Js.cityNameList
        onAccepted: {
            s_citycode=Js.cityList[selectedIndex].code;
            Settings.setValue("citycode", s_citycode);
            refreshAllLines();
        }
    }*//*
    Item {
        id: searchBar
        anchors.left: parent.left; anchors.leftMargin: 15
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.top: lineHeader.bottom; anchors.topMargin: 15
        height: lineSearch.height
        SearchInput {
            id: lineSearch
            hint: "在这里输入线路"
            anchors.left: parent.left; anchors.top: parent.top
            anchors.right: lineSearchButton.left; anchors.rightMargin: 15
            onTypeStopped: {
                if(text == ""){
                    linesList.model = Js.o_alllines;
                }else{
                    linesList.model = Js.filterIt(text);
                }
            }
        }
        Button {
            id: lineSearchButton
            anchors.right: parent.right; anchors.top: parent.top
            iconSource: privateStyle.toolBarIconPath("toolbar-search", true)
        }
    }
    ButtonRow {
        id: historyOrAll
        anchors.left: parent.left; anchors.leftMargin: 15
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.top: searchBar.bottom; anchors.topMargin: 15
        visible: lineSearch.empty ? true : false
        Button {
            id: historyLines
            text: "常用线路"
        }
        Button {
            id: allLines
            text: "全部线路"
        }
    }
    Component {
        id: linesListDelegate
        ListItem {
            id: linesListDelegateListItem
            Column {
                anchors.fill: linesListDelegateListItem.padding
                ListItemText {
                    //id: titleText
                    mode: linesListDelegateListItem.mode
                    role: "Title"
                    text: modelData.name+" 开往 "+modelData.end_station
                }
                ListItemText {
                    //id: subtitleText
                    mode: linesListDelegateListItem.mode
                    role: "SubTitle"
                    text: "起点站 "+modelData.start_station+" "+modelData.service_time
                }
            }
        }
    }
    ListView {
        id: linesList
        anchors.left: parent.left; anchors.leftMargin: 15
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.top: lineSearch.empty ? historyOrAll.bottom : searchBar.bottom
        anchors.topMargin: 15; anchors.bottom: parent.bottom; clip: true
        model: Js.historyList
        delegate: linesListDelegate
    }
    Component.onCompleted: {
        refreshAllCities();
        //refreshAllLines();
    }*/
}
