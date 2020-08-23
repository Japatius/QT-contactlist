import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.12
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

Item {
    id: contactsView
    width: Screen.width
    height: Screen.height
    property bool showLoadingIndicator: false

    ContactModel {
        id: contacts
        Component.onCompleted: {
            console.log("Contacts model ready")
        }
    }

    Component.onCompleted: {
        Api.fetchContacts(listView)
        //        contacts.fetchContacts(listView)
    }

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 5
        width: parent.width
        height: parent.height
        model: ListModel {
            id: theModel
        }

        headerPositioning: ListView.OverlayHeader
        header: Rectangle {
            id: searchRectangle
            color: "#2C2C2C"
            width: Screen.width
            height: 50
            z: 2
            TextField {
                id: searchField
                color: "#fff"
                width: parent.width
                height: parent.height
                padding: 5
                inputMethodHints: Qt.ImhNoPredictiveText

                onTextChanged: {
                    Api.searchContacts(searchField.text)
                }
            }
        }
        onDragEnded: {
            if (lHeader.refresh) {
                Api.refreshModel(listView)
            }
        }
        onDragStarted: {
            console.log(listView.contentY)
        }

        ListHeader {
            visible: false
            id: lHeader
            y: -listView.contentY - height
        }
        delegate: Loader {
            id: delegateLoader
            sourceComponent: ContactItem {
                firstname: contactName
                heightOfParent: contactsView.height / 10
                contactId: idText
            }
        }
    }

    LoadingIndicator {
        //        anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        isRunning: showLoadingIndicator
    }

    Component {
        id: createComp
        Dialog {
            id: theDialog
            visible: false
            contentItem: ContactDialog {
                isUpdateMode: false
                isCreateMode: true
            }
        }
    }

    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
    }

    RoundButton {
        text: qsTr("+")
        highlighted: true
        Material.accent: Material.color(Material.BlueGrey)
        anchors.margins: 10
        //        anchors.bottom: contactsView.bottom
        y: parent.height - height - 12
        anchors.right: parent.right
        onClicked: {
            createContactLoader.active = false
            createContactLoader.active = true
            createContactLoader.item.open()
        }
    }
}
