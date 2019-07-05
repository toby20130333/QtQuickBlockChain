import QtQuick 2.0
import "../../../common" as Common
import "../../poetry/" as Poetry
import QtQuick.Layouts 1.3
Item {
    signal signalToStepXX(bool isNext,var data);
    Poetry.DDUserInputView{
        id:loginEdit
        width: parent.width*3/4
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        height: 100
        radius: 0
        border.width: 0
        border.color: grid_color
        color:"transparent"
        icon2Url: "qrc:/img/password.png"
        userPlace:"请输入英文字符串"
        pwdPlace:"请输入您的交易密码"
        placehTextColor2:"white"
        isechoMode:true
        txtColor2:"white"
        Common.DDRectangle{
            width: parent.width
            height: 1
            color: line_color
            anchors.bottom: parent.bottom
        }
    }
    Row{
        spacing: 30
        height: 40
        width: parent.width/2
        anchors.top: loginEdit.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        Common.DDCustomButton {
            id:loginBtn1
            width: 130
            height: 38
            normalColor:scrollbar_color
            btnText:"上一步"
            onClicked: {
                signalToStepXX(false,"");
            }
        }
        Common.DDCustomButton {
            id:loginBtn
            width: 130
            height: 38
            normalColor:scrollbar_color
            btnText:"生成主秘钥"
            onClicked: {
                if(!loginEdit.isVaild()){
                    console.log("error input.......................");
                    return;
                }
                signalToStepXX(true,getData());
            }
        }
    }
    function getData(){
        var data = loginEdit.getUserNameAndPws();
        return data;
    }
}
