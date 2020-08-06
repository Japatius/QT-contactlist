import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import "Icons.js" as Mdi

Item {
    id: savedView
    width: Screen.width
    height: Screen.height
    property string testiTeksti: "vakio"
    property string testiNumero: "112"
    property string testiPosti: "t@t.example"
    property string iconColor: "grey"

    property real nameSize: 24

    ContactModel {
        id: contacts
    }

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    Component.onCompleted: {
        contacts.initTable()
        contacts.listContacts(savedListView)
    }

    ListView {
        anchors.fill: parent
        width: parent.width
        height: parent.height
        id: savedListView
        model: ListModel {}
        spacing: 10
        delegate: Rectangle {
            id: delegateRectangle
            clip: true
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            color: "#C4C4C4"
            width: savedView.width - 10
            height: savedView.height / 5
            radius: 10

            //            Text {
            //                id: name
            //                text: firstName
            //                padding: 5
            //                font.pixelSize: nameSize
            //            }
            Text {
                id: name
                text: firstName
                color: "black"
                padding: 5
                font.pixelSize: nameSize
                x: 10
                y: 5
            }

            Text {
                id: phone
                text: phoneNumber ? phoneNumber : testiNumero
                anchors {
                    top: name.bottom
                    topMargin: 12
                }
                padding: 5
                x: 60
            }

            Text {
                text: Mdi.icon.mdCall
                color: iconColor
                font.pointSize: 26
                padding: 5
                anchors {
                    left: name.left
                    baseline: phone.baseline
                }
            }

            Text {
                id: emailAddress
                text: email ? email : testiPosti
                anchors.top: phone.bottom
                padding: 5
                x: 60
            }

            Text {
                text: Mdi.icon.mdMail
                color: iconColor
                font.pointSize: 26
                padding: 5
                anchors {
                    left: name.left
                    baseline: emailAddress.baseline
                }
            }
        }
    }
}
