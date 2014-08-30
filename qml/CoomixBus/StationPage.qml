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
        console.log("####----####"+jsondata+"####----####");
        searchStationsList.model = Js.searchList;
        stationListTabGroup.currentTab = searchStationsList;
        stationHeader.loading = false;
    }
    /*function refreshAllLines(){
        lineHeader.loading=true;
        Js.u_citycode=s_citycode
        console.log(Js.getUrl("all"))
        Network.setReqUrl(Js.getUrl("all"))
        Network.setReqType("all")
        Network.setCitycode(s_citycode)
        Network.retrieveData()
    }
    function getAllLines(){
        lineHeader.value=Js.getCityName(s_citycode)
        //Js.parseJson("all", jsondata);
        Js.o_linelist=Network.getDataObj("all");
        Js.parseJson("all","u");
        linesList.model=Js.o_alllines;
        lineHeader.loading=false;
        if(initing==true){
            initing=false;
        }
    }*/

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
                }else if(text == "1"){text = "深圳";}
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
        visible: stationSearch.empty ? true : false
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
                stationListTabGroup.currentTab = nearbyStationsList;
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
            delegate: stationsListDelegate
        }
        ListView {
            id: searchStationsList
            clip: true; anchors.fill: parent;
            //model: Js.historyList
            delegate: stationsListDelegate
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
                Js.appendHistory(modelData);
                Settings.setValue("historystationlist", Js.historyListString);
                historyStationsList.model = Js.historyList;
                pageStack.push(stationBusPage);
                stationBusPage.uqi_stationname = modelData.station_name;
                stationBusPage.refreshStationBusList();
                /*lineSearch.text=modelData.name;
                pb_lineName=modelData.name;
                pb_lineId=modelData.id;
                busData=modelData;
                pageStack.push(busPage);
                fromHome=true;
                busPage.refreshLine();*/
            }
        }
    }
}
