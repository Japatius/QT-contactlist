import QtQuick 2.12
import QtQuick.Controls 2.12
import "ApiHelper.js" as Api

Component {

    //    property string idText
    //    property string contactName
    //    property string contactNumber
    id: contactDelegate
    Rectangle {
        id: contactId
        width: appWindow.width
        height: appWindow.height / 10
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

        Rectangle {
            id: iconContainer
            width: 50
            height: 50
            radius: width * 0.5
            color: darkColor

            Text {
                text: contactName.charAt(0)
                color: whiteColor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Item {
            id: infoContainer
            anchors.right: iconContainer.right

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
