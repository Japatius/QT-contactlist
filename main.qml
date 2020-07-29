import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.12
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

ApplicationWindow {
    id: appWindow
    visible: true
    width: Screen.width
    height: Screen.height
    //    width: 640
    //    height: 480
    title: qsTr("Scroll")

    property string darkColor: "#242424"
    property string whiteColor: "#fff"

    ContactModel {
        id: contacts
    }

    Component.onCompleted: {
        contacts.initDb()
    }

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    header: ToolBar {
        contentHeight: toolBtn.implicitHeight
        ToolButton {
            id: toolBtn
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            font.family: "Ionicons"
            text: Mdi.icon.mdMenu
            onClicked: {
                drawer.open()
            }
        }
        Label {
            text: "Contacts"
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: appWindow.width * 0.66
        height: appWindow.height

        Column {
            anchors.fill: parent
            Label {
                padding: 10
                text: "Contact List"
            }
            ItemDelegate {
                text: qsTr("Contacts")
                width: parent.width
                onClicked: {
                    stack.push("main.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("My contacts")
                width: parent.width
                onClicked: {
                    stack.push("MyContacts.qml")
                    drawer.close()
                }
            }
        }
    }

    Component {
        id: createComp
        Dialog {
            id: createContactDialogId
            contentItem: CreateContactDialog {
                id: createContactContentId
                closeButton.onClicked: {
                    createContactDialogId.close()
                }
            }
            standardButtons: StandardButton.Ok
        }
    }

    Item {
        id: contactPos
        Loader {
            id: viewLoader
            anchors.fill: parent
            source: "ContactsView.qml"
            asynchronous: true
            visible: status == Loader.Ready
        }
    }

    BusyIndicator {
        id: ind
        anchors.fill: parent
        width: 150
        height: 150
        running: viewLoader.status == Loader.Loading
                 && viewLoader.source !== visible
    }

    StackView {
        id: stack
        initialItem: contactPos
        anchors.fill: parent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }
}
