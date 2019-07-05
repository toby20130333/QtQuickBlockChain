import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import DDui.style 1.0
import "../../common" as Common

Rectangle {
    id:rootListBtn
    signal signalChangePage(int index);
    color:backgroud
    property var myOrientation:ListView.Horizontal
    property var dataModel:ListModel{}
    property bool isAccountType: false
    Component{
        id:blocksDelegate
        Common.DDNButton{
            text:blockText
            height: 40
            width: {
                (myOrientation ==ListView.Horizontal && isAccountType)?
                            rootListBtn.width/dataModel.count:
                            (myOrientation ==ListView.Horizontal?100:rootListBtn.width)
            }
            btnColor: (blocksView.currentIndex != index)?backgroud
                                                        :backgroud_seleted
            textColor:(blocksView.currentIndex != index)?seleted_color
                                                        :text_color
            onClicked: {
                if(blocksView.currentIndex == index)return;
                blocksView.currentIndex = index;
                signalChangePage(index);
            }
        }
    }
    ListView{
        id:blocksView
        anchors.fill: parent
        orientation:myOrientation
        boundsBehavior: Flickable.StopAtBounds
        model: dataModel
        delegate:blocksDelegate
    }
    Component.onCompleted: {
        if(dataModel.count==0){
            dataModel.append({blockText:"区块"})
            dataModel.append({blockText:"交易"})
            dataModel.append({blockText:"节点"})
            dataModel.append({blockText:"账户"})
            dataModel.append({blockText:"委托人"})
            dataModel.append({blockText:"工业部消息"})
        }
    }
    function setCurrentBtn(index){
        blocksView.currentIndex = index;
    }
}
