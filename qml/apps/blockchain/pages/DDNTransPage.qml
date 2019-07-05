import QtQuick 2.0

Rectangle {
    color: Qt.rgba(Math.random(),Math.random(),Math.random(),1.0)
    Connections {
        target: ddnObject
        onSignalData: {
            if(json!="" && type == 2){
                console.log("The trans data changed!")
                transView.setModel(json)
            }
        }
    }
    DDNTransView{
        id:transView
        anchors.fill: parent
    }
}
