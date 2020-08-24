import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Window 2.12
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

Item {
    width: 400
    height: 600
    //    property alias iidee: hidden.text
    property string updateTxt: "Update"
    property string addTxt: "Add"
    property string fullName: firstnameInput.text + " " + lastnameInput.text
    property string prevName: ""
    property string dialogMessage
    property string placeholderTxt: "<enter>"

    ContactModel {
        id: contacts
    }

    Rectangle {
        id: infoRectangle
        width: parent.width
        height: parent.height - 100
        color: "#2C2C2C"

        GridLayout {
            id: gridLayout
            columns: 2
            rows: 4
            anchors.fill: parent
            anchors.horizontalCenterOffset: 10
            Text {
                id: firstname
                text: qsTr("Firstname")
                color: "#fff"
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: firstnameInput
                placeholderText: placeholderTxt
                Layout.alignment: Qt.AlignCenter
            }
            Text {
                id: lastname
                text: qsTr("Lastname")
                color: "#fff"
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: lastnameInput
                placeholderText: placeholderTxt
                Layout.alignment: Qt.AlignCenter
            }
            Text {
                id: phone
                text: qsTr("Phone")
                color: "#fff"
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: phoneInput
                placeholderText: placeholderTxt
                Layout.alignment: Qt.AlignCenter
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
            Text {
                id: email
                text: qsTr("Email")
                color: "#fff"
                Layout.alignment: Qt.AlignRight
            }
            TextField {
                id: emailInput
                placeholderText: placeholderTxt
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
    Rectangle {
        anchors.top: infoRectangle.bottom
        height: 100
        width: parent.width
        color: "#2C2C2C"
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Rectangle {
                width: 50
                height: 50
                radius: 20.0
                color: "#42a51c"
                Text {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: Add
                    color: "white"
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
        text: Mdi.icon.iosClose
        font.pixelSize: 20
        highlighted: true
        Material.accent: Material.color(Material.BlueGrey)
        anchors.margins: 10
        y: parent.height - height - 12
        anchors.right: parent.right
        onClicked: {
            theDialog.close()
        }
    }
}
