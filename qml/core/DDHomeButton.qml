/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.用于主要说明此程序文件完成的主要功能
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

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../common" as DDCommon
import "../js/appthemejs.js" as DDTheme

DDCommon.DDRectangle {
    id:btnRect
    width: 100
    height: 100
    color: "transparent"
    property url btnUrl: "http://download.easyicon.net/png/1194626/72/"
    property string btnTxt: "Home"
    property int ftSize: 16
    property bool systemBtn: false
    signal signalBtnClicked(string btn);
    MouseArea{
        id:ma
        anchors.fill: btnRect
        hoverEnabled: true
        onClicked: {
            signalBtnClicked(btnTxt);
        }
        onEntered: {
            btnRect.opacity=0.5;
            btnRect.color=DDTheme.app_seletedColor
            btnRect.border.width= !systemBtn?1:0
            btnRect.radius =  !systemBtn?3:0;
            btnRect.border.color="#009AD3";
        }
        onExited: {
            btnRect.opacity=1.0
            btnRect.radius = 0;
            btnRect.color="transparent"
            btnRect.border.width=0
            btnRect.border.color="transparent";
        }
    }
    DDCommon.DDImage {
        id: icon
        width: !systemBtn?btnRect.width*0.64:parent.width
        height: width
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        source: btnUrl
    }
    DDCommon.DDText {
        id: btntext
        anchors.horizontalCenter: parent.horizontalCenter
        width:  !systemBtn?btnRect.width*0.90:0
        anchors.top: icon.bottom
        anchors.topMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        text: btnTxt
        visible: !systemBtn
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: DDTheme.textWhiteColor
        font.pixelSize: ftSize
    }
}
