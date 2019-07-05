/*********************************************************************************
  *Copyright(C),2017-2019,www.heilqt.com
  *FileName(文件名):  filename
  *Author  (作者):    TobyYi(tanboy@heilqt.com)
  *Version (版本):    1.0.0
  *CreateDate(创建日期):
  *FinishDate(完成日期):
  *Description(描述):
     1.  This is a base root qml view and all requset can trans to C++
   like Qt all signls and slot can be followed by this childrens
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
import DDui.style 1.0

Item {
    id:rootItem
    visible: true
    width: 816
    height: 600
    property double bgMarign: 8
    property var updaterVersion: "0.0.0.1"
    property color backgroud_seleted: DDNSkin.getColorByKey("backgroud-seleted")
    property color alternate_color: DDNSkin.getColorByKey("alternate-color")
    property color seleted_color: DDNSkin.getColorByKey("seleted-color")
    property color text_color: DDNSkin.getColorByKey("text-color")
    property color backgroud: DDNSkin.getColorByKey("backgroud")
    property color line_color: DDNSkin.getColorByKey("line-color")
    property color hightlight_color: DDNSkin.getColorByKey("hightlight-color")
    property color grid_color: DDNSkin.getColorByKey("grid-color")
    property color scrollbar_color: DDNSkin.getColorByKey("scrollbar-color")
    property color section_color: DDNSkin.getColorByKey("section-color")
    //you can emit this signal to c++
    signal signalQmlOptions(variant msg,variant type);
    //signal to all children
    signal signalTransQmlToOther(variant cmd,variant dataVar)
    signal signalTransApiError(variant cmd,variant dataVar);
    signal signalTransJsonData(variant cmd,variant dataVar);
    signal signalNotifyToUi(variant version);
    signal signalQmlTocppMoveheigth(var height)

    function sendToPost(cmd, dataVar) {
        console.log("Sending to post: " + cmd + ", " + dataVar)
    }
    //max and normal window states
    function transToQml(showMax){
        if(showMax){
            bgMarign = 0;
        }else{
            bgMarign = 8;
        }
    }
    function transDataFromToQml( msg, type){
        //
        console.log("msg "+msg+" type "+type);
    }
    function notifyToUi(version){
        console.log("notifyToUi to post",version);
        updaterVersion = version;
        signalNotifyToUi(version);
    }
    MouseArea{
        id:ma
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        property int ix:0
        property int iy:0
        propagateComposedEvents: true
        onPressed:{
            ma.ix = mouseX;
            ma.iy = mouseY;
        }
        onPositionChanged: {
            var dyx = mouseX - ma.ix;
            var dyy = mouseY - ma.iy;
            var arryTmp = [dyx,dyy];
        }
    }
    Connections{
        target: DDNSkin
        onSignalSkinChanged:{
             console.log("skin changed: "+skin);
             backgroud_seleted= DDNSkin.getColorByKey("backgroud-seleted")
             alternate_color= DDNSkin.getColorByKey("alternate-color")
             seleted_color= DDNSkin.getColorByKey("seleted-color")
             text_color= DDNSkin.getColorByKey("text-color")
             backgroud= DDNSkin.getColorByKey("backgroud")
             line_color= DDNSkin.getColorByKey("line-color")
             hightlight_color= DDNSkin.getColorByKey("hightlight-color")
             grid_color= DDNSkin.getColorByKey("grid-color")
             scrollbar_color= DDNSkin.getColorByKey("scrollbar-color")
             section_color= DDNSkin.getColorByKey("section-color")
        }
    }
}
