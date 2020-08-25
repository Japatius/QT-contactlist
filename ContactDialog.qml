import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Window 2.12
import "ApiHelper.js" as Api
import "Res.js" as Resource

Item {
    width: 400
    height: 600
    property string fullName: firstnameInput.text + " " + lastnameInput.text

    ContactModel {
        id: contacts
    }

    Rectangle {
        id: infoRectangle
        width: parent.width
        height: parent.height - 100
        color: Resource.colors.darkGray

        GridLayout {
            id: gridLayout
            columns: 2
            rows: 4
            anchors.fill: parent
            anchors.horizontalCenterOffset: 10
            Text {
                id: firstname
                text: Resource.user.firstName
                color: Resource.colors.white
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: firstnameInput
                placeholderText: Resource.placeholders.enter
                Layout.alignment: Qt.AlignCenter
            }
            Text {
                id: lastname
                text: Resource.user.lastName
                color: Resource.colors.white
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: lastnameInput
                placeholderText: Resource.placeholders.enter
                Layout.alignment: Qt.AlignCenter
            }
            Text {
                id: phone
                text: Resource.user.mobile
                color: Resource.colors.white
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: phoneInput
                placeholderText: Resource.placeholders.enter
                Layout.alignment: Qt.AlignCenter
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
            Text {
                id: email
                text: Resource.user.email
                color: Resource.colors.white
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: emailInput
                placeholderText: Resource.placeholders.enter
                Layout.alignment: Qt.AlignCenter
                inputMethodHints: Qt.ImhEmailCharactersOnly
            }
        }
    }
    Rectangle {
        anchors.top: infoRectangle.bottom
        height: 100
        width: parent.width
        color: Resource.colors.darkGray
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Rectangle {
                width: 150
                height: 50
                radius: 10.0
                color: Resource.colors.green
                Text {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    font.pointSize: 14
                    text: Resource.actions.create
                    color: Resource.colors.white
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Api.createContact(firstnameInput.text,
                                          lastnameInput.text, emailInput.text,
                                          phoneInput.text)
                    }
                }
            }
        }
    }

    RoundButton {
        text: Resource.icons.iosClose
        font.pixelSize: 20
        highlighted: true
        Material.accent: Material.color(Material.BlueGrey)
        anchors.margins: 10
        y: parent.height - height - 12
        anchors.right: parent.right
        onClicked: {
            theDialog.close()
            Api.refreshModel(theModel)
        }
    }
}
