/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.自定义按钮
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
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

Button {
    id:loginBtn
    property string btnText: "登 录"
    property color normalColor: "#7FB5F5"
    property color pressColor: "#83BDFC"
    property color textColor: "#ffffff"
    property int btnRadius: 25
    property int fontSize: 14

    style: ButtonStyle {
        background: Rectangle {
            implicitWidth: loginBtn.width
            implicitHeight: loginBtn.height
            color: control.pressed?pressColor:normalColor
            radius: btnRadius
        }
        label: DDText{
            text: btnText
            font.pixelSize: fontSize
            color: textColor
        }
    }
}
