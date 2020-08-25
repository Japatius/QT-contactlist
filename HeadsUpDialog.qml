import QtQuick 2.12
import QtQuick.Dialogs 1.2

MessageDialog {
    property string message
    id: messageDialog
    title: message
    visible: false
    icon: StandardIcon.Warning
    standardButtons: StandardButton.Yes | StandardButton.No
    onAccepted: {
        messageDialog.close()
    }
}
