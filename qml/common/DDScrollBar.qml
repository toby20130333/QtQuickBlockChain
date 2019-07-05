/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1. 自定义滚动条 实现滚动时候出现 停止滚动消失
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
import "./" as DDCommon

Item {
    id: scrollbar_color

    // The properties that define the scrollbar's state.
    // position and pageSize are in the range 0.0 - 1.0.  They are relative to the
    // height of the page, i.e. a pageSize of 0.5 means that you can see 50%
    // of the height of the view.
    // orientation can be either Qt.Vertical or Qt.Horizontal
    property real position
    property real pageSize
    property variant orientation : Qt.Vertical
    property string scrollColor: "black"
    property string scrollbackgroup: "white"

    // A light, semi-transparent background
    DDCommon.DDRectangle {
        id: background
        anchors.fill: parent
        radius: orientation == Qt.Vertical ? (width/2 - 1) : (height/2 - 1)
        color: scrollbackgroup
        opacity: 0.3
    }

    // Size the bar to the required size, depending upon the orientation.
    DDCommon.DDRectangle {
        x: orientation == Qt.Vertical ? 1 : (scrollbar_color.position * (scrollbar_color.width-2) + 1)
        y: orientation == Qt.Vertical ? (scrollbar_color.position * (scrollbar_color.height-2) + 1) : 1
        width: orientation == Qt.Vertical ? (parent.width-2) : (scrollbar_color.pageSize * (scrollbar_color.width-2))
        height: orientation == Qt.Vertical ? (scrollbar_color.pageSize * (scrollbar_color.height-2)) : (parent.height-2)
        radius: orientation == Qt.Vertical ? (width/2 - 1) : (height/2 - 1)
        color: scrollColor
        opacity: 0.7
    }
}
