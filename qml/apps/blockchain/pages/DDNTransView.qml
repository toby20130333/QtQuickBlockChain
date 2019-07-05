import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import DDui.ddn 1.0
import "./../../../common/style" as DDNStyle
import "./../../../common/" as Common


DDNStyle.DDTableStyleView {
    id:roowView
    property int scrollbarWidth : 10
    signal signalHeightClicked(int height);
    signal signalAddressClicked(string address)
    signal signalCommonToBlocksPage(int type,var values);
    itemDelegate: DDNStyle.DDTableTextItem{
        id:txtItem
        styleDatas:styleData
        handStylelist: [0,1,5,6]
        handTipslist: ["交易Id","高度信息","发送者信息","接收者信息"]
        myTxtColor:txtItem.colorIndex(styleData.column,styleData.seleted)
        onSignalTextClicked: {
            console.log("click in trans "+address)
            if(idx == 1){
                signalHeightClicked(address)
            }else if(idx == 6){
                signalAddressClicked(address)
            }
            DDTextImpWidth.signalCommonToBlocksPage("trans","block",idx,address);
        }
    }
    rowDelegate: DDNStyle.DDRowDelegate{
        height:80
    }
    headerDelegate: DDNStyle.DDHeaderStyle{
        headerText: styleData.value
        columnIndx:styleData.column
    }
    TableViewColumn {
        id:checkedColumn
        role: "id"
        title: "区块ID"
        width: roowView.width/7
    }
    TableViewColumn {
        id:comBoxId
        role: "height"
        title: "高度"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "transType"
        title: "交易类型"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "totalAmount"
        title: "总金额"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "totalFee"
        title: "总费用"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "senderId"
        title: "发起者"
        width: roowView.width/9
    }

    TableViewColumn {
        role: "receviId"
        title: "接收者"
        width: roowView.width/7
    }
    TableViewColumn {
        role: "timestamp"
        title: "日期"
        width: roowView.width- (2/7*roowView.width)-(5/9*roowView.width)-20
    }
    model: mTransModel
    function setModel(alljson){
        var obj = JSON.parse(alljson); //由JSON字符串转换为JSON对象
        var dataArr = obj.transactions;
        for(var i=0;i<dataArr.length;i++){
            mTransModel.addObject(dataArr[i]);
        }
    }
}
