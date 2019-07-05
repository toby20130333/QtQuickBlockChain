import QtQuick 2.0
import QtQuick.Controls 1.2 as Contorl1
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 2.0
import "./" as Home
//import "./../common" as DDDCommon
import DDui.style 1.0

Contorl1.TableView {
    id:roowView
    clip: true
    property int scrollbarWidth : 10
    horizontalScrollBarPolicy: Qt.ScrollBarAsNeeded
    itemDelegate: Home.DDTableTextItem{
      styleDatas:styleData
    }
    rowDelegate: Home.DDRowDelegate{
    }
    headerDelegate: Home.DDHeaderStyle{
            headerText: styleData.value
            columnIndx:styleData.column
    }
    style : TableViewStyle{
        scrollBarBackground : Item {
            implicitWidth: roowView.scrollbarWidth
            implicitHeight: roowView.scrollbarWidth
            visible : true
            Item {
                anchors.fill: parent
                anchors.rightMargin: styleData.horizontal ? -2 : -1
                anchors.leftMargin: styleData.horizontal ? -2 : 0
                anchors.topMargin: styleData.horizontal ? 0 : -2
                anchors.bottomMargin: styleData.horizontal ? -1 : -2
            }

        }
        handle: Rectangle{
            id : theRect
            opacity: 0.8
            implicitWidth: styleData.horizontal ? 66 : roowView.scrollbarWidth
            implicitHeight: styleData.horizontal ? roowView.scrollbarWidth : 66
            color : scrollbar_color
            radius : roowView.scrollbarWidth
            states: [
                State {
                    name: "clicked"
                    when : styleData.pressed
                    PropertyChanges {target: theRect; opacity : 1}
                },
                State{
                    name: "hovered"
                    when : styleData.hovered
                    PropertyChanges {target: theRect; opacity : 0.6}
                }

            ]
            transitions: Transition {
                PropertyAnimation { properties: "opacity"; easing.type: Easing.InOutQuad; duration: 500 }
            }
        }
        incrementControl: Rectangle {
            visible : false
            implicitWidth: 0
            implicitHeight: 0
            color : "blue"
        }
        decrementControl: Rectangle {
            visible : false
            implicitWidth: 0
            implicitHeight: 40
            color : "blue"
        }
        corner: Rectangle { color: "transparent";visible : false }
        frame:Rectangle{
            color: backgroud
        }
        highlightedTextColor:"transparent"
        textColor:"transparent"
    }
}

