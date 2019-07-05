import QtQuick 2.7
import DDui.style 1.0
import DDui.ddn 1.0

import QtQuick.Controls 2.1

ComboBox {
    id: control
    property bool addIcon: true
//    model: DDNSkin.getAllTagsSkins()
    onActivated: {
//        DDNSkin.changeSkin(currentText)
//        control.displayText = currentText;
    }
    font.pixelSize: 12
    delegate: ItemDelegate {
        width: control.width
        height: 30
        contentItem: Text {
            text: modelData
            color: control.down?text_color:backgroud
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 30
            opacity: enabled ? 1 : 0.8
            color: !control.down ?line_color: backgroud_seleted;
            Rectangle {
                width: parent.width
                height: 1
                color: !control.down ? line_color: backgroud;
                anchors.bottom: parent.bottom
            }
        }
        highlighted: control.highlightedIndex === index
    }
    indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"
        Connections {
            target: control
            onPressedChanged: canvas.requestPaint()
        }
        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = control.pressed ? line_color: text_color;
            context.fill();
        }
    }
    contentItem:Item{
        Image {
            id: theme
            source: "qrc:/img/theme.png"
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            visible: addIcon
        }
        Text {
            leftPadding: 24
            rightPadding: control.indicator.width + control.spacing
            text: control.displayText
            font: control.font
            color: text_color
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            height: parent.height
        }
    }
    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 30
        border.color: control.pressed ?grid_color : "transparent"
        color: "transparent"
    }
    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
            ScrollIndicator.vertical: ScrollIndicator { }
        }
        background: Rectangle {
            border.color: line_color
            color: backgroud_seleted
            radius: 2
        }
    }
}
