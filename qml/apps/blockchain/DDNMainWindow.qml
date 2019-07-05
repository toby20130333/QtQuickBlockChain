import QtQuick 2.0
import DDui.ddn 1.0
import "./pages" as Pages

Rectangle {
    visible: true
    width: 1280
    height: 680
    color: Qt.rgba(Math.random(),Math.random(),Math.random(),1.0)
    //title: qsTr("DDN Block Views")
    DDNTopBar{
        id:top
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 40
    }
    DDNTop{
        id:topBar
        height: parent.height-top.height
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: top.bottom
        myOrientation: ListView.Vertical
        width: 100
        dataModel: ListModel{
            id:dataMo;
            Component.onCompleted: {
                    dataMo.append({blockText:"区块浏览"})
                    dataMo.append({blockText:"行情"})
                    dataMo.append({blockText:"钱包"})
                    dataMo.append({blockText:"消息"})
                    dataMo.append({blockText:"帮助"})
            }
        }
        onSignalChangePage: {
            console.log("click page "+index)
//            if(index==0){
//                signalQmlTocppMoveheigth(100)
//            }else{
//                signalQmlTocppMoveheigth(50)
//            }
//            blockVId.createObjBYTab(index);
        }
    }
    Pages.DDNBlockView{
        id:blockVId
        anchors.top: top.bottom
        anchors.topMargin: 0
        anchors.left: topBar.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}
