import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.nokia.extras 1.0
//import Qt.labs.components 1.0
import "components"
import "parser.js" as Js

Page{
    id:page
    tools: mainTools

    function getAllLines(){
        Js.parseJson("all", jsondata);
    }

    Header {
        id: lineHeader; title: "线路"; icon: "images/selector.svg"
        loading: false; canselect: true; value: "深圳"
        onSelect: citySelect.open()
    }
    SelectionDialog {
        id: citySelect
        titleText: "选择你在的城市"
        model: Js.cityList
        onAccepted: {
            s_citycode=Js.cityList[selectedIndex].code

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
    ListView {
        id: linesList
        anchors.left: parent.left; anchors.leftMargin: 15
        anchors.right: parent.right; anchors.rightMargin: 15
        anchors.top: lineSearch.empty ? historyOrAll.bottom : searchBar.bottom
        anchors.topMargin: 15; anchors.bottom: parent.bottom; clip: true
        model: Js.historyList
    }
    Component.onCompleted: {
        Js.initNameList()
        citySelect.model=Js.cityNameList
        lineHeader.value=Js.getCityName(s_citycode)
        console.log(Js.getCityName(s_citycode))
        Js.u_citycode=s_citycode
        console.log(Js.getUrl("all"))
        Network.setReqUrl(Js.getUrl("all"))
        console.log("F1")
        Network.retrieveData()
        console.log("F2")
    }
}
