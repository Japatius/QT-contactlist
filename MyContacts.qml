import QtQuick 2.0
import QtQuick.Controls 2.12
import "ApiHelper.js" as Api

Item {
    id: savedContact
    Rectangle {
        width: parent.width

        TextField {
            id: enterText
            text: qsTr("Jada jada jada..")
        }
    }

    Button {
        id: button
        text: "add"
        anchors.right: parent.right
        background: Rectangle {
            implicitWidth: 50
            implicitHeight: 20
            color: button.down ? "black" : "#2C2C2C"
            border.color: "#ff4"
            border.width: 1
            radius: 4
        }
        onClicked: {
            Api.createContact(enterText.text)
        }
    }
}
