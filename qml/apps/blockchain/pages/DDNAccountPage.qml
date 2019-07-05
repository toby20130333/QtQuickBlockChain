import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "./../../../common/style" as DDNStyle

DDNStyle.DDTableStyleView {
    id:roowView
    Connections {
        target: ddnObject
        onSignalData: {
            if(json!="" && type == 4){
                console.log("The accounts data changed!",json.length)
                roowView.setModel(json)
            }
        }
    }
    itemDelegate: DDNStyle.DDTableTextItem{
        id:txtItem
        styleDatas:styleData
        horAlign:Qt.AlignLeft
        handStylelist: []
        myTxtColor:txtItem.colorIndex(styleData.column,styleData.seleted)
    }
    rowDelegate: DDNStyle.DDRowDelegate{
        height:40
    }
    headerDelegate: DDNStyle.DDHeaderStyle{
        headerText: styleData.value
        columnIndx:styleData.column
        horAlign: Qt.AlignLeft
    }

    TableViewColumn {
        id:checkedColumn
        role: "address"
        title: "钱包地址"
        width: roowView.width/3
    }
    TableViewColumn {
        id:comBoxId
        role: "amount"
        title: "余额"
        width: roowView.width/3
    }
    TableViewColumn {
        role: "pbkey"
        title: "公钥地址"
        width: roowView.width/3-10
    }
    model: mAccountsModel
    function setModel(alljson){
        var obj = JSON.parse(alljson); //由JSON字符串转换为JSON对象
        var dataArr = obj.accounts;
        for(var i=0;i<dataArr.length;i++){
            mAccountsModel.addObject(dataArr[i]);
        }
    }
}
