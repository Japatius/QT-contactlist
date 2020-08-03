import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import "ApiHelper.js" as Api

Item {
    property alias contactId: hiddenId.text
    property alias firstname: name.text
    property alias phone: phoneNumber.text
    property alias heightOfParent: contactItem.height
    property real itemHeight: 100
    property string fontColor: "#fff"

    id: contactItem
    height: heightOfParent
    width: Screen.width

    Rectangle {
        height: parent.height
        width: parent.width
        color: "#2C2C2C"

        Rectangle {
            id: letCont
            height: parent.height
            width: 50
            Text {
                text: qsTr("GWA")
            }
            anchors {
                left: parent.left
            }
        }

        Text {
            id: hiddenId
            visible: false
            text: contactId
        }

        // TODO:
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(contactId)
            }
        }

        Text {
            id: name
            text: firstname
            color: fontColor
            anchors {
                left: letCont.right
            }
        }

        Text {
            id: phoneNumber
            text: phone
            anchors {
                top: name.bottom
                left: letCont.right
            }
        }
    }
}
