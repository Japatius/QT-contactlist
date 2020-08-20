import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
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
    property string titleName: "Contacts"

    ContactModel {
        id: contacts
    }

    Component.onCompleted: {
        contacts.initDb()
        console.log(Screen.width, Screen.height)
    }

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    header: ToolBar {
        contentHeight: toolBtn.implicitHeight
        Material.background: Material.color(Material.Lime)
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
            text: titleName
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
                font.pointSize: 24
                text: "Contact List"
            }
            ItemDelegate {
                text: qsTr("Contacts")
                width: parent.width
                leftPadding: 15
                padding: 5
                font.pointSize: 20
                onClicked: {
                    titleName = "Contacts"
                    stack.push("main.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("My contacts")
                width: parent.width
                leftPadding: 15
                padding: 5
                font.pointSize: 20
                onClicked: {
                    titleName = "My Contacts"
                    stack.push("MyContacts.qml")
                    drawer.close()
                }
            }
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
