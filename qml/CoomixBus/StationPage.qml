import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.nokia.extras 1.0
//import Qt.labs.components 1.0
import "components"
import "parser_station.js" as Js

Page{
    id:page
    tools: mainTools

    function updateListView(){
        Js.setHistoryList(s_historystationlist);
        historyStationsList.model = Js.historyList;
        //nearbyStationsList.model = Js.nearbyList;
    }

    function refreshSearchStations(){
        stationHeader.loading=true;
        Network.setReqUrl(Js.getUrl(s_citycode, stationSearch.text));
        Network.setReqType("sest");
        Network.retrieveData();
    }
    function getSearchStations(){
        Js.parseIt(jsondata);
        searchStationsList.model = Js.searchList;
        stationListTabGroup.currentTab = searchStationsList;
        stationHeader.loading = false;
    }
    function refreshNearbyStations() {
        stationHeader.loading = true;
        Network.setReqUrl(Js.getUrlNearby(locationLat, locationLng, s_citycode));
        Network.setReqType("nbst");
        Network.retrieveData();
    }
    function getNearbyStations() {
        Js.parseNearby(jsondata);
        nearbyStationsList.model = Js.nearbyList;
        stationListTabGroup.currentTab = nearbyStationsList;
        stationHeader.loading = false;
    }

    CommonHeader {
        id: stationHeader; icon: "images/station.svg" ;loading: false; title: "站点"
    }
    Item {
        id: searchBar
        anchors.left: parent.left; anchors.leftMargin: 15
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.top: stationHeader.bottom; anchors.topMargin: 15
        height: stationSearch.height
        SearchInput {
            id: stationSearch
            hint: "在这里输入站点"
            anchors.left: parent.left; anchors.top: parent.top
            anchors.right: stationSearchButton.left; anchors.rightMargin: 15
            onTypeStopped: {
                if(text == ""){
                    stationListTabGroup.currentTab = historyStationsList;
                }else if(text == "1"){text = "坪洲百货";}
            }
        }
        Button {
            id: stationSearchButton
            anchors.right: parent.right; anchors.top: parent.top
            iconSource: privateStyle.toolBarIconPath("toolbar-search", true);
            onClicked: {
                refreshSearchStations();
            }
        }
    }
    ButtonRow {
        id: historyOrNearby
        anchors.left: parent.left; anchors.leftMargin: 15
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.top: searchBar.bottom; anchors.topMargin: 15
        visible: stationListTabGroup.currentTab !== searchStationsList ? true : false
        Button {
            id: historyStations
            text: "常用站点"
            checked: true
            onClicked: {
                stationListTabGroup.currentTab = historyStationsList;
            }
        }
        Button {
            id: nearbyStations
            text: "附近站点"
            onClicked: {
                positionListener.target = positionSource;
                positionSource.update();
                //stationListTabGroup.currentTab = nearbyStationsList;
            }
        }
    }
    TabGroup {
        id: stationListTabGroup
        anchors.left: parent.left; anchors.leftMargin: 15
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.bottom: parent.bottom; anchors.top: searchBar.bottom; anchors.topMargin: 15
        currentTab: historyStationsList
        ListView {
            id: historyStationsList
            clip: true; width: parent.width; anchors.bottom: parent.bottom;
            anchors.top: parent.top; anchors.topMargin: historyOrNearby.height + 15;
            //model: Js.historyList
            delegate: stationsListDelegate
        }
        ListView {
            id: nearbyStationsList
            clip: true; width: parent.width; anchors.bottom: parent.bottom;
            anchors.top: parent.top; anchors.topMargin: historyOrNearby.height + 15;
            //model: Js.historyList
            delegate: nearbyStationsListDelegate
        }
        ListView {
            id: searchStationsList
            clip: true; anchors.fill: parent;
            //model: Js.historyList
            delegate: stationsListDelegate;
        }
    }
    Component {
        id: stationsListDelegate
        ListItem {
            ListItemText {
                mode: parent.mode
                role: "Title"
                text: modelData.station_name;
                anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.paddingItem.left;
            }
            onClicked: {
                Js.setHistoryList(s_historystationlist);
                Js.appendHistory(modelData);
                s_historystationlist = Js.historyListString;
                Settings.setValue("historystationlist", s_historystationlist);
                historyStationsList.model = Js.historyList;
                pageStack.push(stationBusPage);
                stationBusPage.uqi_stationname = modelData.station_name;
                stationBusPage.refreshStationBusList();
            }
        }
    }
    Component {
        id: nearbyStationsListDelegate
        ListItem {
            ListItemText {
                mode: parent.mode
                role: "Title"
                text: modelData.name;
                anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.paddingItem.left;
            }
            onClicked: {
                Js.setHistoryList(s_historystationlist);
                var md_temp = new Object();
                md_temp.station_name = modelData.name;
                Js.appendHistory(md_temp);
                s_historystationlist = Js.historyListString;
                Settings.setValue("historystationlist", s_historystationlist);
                historyStationsList.model = Js.historyList;
                pageStack.push(stationBusPage);
                stationBusPage.uqi_stationname = modelData.name;
                stationBusPage.refreshStationBusList();
            }
        }
    }
    Connections {
        id: positionListener;
        target: null;
        onPositionChanged: {
            if(positionSource.valid) {
                //locationLat = positionSource.latitude;
                //locationLng = positionSource.longitude;
                locationLat = "22.7770507335663";
                locationLng = "114.319546222687";
                console.log("*******************************************************" + locationLat + "," + locationLng);
            }
            positionListener.target = null;
            refreshNearbyStations();
        }
    }
}
