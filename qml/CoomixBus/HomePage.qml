import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.nokia.extras 1.0
//import Qt.labs.components 1.0
import "components"
import "parser_home.js" as Js

Page{
    id:page
    tools: mainTools

    function refreshNotes(){
        lineHeader.loading=true;
        Network.setReqUrl("http://busapi.gpsoo.net/v1/bus/mbcommonservice?method=getnotices&looktime=0&type=1&pagesize=15&citycode="+s_citycode);
        Network.setReqType("note")
        Network.retrieveData()
    }
    function getNotes(){
        Js.parseJson("note", jsondata);
        notesData=Js.o_temp;
        lineHeader.loading=false;
        var notesString="";
        for(var i=0; i<Js.o_temp.data.length; i++){
            notesString=notesString+Js.dtc(i+1)+".【"+Js.o_temp.data[i].name+"】"+Js.o_temp.data[i].title+"\n"+Js.o_temp.data[i].content;
            if(i != Js.o_temp.data.length-1){
                notesString=notesString+"\n\n";
            }
        }
        notesText=notesString;
        if(Js.o_temp.data.length != 0){
            notesDialog.open();
        }
        if(initing==true){
            refreshAllCities();
        }
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
        if(initing==true){
            refreshAllLines();
        }
    }
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
        if(initing==true){
            initing=false;
        }
    }

    HomeHeader {
        id: lineHeader; title: "线路"; icon: "images/line.svg"
        loading: false; value: "null"
        onSelect: citySelect.open()
    }
    SelectionDialog {
        id: citySelect
        titleText: "选择你在的城市"
        model: Js.cityNameList
        onAccepted: {
            s_citycode=Js.cityList[selectedIndex].code;
            Settings.setValue("citycode", s_citycode);
            refreshAllLines();
        }
    }
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
            onClicked: {
                lineSearch.text=modelData.name;
                pb_lineName=modelData.name;
                pb_lineId=modelData.id;
                busData=modelData;
                pageStack.push(busPage);
                fromHome=true;
                busPage.refreshLine();
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
        refreshNotes();
    }
}
