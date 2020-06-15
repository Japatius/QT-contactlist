import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.12
import "ApiHelper.js" as Api

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

    header: ToolBar {
        contentHeight: toolBtn.implicitHeight
        ToolButton {
            id: toolBtn
            text: "\uf031"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
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
        Label {
            text: "Contact List"
        }

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    drawer.close()
                }
            }
        }
    }

    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
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

    ListModel {
        id: contactModel
    }

    Rectangle {
        id: kokbars
        width: 50
        height: 50
        Text {
            anchors.centerIn: parent
            text: qsTr("Loading")
        }
    }

    Item {
        id: contactPos
        Loader {
            id: viewLoader
            source: "ContactsView.qml"
            asynchronous: true
            visible: status == Loader.Ready
        }
    }

    BusyIndicator {
        id: ind
        anchors.fill: parent
        running: viewLoader.status == Loader.Loading
    }
    StackView {
        id: stack
        initialItem: contactPos
        anchors.fill: parent
    }

    RoundButton {
        text: qsTr("+")
        highlighted: true
        anchors.margins: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            createContactLoader.active = false
            createContactLoader.active = true
            createContactLoader.item.open()
        }
    }
}
