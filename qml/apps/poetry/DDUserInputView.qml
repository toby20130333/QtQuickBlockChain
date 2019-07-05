import QtQuick 2.0
import "../../common" as DDCm

Rectangle{
    id:loginEdit
    signal signalTextChanged();
    property url iconUrl: "qrc:/img/account.png"
    property url icon2Url: "qrc:/img/account.png"
    property color txtColor2: "#6A6869"
    property string userPlace:  "用户名/邮箱"
    property string pwdPlace:  "密码"
    property bool isechoMode: false
    property color placehTextColor2:line_color
    width: 300
    height: 100
    radius: 4
    border.width: 1
    border.color: "#B4D6F9"
    color: parent.color
    smooth: true
    DDCm.DDImage{
        id:userImg
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: userName.verticalCenter
        height: 16
        width: height
        source: iconUrl
    }
    DDCm.DDTextInput{
       id:userName
       maximumLength:isechoMode?16:20
       placeText:userPlace
       anchors.top: loginEdit.top
       anchors.bottom: line.bottom
       width: parent.width-46
       anchors.left: userImg.right
       anchors.leftMargin: 10
       anchors.horizontalCenter: parent.horizontalCenter
       horizontalAlignment: Text.AlignLeft
       echoMode:isechoMode?TextInput.Password:TextInput.Normal
       txtColor:txtColor2
       placehTextColor:placehTextColor2
       onTextChanged: {
         checkTxt();
       }
    }
    Rectangle{
        id:line
        anchors.centerIn: parent
        height: 1
        width: parent.width
        color: line_color
    }
    DDCm.DDImage{
        id:pswImg
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: password.verticalCenter
        height: 16
        width: height
        source: icon2Url
    }
    DDCm.DDTextInput{
        id:password
        placeText: pwdPlace
        maximumLength:16
        anchors.bottom: loginEdit.bottom
        anchors.top:  line.top
        width: parent.width-46
        anchors.left: pswImg.right
        anchors.leftMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
        echoMode:TextInput.Password
        txtColor:txtColor2
        placehTextColor:placehTextColor2
        onTextChanged: {
          checkTxt();
        }
    }
    function getUserNameAndPws(){
        return [userName.text,password.text]
    }
    function checkTxt(){
        if(password.text !="" && userName.text !=""){
            signalTextChanged()
        }
    }
    function isVaild(){
        if(password.text !="" && userName.text !=""){
            return true;
        }
        return false;
    }
}
