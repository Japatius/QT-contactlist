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

                function searchIt(input) {
                    for (var i = 0; i < theModel.count; i++) {

                        if (theModel.get(i).contactName.includes(input)) {
                            console.log(theModel.get(
                                            i).contactName + " " + input)
                        }
                    }
                }

                onTextChanged: {
                    var searchString = searchField.text
                    searchIt(searchString)
                }
            }
        }
        onDragEnded: if (lHeader.refresh) {
                         Api.refreshModel(listView)
                     }

        ListHeader {
            id: lHeader
            y: -listView.contentY - height
        }

        delegate: Loader {
            sourceComponent: ContactItem {
                firstname: contactName
                heightOfParent: contactsView.height / 10
                contactId: idText
                phone: contactNumber
            }
        }

        //        delegate: Component {
        //            id: contactDelega

        //            Rectangle {
        //                id: contactContainer
        //                width: contactsView.width
        //                height: contactsView.height / 10
        //                color: "#2C2C2C"

        //                MouseArea {
        //                    id: clickArea
        //                    anchors.fill: parent

        //                    // send id into dialog
        //                    signal passId(variant item)
        //                    onClicked: {
        //                        listView.currentIndex = index

        //                        console.log(theModel.get(index).idText)
        //                        var component = Qt.createComponent("ContactDialog.qml")
        //                        var loadIt = component.createObject(contactsView, {
        //                                                                "recievedId": idOfContact.text
        //                                                            })
        //                        passId(loadIt)
        //                        loadIt.open()
        //                    }
        //                    onPassId: {
        //                        console.log(item.recievedId + " was opened")
        //                    }
        //                }

        //                Rectangle {
        //                    id: iconContainer
        //                    anchors.verticalCenter: parent.verticalCenter
        //                    width: 60
        //                    height: parent.height
        //                    color: "blue"
        //                    Text {
        //                        text: contactName.charAt(0)
        //                        font.pointSize: 24
        //                        color: whiteColor
        //                        anchors {
        //                            verticalCenter: parent.verticalCenter
        //                            horizontalCenter: parent.horizontalCenter
        //                        }
        //                    }
        //                }

        //                Rectangle {
        //                    id: informationContainer
        //                    anchors {
        //                        left: iconContainer.right
        //                        baseline: iconContainer.baseline
        //                    }

        //                    Text {
        //                        visible: false
        //                        id: idOfContact
        //                        text: idText
        //                        color: "#fff"
        //                    }

        //                    Text {
        //                        id: firstName
        //                        color: "#fff"
        //                        text: contactName ? contactName : "No name entered"
        //                        x: 20
        //                        font.pointSize: 22
        //                    }

        //                    Text {
        //                        id: phoneNumber
        //                        color: "#e0e0e0"
        //                        text: contactNumber ? contactNumber : "No number entered"
        //                        x: 20
        //                        font.pointSize: 16
        //                        anchors {
        //                            top: firstName.bottom
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }

    Component {
        id: createComp
        CreateContactDialog {}
    }

    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
    }

    RoundButton {
        visible: false
        text: qsTr("+")
        highlighted: true
        anchors.margins: 10
        //        anchors.right: parent.right
        onClicked: {
            createContactLoader.active = false
            createContactLoader.active = true
            createContactLoader.item.open()
        }
    }
}
