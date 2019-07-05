import QtQuick 2.7
//import QtQuick.Controls 1.2
//import QtQuick.Controls.Styles 1.2
import DDui.style 1.0
import DDui.ddn 1.0
import "../../common" as Common

import QtQuick.Controls 2.1

Common.DDComboBox {
    id: control
    model: DDNSkin.getAllTagsSkins()
    onActivated: {
        DDNSkin.changeSkin(currentText)
        control.displayText = currentText;
    }
    Connections{
        target: DDNSkin
        onSignalSkinFilesChanged:{
            control.model = DDNSkin.getAllTagsSkins();
        }
    }
    Component.onCompleted: {
        control.displayText = DDNSkin.getCurSkin();
    }
}
