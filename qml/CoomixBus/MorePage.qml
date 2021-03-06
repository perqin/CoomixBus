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
            ListItem {
                //id: alarmOfTime;
                CheckBox {
                    id: alarmOfTime; text: "提前3分钟到站提醒"; checked: s_alarmoftime;
                    anchors.left: parent.paddingItem.left; anchors.verticalCenter: parent.paddingItem.verticalCenter;
                    onClicked: {
                        s_alarmoftime = checked;
                        Settings.setValue("alarmoftime", s_alarmoftime);
                    }
                }
            }
            ListItem {
                //id: alarmOfTime;
                CheckBox {
                    id: alarmOfStation; text: "提前3个站到站提醒"; checked: s_alarmofstation;
                    anchors.left: parent.paddingItem.left; anchors.verticalCenter: parent.paddingItem.verticalCenter;
                    onClicked: {
                        s_alarmofstation = checked;
                        Settings.setValue("alarmofstation", s_alarmofstation);
                    }
                }
            }
            SelectionListItem {
                title: "提醒方式";
                subTitle: alarmSD.model.get(alarmSD.selectedIndex).name;
                onClicked: alarmSD.open();
                SelectionDialog {
                    id: alarmSD
                    titleText: "选择提醒方式"
                    selectedIndex: s_alarmtype
                    model: ListModel {
                        ListElement { name: "仅响提示音" }
                        ListElement { name: "仅震动" }
                        ListElement { name: "响提示音并震动" }
                    }
                    onAccepted: {
                        s_alarmtype = selectedIndex;
                        Settings.setValue("alarmtype", s_alarmtype);
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
                        text: "1.2.1"
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
