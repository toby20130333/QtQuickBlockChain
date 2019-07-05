import QtQuick 2.0
import DDui.style 1.0
import "./../../common" as Common
Item {
    property string titleId: "title"
    property string  titleContents: "value"
    height: 40
    Row{
        anchors.fill: parent
        anchors.margins: 2
        spacing: 2
        Rectangle{
            height: parent.height
            width: parent.width/3
            border.color: line_color
            color:backgroud
            Common.DDText{
                id: name
                text: titleId
                anchors.fill: parent
                anchors.margins: 4
                horizontalAlignment: Text.AlignLeft
            }
        }
        Rectangle{
            height: parent.height
            width: parent.width*2/3
            border.color:line_color
            color: backgroud
            Common.DDText {
                id: name2
                text: titleContents
                anchors.fill: parent
                anchors.margins: 4
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.ElideMiddle
            }
        }
    }
}
