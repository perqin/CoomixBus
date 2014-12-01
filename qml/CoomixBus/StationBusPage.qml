import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.nokia.extras 1.0
//import Qt.labs.components 1.0
import "components"
import "parser_stationbus.js" as Js

Page{
    id:page
    tools: ToolBarLayout {
        ToolButtonWithTip {
            toolTipText: "返回"
            iconSource: "toolbar-back"
            onClicked: {
                pageStack.pop();
            }
        }
    }

    property string uqi_stationname: ""

    function refreshStationBusList(){
        stationBusHeader.loading = true;
        Network.setReqUrl(Js.getUrl(s_citycode, uqi_stationname));
        Network.setReqType("stbu");
        Network.retrieveData();
    }
    function getStationBusList(){
        Js.parseIt(jsondata);
        stationBusList.model = Js.stationBusList;
        stationBusHeader.title = uqi_stationname + " 共" + Js.dtc(Js.stationBusList.length) + "条线路";
        stationBusHeader.loading = false;
    }

    CommonHeader {
        id: stationBusHeader; icon: "images/station.svg" ;loading: false; title: "XX站点 共Y条线路";
        ToolButton {
            iconSource: "toolbar-refresh"; anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right; anchors.rightMargin: (parent.height - height) / 2;
            enabled: !parent.loading
            onClicked: {
                refreshStationBusList();
            }
        }
    }
    ListView {
        id: stationBusList
        clip: true; width: parent.width; anchors.bottom: parent.bottom;
        anchors.top: stationBusHeader.bottom;
        delegate: stationBusListDelegate
    }
    Component {
        id: stationBusListDelegate
        ListItem {
            id: stationBusListDelegateListItem
            subItemIndicator: true
            Column {
                anchors.fill: stationBusListDelegateListItem.paddingItem
                ListItemText {
                    mode: stationBusListDelegateListItem.mode
                    role: "Title"
                    text: modelData.line_name;
                }
                ListItemText {
                    mode: stationBusListDelegateListItem.mode
                    role: "Subtitle"
                    text: "开往 "+modelData.end_station;
                }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter; color: "White"
                anchors.right: parent.right; anchors.rightMargin: 35;
                text: modelData.isopen == "0" ? "未开通" : (modelData.wait_time == 99999 ? "尚未发车" : (((modelData.wait_time - (modelData.wait_time % 60))/60) > 1 ? ("还有" + Js.dtc((modelData.wait_time - (modelData.wait_time % 60))/60) + "分钟") : "即将到站"));
            }
            onClicked: {
                if(modelData.isopen == "1") {
                    var mD = Js.makeModelData(modelData.dir,
                                              modelData.end_station,
                                              modelData.sublineid,
                                              modelData.isopen,
                                              modelData.line_name,
                                              "",
                                              modelData.start_station,
                                              modelData.begin_time + "-" + modelData.end_time);
                    Js.setHistoryList(s_historylist);
                    Js.appendHistory(mD);
                    s_historylist = Js.historyListString;
                    Settings.setValue("historylist", s_historylist);
                    pageStack.push(busPage);
                    busPage.lineData = mD;
                    directionChanged = false;
                    locationLat = modelData.station.lat;
                    locationLng = modelData.station.lng;
                    busPage.refreshLine2();
                }
            }
        }
    }
}
