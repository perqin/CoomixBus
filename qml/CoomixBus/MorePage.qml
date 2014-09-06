import QtQuick 1.0
import com.nokia.symbian 1.0
import "components"

Page {
    id: page
    tools: mainTools

    CommonHeader {
        id: moreHeader; icon: "images/more.svg" ;loading: false; title: "更多"
    }
    Flickable {
        anchors.top: moreHeader.bottom; anchors.bottom: parent.bottom
        width: parent.width; clip: true; focus:true
        contentHeight: morePageClmn.height
        Column {
            id: morePageClmn; width: parent.width
            ListHeading {
                ListItemText {
                    anchors.fill: parent.paddingItem; role: "Heading"
                    text: "公告"
                }
            }
            Item {
                width: parent.width; height: 70;
                CheckBox {
                    checked: s_shownotes == 1 ? true : false;
                    anchors.leftMargin: platformStyle.paddingLarge; anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: "打开时弹出公告";
                    onClicked: {
                        console.log(parent.height);
                        if(s_shownotes == 1){
                            s_shownotes = 0;
                        }else{
                            s_shownotes = 1;
                        }
                        Settings.setValue("shownotes", s_shownotes);
                    }
                }
            }
            ListItem {
                subItemIndicator: true
                enabled: haveNotes;
                ListItemText {
                    role: "Title"; mode: parent.mode
                    anchors.verticalCenter: parent.paddingItem.verticalCenter
                    anchors.left: parent.paddingItem.left
                    text: haveNotes ? "公告" : "没有公告";
                }
                onClicked: {
                    notesDialog.open();
                }
            }
            ListHeading {
                ListItemText {
                    anchors.fill: parent.paddingItem; role: "Heading"
                    text: "设置"
                }
            }
            SelectionListItem {
                title: "候车刷新频率"
                subTitle: refreshSD.model.get(refreshSD.selectedIndex).name
                onClicked: refreshSD.open()
                SelectionDialog {
                    id: refreshSD
                    titleText: "选择候车刷新频率"
                    selectedIndex: s_refreshfrequency
                    model: ListModel {
                        ListElement { name: "不自动刷新" }
                        ListElement { name: "5秒" }
                        ListElement { name: "15秒" }
                        ListElement { name: "30秒" }
                        ListElement { name: "60秒" }
                    }
                    onAccepted: {
                        s_refreshfrequency=selectedIndex;
                        Settings.setValue("refreshfrequency", s_refreshfrequency);
                        if(s_refreshfrequency != 0) {
                            timerP = 0;
                        }
                    }
                }
            }
            SelectionListItem {
                function fre2ind(fre) {
                    switch(fre) {
                    case 0: return 0;
                    case 1: return 1;
                    case 5: return 2;
                    case 10: return 3;
                    case 30: return 4;
                    default: return 0;
                    }
                }
                title: "位置刷新频率(长按手动刷新)"
                subTitle: refposSD.model.get(refposSD.selectedIndex).name
                onClicked: refposSD.open();
                onPressAndHold: positionSource.update();
                SelectionDialog {
                    id: refposSD
                    titleText: "选择位置刷新频率";
                    selectedIndex: parent.fre2ind(s_positionfrequency);
                    model: ListModel {
                        ListElement { name: "不自动刷新" }
                        ListElement { name: "1分钟" }
                        ListElement { name: "5分钟" }
                        ListElement { name: "10分钟" }
                        ListElement { name: "30分钟" }
                    }
                    onAccepted: {
                        switch(selectedIndex) {
                        case 0: s_positionfrequency = 0; break;
                        case 1: s_positionfrequency = 1; break;
                        case 2: s_positionfrequency = 5; break;
                        case 3: s_positionfrequency = 10; break;
                        case 4: s_positionfrequency = 30; break;
                        default: s_positionfrequency = 0; break;
                        }
                        Settings.setValue("positionfrequency", s_positionfrequency);
                        if(s_positionfrequency == 0) {
                            positionTimer.running = false;
                        }else{
                            positionTimer.running = true;
                        }
                    }
                }
            }
            ListHeading {
                ListItemText {
                    anchors.fill: parent.paddingItem; role: "Heading"
                    text: "关于"
                }
            }
            ListItem {
                id: versionLI
                Column {
                    anchors.fill: versionLI.paddingItem
                    ListItemText {
                        role: "Title"; mode: versionLI.mode
                        text: "版本"
                    }
                    ListItemText {
                        role: "SubTitle"; mode: versionLI.mode
                        text: "1.1.0"
                    }
                }
            }
            ListItem {
                id: authorLI
                Column {
                    anchors.fill: authorLI.paddingItem
                    ListItemText {
                        role: "Title"; mode: authorLI.mode
                        text: "作者"
                    }
                    ListItemText {
                        role: "SubTitle"; mode: authorLI.mode
                        text: "沛秦"
                    }
                }
            }
            ListItem {
                id: feedbackLI
                Column {
                    anchors.fill: feedbackLI.paddingItem
                    ListItemText {
                        role: "Title"; mode: feedbackLI.mode
                        text: "反馈"
                    }
                    ListItemText {
                        role: "SubTitle"; mode: feedbackLI.mode
                        text: "百度贴吧 沛秦吧"
                    }
                }
            }
        }
    }
}
