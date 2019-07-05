import QtQuick 2.0
import DDui.style 1.0

Item{
    width: 24
    height: 24
    signal signalCloseThisPage();
    Canvas {
        id: mycanvas
        anchors.fill: parent
        anchors.margins: 2
        onPaint: {
            var ctx = getContext("2d");
            ctx.fillStyle = !ma.containsMouse?backgroud:"#F74C31"
            ctx.fillRect(0, 0, width, height);
            ctx.lineWidth = 1;
            ctx.strokeStyle = '#ffffff';
            ctx.moveTo(1, 1);
            ctx.lineTo(width-1, height-1);
            ctx.stroke();
            ctx.strokeStyle = '#ffffff';
            ctx.moveTo(1, height-1);
            ctx.lineTo(width-1, 1);
            ctx.stroke();
        }
    }
    MouseArea{
        id:ma
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            mycanvas.requestPaint()
        }
        onExited: {
            mycanvas.requestPaint()
        }
        onClicked: {
            signalCloseThisPage()
        }
    }
    Connections{
        target: DDNSkin
        onSignalSkinChanged:{
            mycanvas.requestPaint()
        }
    }
}
