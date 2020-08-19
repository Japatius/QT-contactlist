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
    property alias iidee: hidden.text
    property bool isUpdateMode: true
    property bool isCreateMode: false
    property string updateTxt: "Update"
    property string addTxt: "Add"
    property string fullName: firstnameInput.text + " " + lastnameInput.text

    property string placeholderTxt: "<enter>"

    ContactModel {
        id: contacts
    }

    Component.onCompleted: {
        if (isUpdateMode) {
            var req = new XMLHttpRequest()
            req.open("GET",
                     "https://qtphone.herokuapp.com/contact/" + iidee, true)
            req.onload = function () {
                var objectArray = JSON.parse(req.responseText)
                for (var i = 0; i < objectArray.length; i++) {
                    firstnameInput.text = objectArray[i].firstname
                    lastnameInput.text = objectArray[i].lastname
                    emailInput.text = objectArray[i].email
                    phoneInput.text = objectArray[i].mobile
                    //                console.log(fName, lName, email, mobile)
                    //                console.log(recievedId)
                }
            }
            req.send()
        }
    }

    Text {
        id: hidden
        text: id
        visible: false
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#2C2C2C"
        //        anchors.horizontalCenter: parent.horizontalCenter
        GridLayout {
            id: gridLayout
            columns: 2
            rows: 5
            anchors.fill: parent
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

            Button {
                id: okButton
                text: isUpdateMode ? updateTxt : addTxt
                Layout.alignment: Qt.AlignRight
                onClicked: {
                    if (isUpdateMode) {
                        Api.updateContact(iidee, firstnameInput.text,
                                          lastnameInput.text, phoneInput.text,
                                          emailInput.text)
                    }
                    if (isCreateMode) {
                        Api.createContact(firstnameInput.text,
                                          lastnameInput.text, phoneInput.text,
                                          emailInput.text)
                    }
                }
            }
            Button {
                id: cancelButton
                text: "Close"
                Layout.alignment: Qt.AlignLeft
                onClicked: {
                    theDialog.close()
                    isDatabaseMode ? contacts.refreshSavedContacts(
                                         savedListView) : Api.refreshModel(
                                         listView)
                }
            }
        }
    }

    RoundButton {
        text: Mdi.icon.iosPersonAdd
        highlighted: true
        anchors.margins: 10
        y: parent.height - height - 12
        anchors.right: parent.right
        visible: isUpdateMode
        onClicked: {
            contacts.insertContact(iidee, fullName, phoneInput.text,
                                   emailInput.text)
        }
    }
}
