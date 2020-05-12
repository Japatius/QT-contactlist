import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import "ApiHelper.js" as Api

ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")

    Component.onCompleted: {
        Api.func()
        Api.fetchContacts(listView)
        Api.fetchContactById("20")
    }

    //    Dialog {
    //        id: contactDialog
    //        title: "Piisami Sami"
    //        width: parent.width
    //        height: parent.height
    //        standardButtons: Dialog.Ok | Dialog.Cancel

    //        onAccepted: console.log("Ok clicked")
    //        onRejected: console.log("Cancel clicked")
    //    }
    footer: TabBar {
        id: navigator
        width: parent.width

        TabButton {
            text: qsTr("Contacts")
        }
        TabButton {
            text: qsTr("My Contacts")
        }
        TabButton {
            text: qsTr("Misc")
        }
    }

    StackLayout {
        currentIndex: navigator.currentIndex
        anchors.fill: parent
        Item {
            id: contactsView
            ListView {
                id: listView
                anchors.fill: parent
                delegate: ContactItem {}
                model: ContactsModel {}
                spacing: 5

                headerPositioning: ListView.OverlayHeader
                header: Rectangle {
                    id: header
                    color: "#2C2C2C"
                    border.color: "#fff"
                    width: parent.width
                    height: 50
                    z: 2
                    TextInput {
                        color: "#fff"
                        width: parent.width
                        height: parent.height
                        text: "Search.."

                        anchors {
                            verticalCenter: verticalCenter
                        }
                    }
                }
            }
        }

        MyContacts {}

        Item {
            id: misc
            Text {
                id: hioh
                text: qsTr("Blyat vadim!")
            }
        }
    }
}
