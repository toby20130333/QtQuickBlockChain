import QtQuick 2.0
import "../../../common" as Common
import "../../poetry/" as Poetry

Item {
    signal signalToStepTwo(var data);
    Poetry.DDUserInputView{
        id:loginEdit
        anchors.top: parent.top
        anchors.topMargin: 10
        width: parent.width*3/4
        height: 100
        radius: 0
        border.width: 0
        border.color: grid_color
        color:"transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        icon2Url: "qrc:/img/password.png"
        userPlace:"请设置交易密码(至少8个字符以上)"
        pwdPlace:"请重复输入交易密码"
        isechoMode:true
        txtColor2:"white"
        placehTextColor2:"white"
        Common.DDRectangle{
            width: parent.width
            height: 1
            color: line_color
            anchors.bottom: parent.bottom
        }
    }
    Common.DDCustomButton {
        id:loginBtn
        anchors.top: loginEdit.bottom
        anchors.topMargin: 30
        width: 130
        height: 38
        btnRadius:2
        anchors.horizontalCenter: parent.horizontalCenter
        normalColor:scrollbar_color
        btnText:"生成主秘钥"
        onClicked: {
            if(!loginEdit.isVaild()){
                console.log("error input.......................");
                return;
            }
            signalToStepTwo(getData());
        }
    }
    function getData(){
        var data = loginEdit.getUserNameAndPws();
        return data;
    }
}
