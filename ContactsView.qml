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

    Component.onCompleted: {
        Api.fetchContacts(listView)
    }

    ListModel {
        id: contactModel
    }

    MessageDialog {
        id: snackbar
        title: "Testaus?"
        text: "testi teksti"
        onAccepted: {
            console.log("closed")
        }
    }

    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
    }

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 5
        headerPositioning: ListView.OverlayHeader
        width: parent.width
        height: parent.height
        model: contactModel

        header: Rectangle {
            id: header
            color: "#2C2C2C"
            //            border.color: "#fff"
            width: parent.width
            height: 50
            z: 2
            Button {
                id: doSearchBtn
                anchors.right: searchField.left
                onClicked: {

                    //                    Api.refreshModel(listView)
                }
            }

            TextField {
                id: searchField
                color: "#fff"
                width: 200
                height: parent.height
                text: "Search.."
                anchors.left: doSearchBtn.right
                onTextChanged: {
                    for (var i = 0; i < contactModel.count; i++) {
                        console.log(i)
                    }
                }
            }
        }

        delegate: Component {
            id: contactDelegate

            Rectangle {
                id: contactId
                width: contactsView.width
                height: contactsView.height / 10
                color: "#2C2C2C"

                MouseArea {
                    id: clickArea
                    anchors.fill: parent

                    // send id into dialog
                    signal passId(variant item)
                    onClicked: {

                        listView.currentIndex = index

                        console.log(contactModel.get(index).idText)
                        var component = Qt.createComponent("ContactDialog.qml")
                        var loadIt = component.createObject(contactsView, {
                                                                "recievedId": idOfContact.text
                                                            })
                        passId(loadIt)
                        loadIt.open()
                    }
                    onPassId: {
                        console.log(item.recievedId + " was opened")
                    }
                }

                Rectangle {
                    id: iconContainer
                    width: 50
                    height: 50
                    radius: width * 0.5
                    color: darkColor
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: contactName.charAt(0)
                        color: whiteColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: infoContainer
                    //                    anchors.right: iconContainer.right
                    anchors {
                        right: iconContainer.right
                        baseline: iconContainer.baseline
                    }

                    Text {
                        visible: false
                        id: idOfContact
                        text: idText
                        color: "#fff"
                    }

                    Text {
                        id: firstName
                        color: "#fff"
                        text: contactName
                        x: 10
                    }

                    Text {
                        id: phoneNumber
                        color: "#e0e0e0"
                        text: contactNumber ? contactNumber : "No number entered.."
                        x: 10
                        anchors {
                            top: firstName.bottom
                        }
                    }
                }
            }
        }
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
