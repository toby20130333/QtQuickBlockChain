import QtQuick 2.0
import "../../common" as Common

Rectangle {
   color: backgroud
   Common.DDText{
       id:t
       text: "钱包列表"
       height: 40
       width: parent.width
   }
   DDNWalletAccountItem{
       id:headerId
       anchors.top: t.bottom
       width: parent.width
       height: 40
       isHeader:false
   }
   ListView{
       id:accountList
       width: parent.width
       anchors.left: parent.left
       anchors.top: headerId.bottom
       anchors.bottom: parent.bottom
       delegate: DDNWalletAccountItem{
           id:delegateId
           height: 40
           width: parent.width
           ddnNick:iddnNick
           ddnAddress: iddnAddress
           ddnAmount: iddnAmount
           ddnOption: iddnOption
           ddnLock: iddnLock
           ddnDel: iddnDel
           isHeader:true
       }
       clip: true
       model: ListModel{
           id:accountModel
       }
   }
   Component.onCompleted: {
       for(var i = 0;i<40;i++){
           accountModel.append({"iddnNick": "DDN-Nick "+i,"iddnAddress": "DHF3tqAsmSKzK2g8KLz3BNbfw2MMgAxVTH",
                                   "iddnAmount": "1000"+i,"iddnOption": "默認","iddnLock": "锁仓","iddnDel": "删除","iisHeader":true
                               });
       }
   }
}
