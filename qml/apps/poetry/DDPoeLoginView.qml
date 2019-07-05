import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

import "../../core" as DDCore
import "../../common" as Common
Rectangle{
    id:root
    Common.DDCloseButton{
        id:close
        anchors.top: parent.top
        anchors.right: parent.right
        onSignalCloseThisPage: {
            signalQmlOptions("system","close")
        }
    }
    Rectangle  {
        id:bgColor
        width: parent.width
        anchors.margins: 0
        height: parent.height-180
        anchors.bottom: parent.bottom
        color: "#ffffff"
    }
    Common.DDText{
        id:textName
        text: "寒山-居士"
        color: hightlight_color
        anchors.top: parent.top
        width: parent.width
        height: 100
    }
    Common.DDCustomHeaderImage{
        id:header
        anchors.top:textName.bottom
        anchors.topMargin: -10
        width: 128
        height: width
        mystroke: backgroud
        canvasimg: "qrc:/img/128.png"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    DDUserInputView{
        id:loginEdit
        width: parent.width*2/3
        height: 100
        radius: 5
        border.width: 1
        border.color: grid_color
        color: bgColor.color
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: loginBtn.top
        anchors.bottomMargin: 50
        icon2Url: "qrc:/img/password.png"
    }
    Common.DDCustomButton {
        id:loginBtn
        anchors.bottom: newReg.top
        anchors.bottomMargin: 20
        width: root.width*2/3
        height: 46
        anchors.horizontalCenter: parent.horizontalCenter
        normalColor:backgroud_seleted
        onClicked: {
            var lst = loginEdit.getUserNameAndPws();
            if(lst.length !=2)return;
            if(lst[0] =="" || lst[1] == ""){
                console.log("must be input username and pws");
                signalTransQmlToOther("msg",["用户和密码不能为空","错误提示"])
                return;
            }
            driverUi.changePageToDDN();
        }
    }
    Common.DDText{
        id:newReg
        text: "新用户注册"
        font.pixelSize: 12
        color: hightlight_color
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        width: parent.width
        height: 20
    }
}
