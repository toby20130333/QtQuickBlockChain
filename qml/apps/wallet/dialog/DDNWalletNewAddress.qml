import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "../../../common" as Common

Common.DDRectangle {

     ListView{
         id:lineView
         width: parent.width
         height: 40
         boundsBehavior: Flickable.StopAtBounds
         anchors.left: parent.left
         anchors.leftMargin: 30
         anchors.top: parent.top
         anchors.topMargin: 20
         delegate: Common.DDNavIconText{
              width: (index == 3)?100:lineView.width/3
              height: 30
              isReached: iisReached
              iText: iiText
              iNum: iiNum
              isTheLast: iisTheLast
         }
         orientation:ListView.Horizontal
         model: ListModel{
             id:accountModel
         }
     }
     Component.onCompleted: {
             accountModel.append({"iisReached":true,"iiText": "生成主密钥",
                                     "iiNum": 1,"iisTheLast": false
                                 });
             accountModel.append({"iisReached": false,"iiText": "验证主密钥",
                                     "iiNum": 2,"iisTheLast": false
                                 });
             accountModel.append({"iisReached": false,"iiText": "绑定地址",
                                     "iiNum": 3,"iisTheLast": true
                                 });
     }
}
