import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

Item {
    id: contactsView
    width: Screen.width
    height: Screen.height

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

                function searchIt(input) {
                    for (var i = 0; i < theModel.count; i++) {
                        if (theModel.get(i).contactName.includes(input)) {
                            theModel.clear()
                            theModel.append({
                                                "contactName": theModel.get(
                                                                   i).contactName,
                                                "contactNumber": theModel.get(
                                                                     i).mobile,
                                                "idText": theModel.get(i).id
                                            })
                        }
                    }
                }

                onTextChanged: {
                    var searchString = searchField.text
                    searchIt(searchString)
                }

                onAccepted: {
                    searchField.focus = false
                }
            }
        }

        onDragEnded: {
            if (lHeader.refresh) {
                Api.refreshModel(listView)
            }
        }

        ListHeader {
            id: lHeader
            y: -listView.contentY - height
        }

        delegate: Loader {
            id: delegateLoader
            sourceComponent: ContactItem {
                firstname: contactName
                heightOfParent: contactsView.height / 10
                contactId: idText
                phone: contactNumber
            }
        }
    }

    Component {
        id: createComp
        Dialog {
            id: theDialog
            visible: false
            contentItem: ContactDialog {
                isUpdateMode: false
            }
        }
    }

    //    Loader {
    //        id: listViewLoader
    //        sourceComponent: listView
    //        active: true
    //        asynchronous: true
    //        visible: status == Loader.Ready
    //    }
    //    BusyIndicator {
    //        id: ind
    //        anchors.fill: parent
    //        width: 150
    //        height: 150
    //    }
    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
    }

    RoundButton {
        text: qsTr("+")
        highlighted: true
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
