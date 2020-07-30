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

    property bool isReadOnly: true

    ContactModel {
        id: contacts
    }

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    Component.onCompleted: {

        //        for (var i = 0; i < 10; i++) {
        //            savedListView.model.append({
        //                                           "testiTeksti": "Teemu testaaja",
        //                                           "testiNumero": "04012345678",
        //                                           "testiPosti": "teemu@testilabra.fi"
        //                                       })
        //        }
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

            width: savedView.width - 10
            height: savedView.height / 5
            radius: 10

            //            Text {
            //                id: name
            //                text: firstName
            //                padding: 5
            //                font.pixelSize: nameSize
            //            }
            TextField {
                id: name
                text: firstName
                color: "black"
                padding: 5
                font.pixelSize: nameSize
                readOnly: isReadOnly
            }

            Text {
                id: phone
                text: phoneNumber ? phoneNumber : testiNumero
                anchors.top: name.bottom
                padding: 5
            }

            Text {
                id: emailAddress
                text: email ? email : testiPosti
                anchors.top: phone.bottom
                padding: 5
            }

            Button {
                id: editButton
                background: Rectangle {
                    implicitWidth: 25
                    implicitHeight: 25
                    color: "#fff"
                    Text {
                        font.pointSize: 28
                        text: Mdi.icon.mdCreate
                        color: iconColor
                        //                        padding: 5
                    }
                }

                onClicked: {
                    isReadOnly = false
                }

                anchors {
                    right: delegateRectangle.right
                    baseline: name.baseline
                }
            }

            Button {
                id: deleteButton
                background: Rectangle {
                    implicitWidth: 25
                    implicitHeight: 25
                    color: "#fff"
                    Text {
                        font.pointSize: 28
                        text: Mdi.icon.mdRemoveCircle
                        color: iconColor
                        //                        padding: 5
                    }
                }

                anchors {
                    right: editButton.left
                    baseline: editButton.baseline
                }
            }
        }
        footerPositioning: ListView.OverlayFooter
        footer: Rectangle {
            width: savedView.width
            height: 50
            z: 2
            border.color: "black"

            Text {
                id: tekstoo
                text: qsTr("Mega masturbator")
            }
        }
    }
}
