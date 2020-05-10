import QtQuick 2.13
import QtQuick.Controls 2.13
import "ApiHelper.js" as Api

ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")

    //    StackView {
    //        id: daStack
    //        initialItem: listView
    //        visible: true
    //    }
    Component.onCompleted: {
        Api.func()
        Api.fetchContacts(listView)
    }

    ListModel {
        id: contactModel
    }
    Component {
        id: contactDelegate
        Rectangle {
            id: contactId
            width: appWindow.width
            height: appWindow.height / 10
            color: "#2C2C2C"

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
                    id: firstName
                    color: "#fff"
                    text: contactName
                    x: 10
                }

                Text {
                    id: phoneNumber
                    color: "#e0e0e0"
                    text: contactNumber
                    x: 10
                    anchors {
                        top: firstName.bottom
                    }
                }

                //                Rectangle {
                //                    id: nameRec
                //                    width: parent.width
                //                    Text {
                //                        id: firstName
                //                        color: "#fff"
                //                        text: contactName
                //                    }
                //                }
                //                Rectangle {
                //                    id: phoneRec
                //                    width: parent.width
                //                    Text {
                //                        id: phoneNumber
                //                        color: "#fff"
                //                        text: contactNumber
                //                    }
                //                }
            }

            //            Button {
            //                id: button
            //                text: "add"
            //                anchors.right: parent.right
            //                background: Rectangle {
            //                    implicitWidth: 50
            //                    implicitHeight: 20
            //                    color: button.down ? "black" : "#2C2C2C"
            //                    border.color: "#ff4"
            //                    border.width: 1
            //                    radius: 4
            //                }
            //            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        delegate: contactDelegate
        model: contactModel
        spacing: 5

        headerPositioning: ListView.OverlayHeader
        header: Rectangle {
            id: header
            color: "#2C2C2C"
            border.color: "#fff"
            width: parent.width
            height: 50
            z: 2
            TextInput {
                width: parent.width
                height: parent.height
                text: "Search.."
            }
        }
    }
    footer: TabBar {


        /**
          * Implement Navigations..
          **/
        id: navigator
        width: parent.width

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
}
