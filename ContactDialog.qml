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
    property bool isDatabaseMode: false
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
            // TODO: Pass ID when opening dialog
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
        if (isDatabaseMode) {
            contacts.fetchOne(36)
            //            var id = iidee
            //            var db = contacts.initDb()
            //            try {
            //                db.transaction(function (trx) {
            //                    trx.executeSql('SELECT * from Contacts WHERE id=?', [id])
            //                })
            //            } catch (e) {
            //                console.error(e)
            //            }
        }
    }

    Text {
        id: hidden
        text: id
        visible: false
    }

    Rectangle {
        width: 400
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
                Layout.alignment: Qt.AlignCenter
            }
            TextField {
                id: firstnameInput
                placeholderText: placeholderTxt
                Layout.minimumWidth: gridLayout.minimumInputSize
            }
            Text {
                id: lastname
                text: qsTr("Lastname")
                color: "#fff"
                Layout.alignment: Qt.AlignCenter
            }
            TextField {
                id: lastnameInput
                placeholderText: placeholderTxt
            }
            Text {
                id: phone
                text: qsTr("Phone")
                color: "#fff"
                Layout.alignment: Qt.AlignCenter
            }
            TextField {
                id: phoneInput
                placeholderText: placeholderTxt
            }
            Text {
                id: email
                text: qsTr("Email")
                color: "#fff"
                Layout.alignment: Qt.AlignCenter
            }
            TextField {
                id: emailInput
                placeholderText: placeholderTxt
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
                    } else {
                        console.log("Hek hek hek")
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
