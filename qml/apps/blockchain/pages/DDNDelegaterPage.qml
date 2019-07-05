import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "./../../../common/style" as DDNStyle
import "./../../../common/" as Common

DDNStyle.DDTableStyleView {
    id:roowView
    Connections {
        target: ddnObject
        onSignalData: {
            if(json!="" && type == 7){
                console.log("The delegates data changed!",json.length)
                roowView.setModel(json)
            }
        }
    }
    itemDelegate: DDNStyle.DDTableTextItem{
        id:txtItem
        styleDatas:styleData
        horAlign:Qt.AlignHCenter
        handStylelist: []
        myTxtColor:txtItem.colorIndex(styleData.column,styleData.seleted)
    }
    rowDelegate: DDNStyle.DDRowDelegate{
        height:40
    }
    headerDelegate: DDNStyle.DDHeaderStyle{
        headerText: styleData.value
        columnIndx:styleData.column
    }
    TableViewColumn {
        id:userName
        role: "username"
        title: "用户名"
        width: roowView.width/5
    }
    TableViewColumn {
        id:checkedColumn
        role: "address"
        title: "钱包地址"
        width: roowView.width/5
    }
    TableViewColumn {
        id:comBoxId
        role: "approval"
        title: "得票率"
        width: roowView.width/5
    }
    TableViewColumn {
        id:comBoxId2
        role: "productivity"
        title: "生成率"
        width: roowView.width/5
    }
    TableViewColumn {
        role: "amount"
        title: "收入"
        width: roowView.width/5-10
    }
    model: mDelegateModel
    function setModel(alljson){
        var obj = JSON.parse(alljson); //由JSON字符串转换为JSON对象
        var dataArr = obj.delegates;
        for(var i=0;i<dataArr.length;i++){
            mDelegateModel.addObject(dataArr[i]);
        }
    }
//    onVisibleChanged: {
//        if(visible){
//            ddnObject.requestDDNDelegates(0,30)
//        }
//    }
}
