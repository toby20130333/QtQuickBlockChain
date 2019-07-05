/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1. 主要是动画加上文字的一个自定义按钮
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
import QtQuick.Controls 1.0

Item {
    property int framewidth: 950/10
    property int frameheight: 95
    property int framecount: 10
    property int frameduration: 100
    property url btnurl: "qrc:/images/360/btm/qinglilaji_yijianqingli_Anima_Hover.png"
    property string btmTitle: "电脑清理"
    property int clickType: 0
    signal signalClickedBtn(int clicktype); //0 close 1:min 2:menu 3:feedback
    clip: true

    width: framewidth
    height: frameheight+txtId.height

    MouseArea{
        id:ma
        anchors.fill: animated
        hoverEnabled: true
        onEntered: {
            console.log("onEntered")
            animated.running = true;
            animated.resume();
        }
        onExited: {
            console.log("onExited")
            animated.running = true;
            animated.currentFrame = 0
            animated.pause()
        }
    }
    AnimatedSprite {
        id: animated;
        width:framewidth ;
        height: frameheight;
        source: btnurl;
        frameWidth:framewidth;
        frameHeight: frameheight;
        frameDuration: frameduration;
        frameCount: framecount;
        frameX: 0;
        frameY: 0;
        currentFrame: 0
        onCurrentFrameChanged: {
            //console.log("%1/%2".arg(animated.currentFrame).arg(animated.frameCount));
            if(currentFrame == frameCount-1 ){
                console.log("已结动画完毕，请停止")
                animated.pause();
                animated.running = false;
            }
        }
        Component.onCompleted: {
            running = false;
        }
    }
    DDText{
        id:txtId
        text: btmTitle
        width: parent.width
        height: 30
        anchors.bottom: parent.bottom
    }
}
