import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import "Icons.js" as Mdi

Item {
    width: Screen.width
    height: Screen.height
    property int parentHeight: 150
    property string rectangleColor: "#2C2C2C"
    property string textColor: "#fff"
    property string placeholderText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

    ContactModel {
        id: contacts
    }

    Component.onCompleted: {
        contacts.initTable()
        contacts.listContacts(savedContactList)
    }
    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    ListView {
        id: savedContactList
        anchors.fill: parent
        width: parent.width
        height: parent.height

        model: ListModel {
            Component.onCompleted: {
                console.log(savedContactList.model.count)
            }
        }
        spacing: 10

        delegate: Rectangle {
            id: savedContactDelegate
            width: parent.width
            height: parentHeight
            color: rectangleColor

            Rectangle {
                id: charCon
                width: 50
                height: 50

                Text {
                    id: character
                    font.pointSize: 24
                    text: firstName.charAt(0)
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Text {
                id: name
                anchors {
                    left: charCon.right
                    leftMargin: 10
                }

                font.pointSize: 24
                color: textColor
                text: firstName ? firstName : "No name entered"
            }

            //            Text {
            //                id: lName
            //                anchors.left: name.right
            //                font.pointSize: 24
            //                color: textColor
            //                text: qsTr("Lastname")
            //            }
            Rectangle {
                id: descriptionRectangle
                anchors.top: charCon.bottom
                width: parent.width
                height: childrenRect.height + 20
                color: rectangleColor

                Text {
                    id: description
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color: textColor
                    text: placeholderText
                }

                Rectangle {
                    id: actionsContainer
                    anchors {
                        top: description.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    Button {
                        id: button
                        //                        text: Mdi.icon.mdTrash
                        background: Rectangle {
                            implicitWidth: 25
                            implicitHeight: 25
                            color: "#2C2C2C"
                            Text {
                                font.pointSize: 24
                                text: Mdi.icon.iosMore
                                color: "#fff"
                            }
                        }
                        onClicked: {
                            dialogLoader.active = false
                            dialogLoader.active = true
                            dialogLoader.item.open()
                        }
                    }
                }
            }
        }
        Loader {
            id: dialogLoader
            sourceComponent: optionDialog
            active: false
        }

        Component {
            id: optionDialog

            Dialog {
                title: "Options"
                visible: false

                contentItem: Rectangle {
                    width: 200
                    height: 400
                    Text {
                        text: "teksti"
                    }
                    Button {
                        text: "Sulje"
                        onClicked: {
                            dialogLoader.item.close()
                        }
                    }
                }
            }
        }
    }
}
