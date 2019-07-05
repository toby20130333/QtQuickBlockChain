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

import QtQuick 2.3
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0
import "./" as DDCommon

ProgressBarStyle{
    property color outerbordercolor: control.value<=0.8? "#FFE655" :"#B2FF77"
//    property color innerbordercolor: "#B2FF77"
//    property color conicalcolor: "red"

   panel : DDCommon.DDRectangle
   {
      color: "transparent"
      implicitWidth: 80
      implicitHeight: implicitWidth
      DDCommon.DDRectangle
      {
         id: outerRing
         z: 0
         anchors.fill: parent
         radius: Math.max(width, height) / 2
         color: "transparent"
         border.color: outerbordercolor
         border.width: 4
      }

      DDCommon.DDRectangle
      {
         id: innerRing
         z: 1
         anchors.fill: parent
         anchors.margins: (outerRing.border.width - border.width) / 2
         radius: outerRing.radius
         color: "transparent"
         border.color: outerbordercolor
         border.width: 1

         ConicalGradient
         {
            source: innerRing
            anchors.fill: parent
            gradient: Gradient
            {
               GradientStop { position: 0.00; color: outerbordercolor }
               GradientStop { position: control.value; color: outerbordercolor }
               GradientStop { position: control.value + 0.01; color: "transparent" }
               GradientStop { position: 1.00; color: "transparent" }
            }
         }
      }

      DDText
      {
         id: progressLabel
         anchors.centerIn: parent
         color: "white"
         text: (control.value * 100).toFixed()
         font.pixelSize: 66
         font.family: "Comic Sans MS"
         DDText
         {
            id: scoreTxt
            anchors.left: parent.right
            anchors.bottom: parent.bottom
            color: "white"
            text:"分"
            font.pixelSize: 14
         }
      }
   }
}
