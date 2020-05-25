import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
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

    //    Loader {
    //        id: dialogLoader
    //        sourceComponent: diaComp
    //        active: false
    //    }
    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
    }

    //    Component {
    //        id: diaComp
    //        Dialog {
    //            id: contactDialogId
    //            contentItem: ContactDialog {
    //                id: contactContentItemId
    //                recievedId: idOfContact
    //                cancelButton.onClicked: {
    //                    contactDialogId.close()
    //                }
    //            }
    //            standardButtons: StandardButton.Ok
    //        }
    //    }
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
    footer: TabBar {
        id: navigator
        width: parent.width
        currentIndex: swiper.currentIndex
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

    ListModel {
        id: contactModel
    }

    SwipeView {
        id: swiper
        anchors.fill: parent
        currentIndex: navigator.currentIndex

        Item {
            id: contactsView

            ListView {
                id: listView
                anchors.fill: parent
                spacing: 5
                model: contactModel

                headerPositioning: ListView.OverlayHeader
                header: Rectangle {
                    id: header
                    color: "#2C2C2C"
                    border.color: "#fff"
                    width: parent.width
                    height: 50
                    z: 2
                    Button {
                        id: doSearchBtn
                        text: "Reload"
                        anchors.right: searchField.left
                        onClicked: {
                            Api.refreshModel(listView)
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
                            console.log(searchField.text)
                        }
                    }
                }

                delegate: Component {
                    id: contactDelegate

                    Rectangle {
                        id: contactId
                        width: appWindow.width
                        height: appWindow.height / 10
                        color: "#2C2C2C"

                        MouseArea {
                            id: clickArea
                            anchors.fill: parent

                            signal passId(variant item)
                            onClicked: {

                                listView.currentIndex = index

                                console.log(contactModel.get(index).idText)
                                var component = Qt.createComponent(
                                            "ContactDialog.qml")
                                var loadIt = component.createObject(appWindow, {
                                                                        "recievedId": idOfContact.text
                                                                    })
                                passId(loadIt)
                                loadIt.open()
                            }
                            onPassId: {
                                console.log(item.recievedId + " was opened")
                            }
                        }

                        Item {
                            id: iconContainer
                            width: 50
                            height: 50

                            Image {
                                id: contactIcon
                                //placeholder icon, replace with something..
                                source: "https://cdn.onlinewebfonts.com/svg/img_411575.png"
                                width: 30
                                height: 30
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Item {
                            id: infoContainer
                            anchors {
                                right: iconContainer.right
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
            console.log("TODO")
        }
    }
}
