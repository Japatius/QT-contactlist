import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import "ApiHelper.js" as Api
import "Res.js" as Resource

ApplicationWindow {
    id: appWindow
    visible: true
    width: Screen.width
    height: Screen.height

    property bool loadingRequest: true
    property bool searchToggle: false

    ContactModel {
        id: contacts
    }

    ListModel {
        id: theModel
    }

    ListModel {
        id: dbModel
    }

    Component.onCompleted: {
        Api.fetchContacts(theModel)
        contacts.initDb()
        contacts.initTable()
        contacts.listContacts(dbModel)
    }

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    LoadingIndicator {
        isRunning: loadingRequest
    }

    header: ToolBar {
        contentHeight: toolBtn.implicitHeight
        Material.background: Material.color(Material.BlueGrey)
        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: toolBtn
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                text: Resource.icons.mdMenu
                onClicked: {
                    drawer.open()
                }
            }

            ComboBox {
                id: modelChooser
                model: ListModel {
                    ListElement {
                        text: "Contacts"
                    }
                    ListElement {
                        text: "My Contacts"
                    }
                }
            }
            Material.background: Material.color(Material.BlueGrey)
            width: 200
            Layout.fillWidth: true

            ToolButton {
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                text: searchToggle ? Resource.icons.iosClose : Resource.icons.mdSearch
                onClicked: {
                    searchToggle = !searchToggle
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 5
        width: parent.width
        height: parent.height
        headerPositioning: ListView.OverlayHeader
        header: SearchField {
            visible: searchToggle
        }

        onDragEnded: {
            if (lHeader.refresh) {
                Api.refreshModel(theModel)
                contacts.refreshSavedContacts(dbModel)
            }
        }

        ListHeader {
            id: lHeader
            y: -listView.contentY - height
        }
        model: modelChooser.currentIndex <= 0 ? theModel : dbModel

        delegate: ContactItem {
            fullName: contactName
            contactId: idText
        }

        section.property: "contactName"
        section.criteria: ViewSection.FirstCharacter
        section.delegate: Initial {}
    }

    Component {
        id: createComp
        Dialog {
            id: theDialog
            visible: false
            contentItem: ContactDialog {}
        }
    }

    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
    }

    Loader {
        id: headsupLoader
        sourceComponent: HeadsUpDialog {
            onYes: {
                contacts.dropContacts()
                contacts.initTable()
                contacts.refreshSavedContacts(dbModel)
            }
        }
    }

    RoundButton {
        text: Resource.icons.mdAdd
        highlighted: true
        Material.accent: Material.color(Material.BlueGrey)
        anchors.margins: 10
        y: parent.height - height - 12
        z: 100
        anchors.left: parent.left
        onClicked: {
            createContactLoader.active = false
            createContactLoader.active = true
            createContactLoader.item.open()
        }
    }

    Drawer {
        id: drawer
        width: appWindow.width * 0.66
        height: appWindow.height
        Material.background: Material.color(Material.BlueGrey)
        Column {
            id: drawerColumn
            anchors.fill: parent
            Label {
                padding: 10
                font.pointSize: 24
                text: Resource.appName
            }
            ItemDelegate {
                width: parent.width
                padding: 5

                Button {
                    font.pointSize: 16
                    text: Resource.actions.wipeDatabase
                    background: Rectangle {
                        radius: 10.0
                        anchors.fill: parent
                        color: Material.color(Material.Red)
                    }

                    onClicked: {
                        headsupLoader.item.message = "Are you sure?"
                        headsupLoader.item.open()
                    }
                }
            }
        }
    }

    StackView {
        id: stack
        initialItem: listView
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
