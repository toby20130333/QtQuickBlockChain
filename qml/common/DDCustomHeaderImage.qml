/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.自定义圆形头像
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
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.0

Item {
    id:mainRect
    width: 72
    height: 72
    property string canvasimg: "qrc:/image/mainui/4.png"
    property color mystroke: "#D74F37"
    Canvas {
        id: canvas
        width: parent.width; height: parent.height
        property real hue: 0.0
        onPaint: {
              var ctx = getContext("2d")
                    ctx.lineWidth = 2
                    // store current context setup
                    ctx.save()
                    ctx.strokeStyle = mystroke;
                    ctx.beginPath()
                    ctx.arc(mainRect.width/2, mainRect.height/2, mainRect.width/2, 0, Math.PI * 2, true);
                    ctx.closePath()
                    ctx.clip()  // create clip from triangle path
                    // draw image with clip applied
                    ctx.drawImage(canvasimg, 0, 0)
                    // draw stroke around path
                    ctx.closePath()
                    ctx.stroke()
                    // restore previous setup
                    ctx.restore()
                }
                Component.onCompleted: {
                    loadImage(canvasimg)
                }
    }
    function repaintUI()
    {
        canvas.requestPaint();
    }
}

