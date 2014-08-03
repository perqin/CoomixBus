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
            ListItem {
                subItemIndicator: true
                ListItemText {
                    role: "Title"; mode: parent.mode
                    anchors.verticalCenter: parent.paddingItem.verticalCenter
                    anchors.left: parent.paddingItem.left
                    text: "公告"
                }
            }
            ListHeading {
                ListItemText {
                    anchors.fill: parent.paddingItem; role: "Heading"
                    text: "候车设置"
                }
            }
            SelectionListItem {
                title: "刷新频率"
                subTitle: refreshSD.model.get(refreshSD.selectedIndex).name
                onClicked: refreshSD.open()
                SelectionDialog {
                    id: refreshSD
                    titleText: "选择刷新频率"
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
                        text: "2.0.0 pre-alpha 版"
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
