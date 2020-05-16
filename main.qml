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

    Loader {
        id: dialogLoader
        sourceComponent: diaComp
        active: false
    }

    Component {
        id: diaComp
        Dialog {
            id: contactDialogId
            contentItem: ContactDialog {
                id: contactContentItemId
                cancelButton.onClicked: {
                    contactDialogId.close()
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

    SwipeView {
        id: swiper
        anchors.fill: parent
        currentIndex: navigator.currentIndex

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
                    //                    TextInput {
                    //                        color: "#fff"
                    //                        width: parent.width
                    //                        height: parent.height
                    //                        text: "Search.."

                    //                        anchors {
                    //                            verticalCenter: verticalCenter
                    //                        }
                    //                    }
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

    //    StackLayout {
    //        currentIndex: navigator.currentIndex
    //        anchors.fill: parent
    //        Item {
    //            id: contactsView
    //            ListView {
    //                id: listView
    //                anchors.fill: parent
    //                delegate: ContactItem {}
    //                model: ContactsModel {}
    //                spacing: 5

    //                headerPositioning: ListView.OverlayHeader
    //                header: Rectangle {
    //                    id: header
    //                    color: "#2C2C2C"
    //                    border.color: "#fff"
    //                    width: parent.width
    //                    height: 50
    //                    z: 2
    //                    //                    TextInput {
    //                    //                        color: "#fff"
    //                    //                        width: parent.width
    //                    //                        height: parent.height
    //                    //                        text: "Search.."

    //                    //                        anchors {
    //                    //                            verticalCenter: verticalCenter
    //                    //                        }
    //                    //                    }
    //                }
    //            }
    //        }

    //        MyContacts {}

    //        Item {
    //            id: misc
    //            Text {
    //                id: hioh
    //                text: qsTr("Blyat vadim!")
    //            }
    //        }
    //    }
}
