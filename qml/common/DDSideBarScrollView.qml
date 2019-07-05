import QtQuick 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Private 1.0
import DDui.style 1.0
ScrollViewStyle {
    id : scrollview
    property int scrollbarWidth : 8
    scrollBarBackground : Item {
        implicitWidth: scrollview.scrollbarWidth
        implicitHeight: scrollview.scrollbarWidth
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
        implicitWidth: styleData.horizontal ? 66 : scrollview.scrollbarWidth
        implicitHeight: styleData.horizontal ? scrollview.scrollbarWidth : 66
        color :DDNSkin.getColorByKey("scrollbar_color")
        radius : scrollview.scrollbarWidth
        states: [
            State {
                name: "clicked"
                when : styleData.pressed
                PropertyChanges {target: theRect; opacity : 1}
            }
        ]
        transitions: Transition {
            PropertyAnimation { properties: "opacity"; easing.type: Easing.InOutQuad; duration: 500 }
        }
    }
    incrementControl: Item {
        visible : false
        implicitWidth: 0
        implicitHeight: 0
    }
    decrementControl: Item {
        visible : false
        implicitWidth: 0
        implicitHeight: 0
    }
    corner: Rectangle { color: "transparent";visible : false }
    MouseArea{
        id : behaviours
        anchors.fill : parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton;
        onEntered: {
            scrollview.__verticalScrollBar.visible = true;
        }
        onExited: {
            if (((scrollview.width-mouseX)<=scrollview.scrollbarWidth*2) || (Math.abs(scrollview.height-mouseY)<=scrollview.scrollbarWidth*2)){
                // do nothing
            } else {
                scrollview.__verticalScrollBar.visible = false;
            }

        }
        Timer {
            interval: 1000
            running: !behaviours.containsMouse
            repeat: true
            onTriggered:{
                //scrollview.__verticalScrollBar.visible = false;
            }
        }
    }
}


