import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import "Icons.js" as Mdi

Item {
    width: Screen.width
    height: Screen.height
    property int parentHeight: 150
    property string rectangleColor: "#2C2C2C"
    property string textColor: "#fff"

    ContactModel {
        id: contacts
    }

    Component.onCompleted: {
        contacts.findGreetings()
    }

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    ListView {
        id: savedContactList
        anchors.fill: parent
        model: 10
        spacing: 10

        delegate: Rectangle {
            width: parent.width
            height: parentHeight
            color: rectangleColor

            Image {
                id: placeholder
                source: "https://web.klassroom.co/images/placeholder.png"
                width: 50
                height: 50
            }

            Text {
                id: name
                anchors {
                    left: placeholder.right
                }

                font.pointSize: 24
                color: textColor
                text: qsTr("Firstname ")
            }

            Text {
                id: lName
                anchors.left: name.right
                font.pointSize: 24
                color: textColor
                text: qsTr("Lastname")
            }

            Rectangle {
                id: descriptionRectangle
                anchors.top: placeholder.bottom
                width: parent.width
                height: childrenRect.height + 20
                color: rectangleColor

                Text {
                    id: description
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color: textColor
                    text: qsTr("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                }

                Rectangle {
                    anchors {
                        top: description.bottom
                    }
                    Button {
                        id: button
                        text: Mdi.icon.mdTrash
                        background: Rectangle {
                            implicitWidth: 25
                            implicitHeight: 25
                            color: button.down ? "#000000" : "red"
                            border.color: "#26282a"
                            border.width: 1
                            radius: 10
                        }
                    }
                }
            }
        }
    }
}
