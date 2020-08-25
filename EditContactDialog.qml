import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import QtQuick.LocalStorage 2.12
import "ApiHelper.js" as Api
import "Res.js" as Resource

Rectangle {
    width: 400
    height: 350
    color: Resource.colors.darkGray
    property alias idContact: id.text
    property bool canAdd: true

    ContactModel {
        id: contacts
    }

    function apiGetById() {
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

    function dbGetById() {
        var db = contacts.initDb()
        try {
            db.transaction(function (trx) {
                var select = trx.executeSql(
                            'SELECT * FROM Contacts WHERE id = ?', [idContact])
                for (var i = 0; i < select.rows.length; i++) {
                    firstnameInput.text = select.rows.item(i).firstname
                    lastnameInput.text = select.rows.item(i).lastname
                    emailInput.text = select.rows.item(i).phone
                    mobileInput.text = select.rows.item(i).email
                }
            })
        } catch (e) {
            console.error(e)
        }
    }

    Component.onCompleted: {
        switch (modelChooser.currentIndex) {
        case 0:
            apiGetById()
            break
        case 1:
            dbGetById()
            canAdd = false
            break
        }
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
        text: Resource.actions.editing
        font.pointSize: 26
        color: Resource.colors.white
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
            text: Resource.user.firstName
            color: Resource.colors.white
        }

        TextField {
            id: firstnameInput
        }

        Text {
            text: Resource.user.lastName
            color: Resource.colors.white
        }

        TextField {
            id: lastnameInput
        }

        Text {
            text: Resource.user.mobile
            color: Resource.colors.white
        }

        TextField {
            id: mobileInput
            inputMethodHints: Qt.ImhFormattedNumbersOnly
        }

        Text {
            text: Resource.user.email
            color: Resource.colors.white
        }

        TextField {
            id: emailInput
            inputMethodHints: Qt.ImhEmailCharactersOnly
        }
    }
    Row {
        spacing: 10
        anchors {
            top: gridLayout.bottom
            horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: Resource.actions.close
            onClicked: {
                editDialog.close()
                Api.refreshModel(theModel)
                contacts.refreshSavedContacts(dbModel)
            }
        }

        Button {
            id: applyBtn
            text: Resource.actions.apply
            onClicked: {
                if (modelChooser.currentIndex <= 0) {
                    Api.updateContact(idContact, firstnameInput.text,
                                      lastnameInput.text, mobileInput.text,
                                      emailInput.text)
                } else {
                    contacts.updateContact(idContact, firstnameInput.text,
                                           lastnameInput.text,
                                           mobileInput.text, emailInput.text)
                }
            }
        }

        Button {
            id: addIntoContactsBtn
            text: Resource.actions.addToMyContact
            visible: canAdd
            onClicked: {
                contacts.insertContact(firstnameInput.text, lastnameInput.text,
                                       mobileInput.text, emailInput.text)
            }
        }
    }
}
