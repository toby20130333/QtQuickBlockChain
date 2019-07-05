import QtQuick 2.0
import "../../common" as DDCommon

Item {
    DDNWalletTransHeader{
        id:headerId
        anchors.top: parent.top
        width: parent.width
        height: 40
        isHeader:true
        ddnNick: "ID"
        ddnAddress: "类型"
        ddnAmount: "手续费(DDN)"
        ddnOption: "详情"
        ddnLock: "时间"
        ddnDel: "备注"
    }
    ListView{
        id:accountList
        width: parent.width
        anchors.left: parent.left
        anchors.top: headerId.bottom
        anchors.bottom: parent.bottom
        delegate: DDNWalletTransHeader{
            id:delegateId
            height: 40
            width: parent.width
            ddnNick:iddnNick
            ddnAddress: iddnAddress
            ddnAmount: iddnAmount
            ddnOption: iddnOption
            ddnLock: iddnLock
            ddnDel: iddnDel
            isHeader:false
        }
        clip: true
        model: ListModel{
            id:accountModel
        }
    }
    Component.onCompleted: {
        for(var i = 0;i<10;i++){
            accountModel.append({"iddnNick": "d1289281abcdef212"+i,"iddnAddress": "转账",
                                    "iddnAmount": "2000"+i,"iddnOption": "转账生活费用","iddnLock": "2018年5月28日13:47:46","iddnDel": "转费用转账","iisHeader":true
                                });
        }
    }
}
