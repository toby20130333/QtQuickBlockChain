import QtQuick 2.0
import DDui.style 1.0

Rectangle{
    property var headerText: "Header"
    property int columnIndx: 0
    property var horAlign: Text.AlignHCenter
    color:section_color
    Text {
        anchors.fill: parent
        text: headerText
        color:text_color
        horizontalAlignment: horAlign
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 16
    }
    height: 40
    Rectangle{
        height:1
        width: parent.width
        color: line_color
        anchors.bottom: parent.bottom
    }
    Rectangle{
        height:parent.height
        width: visible?0:1
        visible: columnIndx!=0
        color: line_color
        anchors.left:  parent.left
    }
}
