import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

Rectangle {
    width: 400
    height: 350
    color: "#2C2C2C"
    property alias idContact: id.text
    property string textColor: "#fff"
    property string fullName: firstnameInput.text + " " + lastnameInput.text
    Component.onCompleted: {
        var req = new XMLHttpRequest()
        req.open("GET",
                 "https://qtphone.herokuapp.com/contact/" + idContact, true)
        req.onload = function () {
            var objectArray = JSON.parse(req.responseText)
            for (var i = 0; i < objectArray.length; i++) {
                firstnameInput.text = objectArray[i].firstname
                lastnameInput.text = objectArray[i].lastname
                emailInput.text = objectArray[i].email
                mobileInput.text = objectArray[i].mobile
            }
        }
        req.send()
    }

    ContactModel {
        id: contacts
    }

    Text {
        id: id
        text: id
        visible: false
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: gridLayout.top
            bottomMargin: 10
        }
        text: qsTr("Editing")
        font.pointSize: 26
        color: textColor
    }

    GridLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        id: gridLayout
        height: 200
        rows: 4
        rowSpacing: 10
        columns: 2
        columnSpacing: 20

        Text {
            text: qsTr("Firstname")
            color: textColor
        }

        TextField {
            id: firstnameInput
            text: qsTr("placeholder")
        }

        Text {
            text: qsTr("Lastname")
            color: textColor
        }

        TextField {
            id: lastnameInput
            text: qsTr("placeholder")
        }

        Text {
            text: qsTr("Phone")
            color: textColor
        }

        TextField {
            id: mobileInput
            text: qsTr("placeholder")
        }

        Text {
            text: qsTr("Email")
            color: textColor
        }

        TextField {
            id: emailInput
            text: qsTr("placeholder")
        }
    }
    Row {
        spacing: 10
        anchors {
            top: gridLayout.bottom
            horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: qsTr("Close")
            onClicked: {
                editDialog.close()
                Api.refreshModel(theModel)
            }
        }

        Button {
            id: applyBtn
            text: qsTr("Apply")
            onClicked: {
                Api.updateContact(idContact, firstnameInput.text,
                                  lastnameInput.text, mobileInput.text,
                                  emailInput.text)
                console.log("edited")
            }
        }

        Button {
            id: addIntoContactsBtn
            text: qsTr("Add to my contacts")
            onClicked: {
                contacts.insertContact(firstnameInput.text, lastnameInput.text,
                                       mobileInput.text, emailInput.text)
            }
        }
    }
}
