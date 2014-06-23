import QtQuick 1.0
import com.nokia.symbian 1.0

Rectangle {
    id: root
    property alias textL: lt.text
    property alias textR1: rt1.text
    property alias textR2: rt2.text
    property alias icon: ic.source
    property bool loading: false
    width: 360; height: 55; radius: 5
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#1498ff" }
        GradientStop { position: 1.0; color: "#1f49ef" }
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
        id: lt
        color: "White"; font.pixelSize: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ic.right
        anchors.leftMargin: (parent.height-font.pixelSize)/2
    }
    Text {
        id: rt1
        color: "White"; font.pixelSize: 16
        anchors.top: parent.top; anchors.topMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: (parent.height-font.pixelSize)/2
    }
    Text {
        id: rt2
        color: "White"; font.pixelSize: 16
        anchors.bottom: parent.bottom; anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: (parent.height-font.pixelSize)/2
    }
}
