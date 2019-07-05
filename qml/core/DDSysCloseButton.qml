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

import QtQuick 2.1
import "../common" as DDCommon

DDCommon.DDRectangle{
    id:closeBtn
    width: 27
    height: 22
    property bool hasMouse: false
    property string statusN: ""
    property string imgUrl: "qrc:/images/close"+statusN+".png"
    color:hasMouse?"#D44027": "transparent"
    signal signalCloseApp();
    MouseArea{
        id:ma
        anchors.fill: closeBtn
        hoverEnabled: true
        onClicked: {
            statusN = "_pressed";
            signalCloseApp();
        }
        onEntered: {
            statusN = "_hover"
            closeBtn.hasMouse = true;
        }
        onExited: {
            statusN = "";
            closeBtn.hasMouse = false;
        }
    }
    DDCommon.DDImage {
        id: btntext
        anchors.fill: parent
        source: imgUrl
    }
}
