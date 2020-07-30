import QtQuick 2.12
import QtQuick.Controls 2.12
import "ApiHelper.js" as Api

Item {
    //        id: contactDelegate
    property alias nameChar: contactCharacter.text
    property alias idString: idOfContact.text
    property alias nameString: firstName.text
    property alias phoneString: phoneNumber.text

    property alias viewId: ""
    property alias modelo: ""
    property alias contactScreen: ""

    Rectangle {
        id: contactContainer
        width: parent.width
        height: parent.height / 10
        color: "#2C2C2C"

        MouseArea {
            id: clickArea
            anchors.fill: parent

            // send id into dialog
            signal passId(variant item)
            onClicked: {
                viewId.currentIndex = index

                console.log(modelo.get(index).idText)
                var component = Qt.createComponent("ContactDialog.qml")
                var loadIt = component.createObject(contactScreen, {
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
            anchors.verticalCenter: parent.verticalCenter
            width: 60
            height: parent.height
            color: "blue"
            Text {
                id: contactCharacter
                text: nameChar.charAt(0)
                font.pointSize: 24
                color: whiteColor
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Rectangle {
            id: informationContainer
            anchors {
                left: iconContainer.right
                baseline: iconContainer.baseline
            }

            Text {
                visible: false
                id: idOfContact
                text: idString
                color: "#fff"
            }

            Text {
                id: firstName
                color: "#fff"
                text: nameString ? nameString : "No name entered"
                x: 20
                font.pointSize: 22
            }

            Text {
                id: phoneNumber
                color: "#e0e0e0"
                text: phoneString ? phoneString : "No number entered"
                x: 20
                font.pointSize: 16
                anchors {
                    top: firstName.bottom
                }
            }
        }
    }
}
