import QtQuick 1.0
import com.nokia.symbian 1.0
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


Item {
    id: root; width: 360; height: 70
    property variant carsData
    property bool folded: true
    property int dur: 300


    function getM(t){

    }

    function updateIt(){
        //粤B78332还有20站,约12分34秒
        if(carsData.length==0){
            root.height=70;
            c0.text="尚未发车";
        }else if(carsData.length>4){
            root.height=280;
        }else{
            root.height=carsData.length * 70;
        }
        if(carsData.length>0){
            c0.text=carsData[0].name+"\n还有"+"X"+"站,约"+"Y"+"分"+"Z"+"秒";
        }
        if(carsData.length>1){
            c1.text=carsData[1].name+"\n还有"+"X"+"站,约"+"Y"+"分"+"Z"+"秒";
        }
        if(carsData.length>2){
            c2.text=carsData[2].name+"\n还有"+"X"+"站,约"+"Y"+"分"+"Z"+"秒";
        }
        if(carsData.length>3){
            c3.text=carsData[3].name+"\n还有"+"X"+"站,约"+"Y"+"分"+"Z"+"秒";
        }
        ani.running=true;
    }
    ListItem {
        id: l0; width: 360; x: 0; y: 0; z: 10; height: 30
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
        Image {
            id: arrow; source: "../images/arrow.svg"
            anchors.right: parent.right; anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            state: folded ? "down" : "up"
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
        onClicked: {
            folded=!folded;
            console.log(carsData.length);
            ani.running=true;
        }
    }
    ListItem {
        id: l1; width: 360; x: 0; y: 0; z: 9
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
            text: "粤B78332\n还有20站,约12分34秒"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: t1.right
        }
    }
    ListItem {
        id: l2; width: 360; x: 0; y: 0; z: 8
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
            text: "粤B78332\n还有20站,约12分34秒"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: t2.right
        }
    }
    ListItem {
        id: l3; width: 360; x: 0; y: 0; z: 7
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
            text: "粤B78332\n还有20站,约12分34秒"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: t3.right
        }
    }
    ParallelAnimation  {
        id: ani; running: false
        NumberAnimation  {
            target: l1; property:"y"; duration: dur
            to: ((folded==false)&&(carsData.length>1)) ? 70 : 0
        }
        NumberAnimation  {
            target: l1; property:"opacity"; duration: dur
            to: folded ? 0.0 : 1.0
        }
        NumberAnimation  {
            target: l2; property:"y"; duration: dur
            to: ((folded==false)&&(carsData.length>2)) ? 140 : 0
        }
        NumberAnimation  {
            target: l2; property:"opacity"; duration: dur
            to: folded ? 0.0 : 1.0
        }
        NumberAnimation  {
            target: l3; property:"y"; duration: dur
            to: ((folded==false)&&(carsData.length>3)) ? 210 : 0
        }
        NumberAnimation  {
            target: l3; property:"opacity"; duration: dur
            to: folded ? 0.0 : 1.0
        }
    }
}
