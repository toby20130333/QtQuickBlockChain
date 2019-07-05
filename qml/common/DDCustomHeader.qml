import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.0

Item {
    id:mainRect
    width: 72
    height: 72
    property string canvasimg: "qrc:/image/mainui/4.png"
    property color mystroke: "#D74F37"
    Canvas {
        id: canvas
        width: parent.width; height: parent.height
        property real hue: 0.0
        onPaint: {
              var ctx = getContext("2d")
                    ctx.lineWidth = 2
                    // store current context setup
                    ctx.save()
                    ctx.strokeStyle = mystroke;
                    ctx.beginPath()
                    ctx.arc(mainRect.width/2, mainRect.height/2, mainRect.width/2, 0, Math.PI * 2, true);
                    ctx.closePath()
                    ctx.clip()  // create clip from triangle path
                    // draw image with clip applied
                    ctx.drawImage(canvasimg, 0, 0)
                    // draw stroke around path
                    ctx.closePath()
                    ctx.stroke()
                    // restore previous setup
                    ctx.restore()
                }
                Component.onCompleted: {
                    loadImage(canvasimg)
                }
    }
    function repaintUI()
    {
        canvas.requestPaint();
    }
}

