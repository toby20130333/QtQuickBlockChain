import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.1 as Control2
import "../../common" as DDCommon
import "./dialog" as DDDialog
Item {
    id:rootWalletPage
    DDNWalletTop{
        id:top
        width: parent.width*2/3
        anchors.horizontalCenter: parent.horizontalCenter
        height: 100
        onSignalAddressChanged: {
            console.log("onSignalAddressChanged: ",address)
        }
        onOpenDialog: {
            console.log("open dialog ",openType);
            popup.open();
        }
    }
    Control2.Popup {
        id: popup
        x: (rootWalletPage.width-800)/2
        y: (rootWalletPage.height-400)/2
        width: 800
        height: 400
        modal: true
        focus: true
        opacity: 0.8
        padding: 2
        closePolicy: Control2.Popup.CloseOnEscape | Control2.Popup.CloseOnPressOutsideParent
        background: DDCommon.DDRectangle {
            id:bg
            implicitWidth: 800
            implicitHeight: 400
            color: backgroud_seleted
        }
        contentItem: DDDialog.DDNWalletImportAddress {
            width: 800
            height: 400
            color: bg.color
            onSignalClosePopUpWindow2: {
                popup.close();
            }
        }
    }
    Rectangle{
        id:hLine
        anchors.top: top.bottom
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: line_color
    }
    DDNWalletMid{
        id:leftBar
        height: parent.height-top.height
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: top.bottom
        anchors.topMargin: 10
        myOrientation: ListView.Vertical
        width: 100
        onSignalChangePages: {
            console.log("DDNWalletMid click page "+index)
            rightPage.createObjBYTab(index)
        }
    }
    Rectangle{
        id:vLine
        anchors.top: top.bottom
        anchors.topMargin: 10
        anchors.left: leftBar.right
        anchors.bottom: parent.bottom
        width: 1
        color: line_color
    }
    DDNStackedPage{
        id:rightPage
        anchors.top: top.bottom
        anchors.topMargin: 10
        anchors.left: vLine.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        qmlArray:["qrc:/qml/apps/wallet/DDNWalletAccount.qml","qrc:/qml/apps/wallet/DDNWalletTrade.qml","qrc:/qml/apps/help/DDNMessageView.qml"]
        Tab {
            title: "区块高度浏览"
            DDNWalletAccount{
                anchors.fill: parent
            }
        }
        Tab {
            title: "Red"
        }
        Tab {
            title: "Blue"
        }
    }
}
