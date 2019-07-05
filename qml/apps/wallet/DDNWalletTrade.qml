import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "../blockchain/" as BlockChain
import "../../common" as Common

Common.DDRectangle {
   BlockChain.DDNTop{
       id:topBar
       signal signalChangePages(int index)
       width: parent.width
       height: 40
       isAccountType:true
       dataModel: ListModel{
           id:dataMo;
           Component.onCompleted: {
                   dataMo.append({blockText:"發送"})
                   dataMo.append({blockText:"接收"})
           }
       }
       onSignalChangePage: {
           rightPage.createObjBYTab(index);
       }
   }
   DDNStackedPage{
       id:rightPage
       anchors.top: topBar.bottom
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.bottom: parent.bottom
       qmlArray:["qrc:/qml/apps/wallet/DDNWalletSender.qml","qrc:/qml/apps/wallet/DDNWalletRecieve.qml"]
       Tab {
           title: "区块高度浏览"
           DDNWalletSender{
               anchors.fill: parent
           }
       }
       Tab {
           title: "Red"
       }
   }
}
