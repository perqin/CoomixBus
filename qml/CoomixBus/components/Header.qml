import QtQuick 1.0
import com.nokia.symbian 1.0

Rectangle {
    id: root
    property alias title: tt.text
    property alias value: st.text
    property alias icon: ic.source
    property bool loading: false
    property bool canselect: false
    signal select
    width: 360; height: 55; radius: 5
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#0000ff" }
        GradientStop { position: 1.0; color: "#00007f" }
    }
    Image {
        id: ic
        visible: !loading
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: (parent.height-height)/2
    }
    BusyIndicator {
        id: busy
        visible: loading
        running: visible
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: (parent.height-height)/2
    }
    Text {
        id: tt
        color: "White"; font.pixelSize: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ic.right
        anchors.leftMargin: (parent.height-font.pixelSize)/2
    }
    Text {
        id: st
        visible: canselect
        color: "White"; font.pixelSize: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: sb.left
        anchors.rightMargin: (parent.height-font.pixelSize)/2
    }
    Image {
        id: sb
        visible: canselect
        source: "../images/selector.svg"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: (parent.height-height)/2
        MouseArea {
            anchors.fill: parent
            onClicked: root.select()
        }
    }
}
