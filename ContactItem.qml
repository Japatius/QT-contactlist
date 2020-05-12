import QtQuick 2.0

Component {
    id: contactDelegate
    Rectangle {
        id: contactId
        width: appWindow.width
        height: appWindow.height / 10
        color: "#2C2C2C"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                ContactDialog.Open
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
        }
    }
}
