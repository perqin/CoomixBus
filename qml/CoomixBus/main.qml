import QtQuick 1.0
import com.nokia.symbian 1.0
import "components"

PageStackWindow {
    id:main

    property string s_citycode: Settings.getValue("citycode", "860515")
    property int s_refreshfrequency: Settings.getValue("refreshfrequency", 2);
    property string s_historylist: Settings.getValue("historylist", "[]");
    property string s_historystationlist: Settings.getValue("historystationlist", "[]");
    property int s_shownotes: Settings.getValue("shownotes", 1);
    property bool initing: true
    property string jsondata: "u"
    property string pb_lineName: ""
    property string pb_lineId: ""
    property variant busData
    property variant notesData
    property string notesText: ""
    property bool fromHome: true
    property int timerP: 0
    property int carIconX0: 0
    property int carIconX1: 0
    property int carIconX2: 0
    property int carIconX3: 0
    property bool carPass0: false
    property bool carPass1: false
    property bool carPass2: false
    property bool carPass3: false
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

    initialPage: HomePage {
        id: homePage
    }
    //initialPage: busPage
    BusPage {
        id: busPage
    }
    MorePage {
        id: morePage
    }
    StationPage {
        id: stationPage
    }
    StationBusPage {
        id: stationBusPage;
    }

    ToolTip {
        id: toolTip
        visible: false
    }
    ToolBarLayout{
        id:mainTools
        function toPage(p) {
            if(pageStack.currentPage != p) {
                pageStack.push(p);
            }
        }
        ToolButtonWithTip {
            toolTipText: pageStack.depth<=1 ? "退出" : "返回"
            iconSource: pageStack.depth<=1 ? "images/quit.svg" : "toolbar-back"
            onClicked: {
                if(pageStack.depth<=1){
                    quitDialog.open();
                }else{
                    pageStack.pop();
                }
            }
        }
        ToolButtonWithTip {
            toolTipText: "线路"
            iconSource: "images/line.svg"
            onClicked: {
                if(pageStack.currentPage != homePage) {
                    pageStack.pop(homePage);
                }
            }
        }
        ToolButtonWithTip {
            toolTipText: "站点"
            iconSource: "images/station.svg"
            onClicked: {
                mainTools.toPage(stationPage);
                stationPage.updateListView();
            }
        }
        ToolButtonWithTip {
            toolTipText: "换乘"
            iconSource: "images/transfer.svg"
            onClicked: {
            }
        }
        ToolButtonWithTip {
            toolTipText: "更多"
            iconSource: "images/more.svg"
            onClicked: {
                mainTools.toPage(morePage);
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
    QueryDialog {
        id: notesDialog
        titleText: "公告"
        //acceptButtonText: "是"
        //rejectButtonText: "否"
        buttons: ToolBar {
            id: notesDlgBar; width: parent.width
            tools: ToolButton {
                text: "确定"; anchors.centerIn: parent
                width: (notesDlgBar.width - 3 * platformStyle.paddingMedium)/2
                onClicked: notesDialog.close();
            }
        }
        message: notesText
        //onAccepted: notesDialog.close()
        //onRejected: notesDialog.close()
    }
    Connections {
        target: Network
        onSendDataChange: {
            jsondata=Network.data;
            if(Network.reqType == "all"){
                console.log("qml--all");
                homePage.getAllLines();
            }else if(Network.reqType == "city"){
                console.log("qml--city");
                homePage.getAllCities();
            }else if(Network.reqType == "note"){
                console.log("qml--note");
                homePage.getNotes();
            }else if(Network.reqType == "line"){
                console.log("qml--line");
                busPage.getLine();
            }else if(Network.reqType == "wait"){
                console.log("qml--wait");
                busPage.getWait();
            }else if(Network.reqType == "station"){
                console.log("qml--station");
                busPage.getStation();
            }else if(Network.reqType == "sest"){
                console.log("qml--sest");
                stationPage.getSearchStations();
            }else if(Network.reqType == "stbu"){
                console.log("qml--stbu");
                stationBusPage.getStationBusList();
            }
        }
    }
}
