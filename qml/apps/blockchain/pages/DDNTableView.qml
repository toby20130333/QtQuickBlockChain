import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "./../../../common/style" as DDNStyle

DDNStyle.DDTableStyleView{
    id:roowView
    clip: true
    property int scrollbarWidth : 10
    signal signalHeightClicked(int height);
    signal signalAddressClicked(string address)
    itemDelegate: DDNStyle.DDTableTextItem{
        id:txtItem
        styleDatas:styleData
        handStylelist: [1,6]
        myTxtColor:txtItem.colorIndex(styleData.column,styleData.seleted)
        onSignalTextClicked: {
            if(idx == 1){
                signalHeightClicked(address)
            }else if(idx == 6){
                signalAddressClicked(address)
            }
        }
    }
    rowDelegate: DDNStyle.DDRowDelegate{
        height:80
    }
    headerDelegate: DDNStyle.DDHeaderStyle{
        headerText: styleData.value
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
        role: "numberOfTransactions"
        title: "交易数目"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "totalAmount"
        title: "总金额"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "reward"
        title: "奖励"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "totalFee"
        title: "总费用"
        width: roowView.width/9
    }
    TableViewColumn {
        role: "generatorId"
        title: "锻造者"
        width: roowView.width/7
    }
    TableViewColumn {
        role: "timestamp"
        title: "日期"
        width: roowView.width- (2/7*roowView.width)-(5/9*roowView.width)-20
    }
    model: mTableModel
    function setModel(alljson){
        var obj = JSON.parse(alljson); //由JSON字符串转换为JSON对象
        var dataArr = obj.blocks;
        for(var i=0;i<dataArr.length;i++){
            mTableModel.addObject(dataArr[i]);
        }
    }
}
