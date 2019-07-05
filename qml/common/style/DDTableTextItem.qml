import QtQuick 2.0
import QtQuick.Controls 2.1 as Contorl2
import DDui.style 1.0

Item {
    id:rootItem
    property var styleDatas
    property int myColumn: 0
    property var handStylelist: [1,6]
    property var handTipslist: ["浏览高度信息","浏览地址信息"]
    property color myTxtColor
    property var horAlign: Text.AlignHCenter
    signal signalTextClicked(string address,int idx)
    function indexOfX(idx){
        for(var j = 0; j < handStylelist.length; j++) {
            if(handStylelist[j] === idx){
                return true;
            }
        }
        return false;
    }
    function indexOfTipsIdx(idx){
        for(var j = 0; j < handStylelist.length; j++) {
            if(handStylelist[j] === idx){
                return handTipslist[j];
            }
        }
        return "";
    }
    function colorIndex(index,seleted){
        if(indexOfX(index)){
            return hightlight_color;
        }else{
            if(seleted){
                return "#000000";
            }else{
                return text_color ;
            }
        }
    }
    Text {
        anchors.fill: parent
        color:myTxtColor
        elide: styleDatas.elideMode
        text:  styleDatas.value
        font.pixelSize: 12
        horizontalAlignment: horAlign
        verticalAlignment: Text.AlignVCenter
        width: parent.width-4
        wrapMode: Text.WrapAnywhere
    }
    Rectangle{
        height:1
        width: parent.width
        color:  line_color
        anchors.bottom: parent.bottom
    }
    MouseArea{
        id:ma
        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true
        onEntered: {
            if(indexOfX(styleDatas.column)){
                cursorShape= Qt.PointingHandCursor
            }
        }
        onExited: {
            cursorShape= Qt.ArrowCursor
        }
        onClicked: {
            if(indexOfX(styleDatas.column)){
                //console.log("open this option ",styleDatas.value)
                signalTextClicked(styleDatas.value,styleDatas.column);
            }
        }
    }
     Contorl2.ToolTip {
         id: control
         parent:rootItem
         visible: indexOfX(styleDatas.column) && ma.containsMouse
         text: indexOfTipsIdx(styleDatas.column)
         font.pixelSize: 14
         contentItem: Text {
             text: control.text
             font: control.font
             color: hightlight_color
         }
         background: Rectangle {
             border.color: backgroud
             color: backgroud_seleted
             opacity: 0.9
         }
     }
}
