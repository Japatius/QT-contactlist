import QtQuick 2.0
import QtQuick.Dialogs 1.2

Dialog {
    id: contactDialog
    title: "Piisami Sami"
    width: parent.width
    height: parent.height
    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: console.log("Ok clicked")
    onRejected: console.log("Cancel clicked")
}
