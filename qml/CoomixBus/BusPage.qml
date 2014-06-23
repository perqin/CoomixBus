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
        Js.u_lat="4.9E-324";
        Js.u_lng="4.9E-324";
        Js.u_sublineid=busData.id;
        console.log(Js.getUrl("line"))
        Network.setReqUrl(Js.getUrl("line"))
        Network.setReqType("line")
        Network.setCitycode(s_citycode)
        Network.retrieveData()
    }
    function getLine(){
        lineHeader.value=Js.getCityName(s_citycode)
        //Js.parseJson("all", jsondata);
        Js.o_linelist=Network.getDataObj("all");
        Js.parseJson("all","u");
        linesList.model=Js.o_alllines;
        lineHeader.loading=false;
    }
/*
    function refreshAllLines(){
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
    }
    function refreshAllCities(){
        lineHeader.loading=true;
        Network.setReqUrl(Js.getUrl("city"));
        Network.setReqType("city");
        Network.retrieveData();
    }
    function getAllCities(){
        Js.initCities(jsondata);
        citySelect.model=Js.cityNameList;
        lineHeader.loading=false;
        refreshAllLines();
    }
*/
    BusHeader {
        id: busHeader; icon: "images/transfer.svg" ;loading: false
        textL: busData.original_name=="" ? busData.name : busData.name+"(原"+busData.original_name+")"
        textR1: "首末班"+busData.service_time; textR2: "全程"+"8"+"元"
    }
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
