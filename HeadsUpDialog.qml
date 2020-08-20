import QtQuick 2.0
import QtQuick.Dialogs 1.2

MessageDialog {
    property string message: ""

    id: messageDialog
    title: "Heads up!"
    text: message
    visible: false
    standardButtons: StandardButton.Yes | StandardButton.No
    onAccepted: {
        messageDialog.close()
    }
}
