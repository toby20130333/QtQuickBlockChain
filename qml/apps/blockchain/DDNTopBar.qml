import QtQuick 2.0
import "./../../common" as Common
import "../blockchain/" as BlockChain

import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    color: backgroud
    property var curVersion: ""
    property var verText: qsTr("DDN区块链浏览器 v%1 <font color='%2'>[多多指教出品 QQ群:312125701]</font>")
    .arg(curVersion).arg(hightlight_color)
    Common.DDImage{
            id:logo
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: width
            source: "qrc:/favicon.ico"
    }
    Common.DDText {
        anchors.left: logo.right
        anchors.leftMargin: 4
        anchors.top: parent.top
        width: parent.width*2/3
        height: parent.height
        color:text_color
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide:Text.ElideMiddle
        renderType: Text.NativeRendering
        text:verText
    }
    Common.DDNButton{
        id:versionBtn
        text:"下载新版本"
        height: 36
        width: 100
        anchors.right: skinId.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 1
        visible: false
        btnColor:backgroud
        textColor: seleted_color
        onClicked: {
            signalTransQmlToOther("opendownloadurl","")
        }
    }
    BlockChain.DDNSkinBox{
        id:skinId
        width: 100
        height: 30
        anchors.right: closeId.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 1
    }
    Common.DDCloseButton{
        id:closeId
        height: 24
        width: 24
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.rightMargin: 1
        anchors.right: parent.right
        onSignalCloseThisPage: {
            signalQmlOptions("system","close")
        }
    }
    Rectangle{
        id:line
        width: parent.width
        height: 1
        color: line_color
        anchors.bottom: parent.bottom
    }
    Connections{
        target: driverUi
        onSignalNotifyToUi:{
            versionBtn.visible =( version != updaterVersion );
            updaterVersion = version;
            if(curVersion==""){
                curVersion = updaterVersion
            }
        }
    }
}
