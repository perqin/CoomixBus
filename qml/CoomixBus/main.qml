import QtQuick 1.0
import com.nokia.symbian 1.0
import "components"

PageStackWindow {
    id:main

    property string s_citycode: Settings.getValue("citycode", "860515");
    property string jsondata: "u"

    initialPage: HomePage {
        id: homePage
    }
    ToolTip {
        id: toolTip
        visible: false
    }
    ToolBarLayout{
        id:mainTools
        ToolButtonWithTip {
            toolTipText: pageStack.depth<=1 ? "退出" : "返回"
            iconSource: pageStack.depth<=1 ? "images/quit.svg" : "toolbar-back"
            onClicked: {
                quitDialog.open()
            }
        }
        ToolButtonWithTip {
            toolTipText: "线路"
            iconSource: "toolbar-share"
            onClicked: {
            }
        }
        ToolButtonWithTip {
            toolTipText: "站点"
            iconSource: "toolbar-add"
            onClicked: {

            }
        }
        ToolButtonWithTip {
            toolTipText: "换乘"
            iconSource: "toolbar-refresh"
            onClicked: {
            }
        }
        ToolButtonWithTip {
            toolTipText: "更多"
            iconSource: "images/more.svg"
            onClicked: {
            }
        }
    }
    QueryDialog {
        id: quitDialog
        titleText: "酷米客公交"
        message: "是否退出酷米客公交？"
        acceptButtonText: "是"
        rejectButtonText: "否"
        onAccepted: Qt.quit()
        onRejected: quitDialog.close()
    }
    Connections {
        target: Network
        onSendDataChange: {
            jsondata=Network.data;
            console.log(jsondata);
        }
    }
}
