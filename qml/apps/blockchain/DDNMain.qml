import QtQuick 2.0
import DDui.ddn 1.0
import "./pages" as Pages

Rectangle {
    visible: true
    width: 1280
    height: 680
    DDNTop{
        id:topBar
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 40
        onSignalChangePage: {
            console.log("click page "+index)
//            if(index==0){
//                signalQmlTocppMoveheigth(100)
//            }else{
//                signalQmlTocppMoveheigth(50)
//            }
            blockVId.createObjBYTab(index);
        }
    }
    Pages.DDNBlockView{
        id:blockVId
        anchors.top: topBar.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
    AnimatedImage {
        id: loadImg
        source: DDTextImpWidth.imageAbsPath("loading.gif")
        visible: loadImg.state === Image.Ready
        playing: visible
        anchors.centerIn: blockVId
    }
    Connections {
        target: ddnObject
        onSignalData: {
            loadImg.visible = false;
        }
        onSignalRequest:{
            loadImg.visible = true;
        }
    }
}
