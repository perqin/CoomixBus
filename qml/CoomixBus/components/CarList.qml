import QtQuick 1.0
import com.nokia.symbian 1.0
import "carlist.js" as Js

Item {
    id: root; width: 360; height: 190
    property variant carsData
    property variant sl
    property variant stationData

    function updateIt(){
        //粤B78332还有20站,约12分34秒
        Js.temp_sl=sl;
        var tem_z = 0;
        if(carsData.length>0){
            tem_z=Js.getZ(carsData[0].stationid, stationData.id);
            if(tem_z > 1){
                c0.text=carsData[0].name+"\n还有"+Js.tT(tem_z)+"站,约"+Js.getM(carsData[0].waittime)+"分"+Js.getS(carsData[0].waittime)+"秒";
            }else if(tem_z == 1){
                if(carsData[0].stationstate=="1"){
                    c0.text=carsData[0].name+"\n即将进站，请做好准备";
                }
            }else if(tem_z == 0){
                if(carsData[0].stationstate=="1"){
                    c0.text=carsData[0].name+"\n已经进站";
                }else if(carsData[0].stationstate=="2"){
                    c0.text=carsData[0].name+"\n已经过站";
                }
            }
        }else{
            c0.text="尚未发车"
        }
        if(carsData.length>1){
            c1.text=carsData[1].name+",约"+Js.getM(carsData[1].waittime)+"分"+Js.getS(carsData[1].waittime)+"秒";
        }else{
            c1.text="尚未发车"
        }
        if(carsData.length>2){
            c2.text=carsData[2].name+",约"+Js.getM(carsData[2].waittime)+"分"+Js.getS(carsData[2].waittime)+"秒";
        }else{
            c2.text="尚未发车"
        }
        if(carsData.length>3){
            c3.text=carsData[3].name+",约"+Js.getM(carsData[3].waittime)+"分"+Js.getS(carsData[3].waittime)+"秒";
        }else{
            c3.text="尚未发车"
        }
    }
    Column {
        anchors.fill: parent
        ListItem {
            id: l0; width: 360; z: 10
            ListItemText {
                id: t0
                mode: parent.mode
                role: "Title"
                text: "最近的车："
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 15
            }
            ListItemText {
                id: c0
                mode: parent.mode
                role: "Title"
                text: "粤B78332\n还有20站,约12分34秒"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: t0.right//; anchors.leftMargin: 15
            }
            onClicked: {
                console.log(carsData.length);
            }
        }
        ListItem {
            id: l1; width: 360; height: 40; z: 9
            ListItemText {
                id: t1; mode: parent.mode; role: "Title"
                text: "最近的车："; opacity: 0.0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 15
            }
            ListItemText {
                id: c1
                mode: parent.mode
                role: "Title"
                text: "粤B78332,约12分34秒"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: t1.right
            }
        }
        ListItem {
            id: l2; width: 360;height: 40; z: 8
            ListItemText {
                id: t2; mode: parent.mode; role: "Title"
                text: "最近的车："; opacity: 0.0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 15
            }
            ListItemText {
                id: c2
                mode: parent.mode
                role: "Title"
                text: "粤B78332,约12分34秒"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: t2.right
            }
        }
        ListItem {
            id: l3; width: 360; height: 40; z: 7
            ListItemText {
                id: t3; mode: parent.mode; role: "Title"
                text: "最近的车："; opacity: 0.0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 15
            }
            ListItemText {
                id: c3
                mode: parent.mode
                role: "Title"
                text: "粤B78332,约12分34秒"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: t3.right
            }
        }
    }
}

/*
ListItem {
    id: root; width: 360
    property bool isFirstItem: false
    property alias txt: t.text
    property int dur: 300
    property bool fld: true

    ListItemText {
        id: t0
        mode: parent.mode
        role: "Title"
        text: "最近的车："
        opacity: isFirstItem ? 1.0 : 0.0
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left; anchors.leftMargin: 15
    }
    ListItemText {
        id: t
        mode: parent.mode
        role: "Title"
        text: "粤B78332\n还有20站,约12分34秒"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: t0.right//; anchors.leftMargin: 15
    }
    Image {
        id: arrow; source: "../images/arrow.svg"
        opacity: isFirstItem ? 1.0 : 0.0
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        state: fld ? "down" : "up"
        states: [
            State {
                name: "up"
                PropertyChanges { target: arrow; rotation: 180 }
            },
            State {
                name: "down"
                PropertyChanges { target: arrow; rotation: 0 }
            }
        ]
        transitions: Transition {
            RotationAnimation { duration: dur; direction: RotationAnimation.Counterclockwise }
        }
    }
}
*/
