/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.自定义进度条样式
     2.与其他模块或函数的接口、输出值、取值范围、含义及参数间的控制、顺序、独立及依赖关系

  *Others(其他内容说明):
       others
  *Function List(函数列表):
     1.主要函数列表，每条记录应包含函数名及功能简要说明

     2.
  *History(历史修订记录):
     1.Date: 修改日期
       Author:修改者
       Modification:修改内容简介

     2.

**********************************************************************************/
import QtQuick 2.1

Item{
    id:closeBtn
    width: txtId.width
    height: btnImg.height+txtId.height+6
    property int hasMouse: 0
    property bool reallysigle: false
    property url btnurl: "qrc:/images/360/main/security_safe_"
    property string btmTitle: "电脑清理"
    property color text_color: "white"
    signal signalCloseApp();
    MouseArea{
        id:ma
        anchors.fill: closeBtn
        hoverEnabled: true
        onClicked: {
            closeBtn.hasMouse = 2;
            signalCloseApp();
        }
        onEntered: {
            closeBtn.hasMouse = 1;
        }
        onExited: {
            closeBtn.hasMouse = 0;
        }
    }
     DDImage{
        id: btnImg
        width: sourceSize.width
        height: sourceSize.height
        anchors.horizontalCenter: parent.horizontalCenter
        source: btnurl+getimgurl();
        opacity: !hasMouse?0.8:1
    }
     DDText{
         id:txtId
         text: btmTitle
         height: 20
         color: text_color
         font.pixelSize: 12
         width: reallysigle?btnImg.sourceSize.width:paintedWidth
         anchors.bottom: parent.bottom
     }

     function getimgurl(){
         if(reallysigle)return "";
         return hasMouse==0?"normal.png":(hasMouse==1)?"hover.png":"press.png"
     }
}
