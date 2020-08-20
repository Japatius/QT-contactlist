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
    property bool isReadOnly: true
    property bool wantToDelete: false
    property string updateTxt: "Update"
    property string addTxt: "Add"
    property string fullName: firstnameInput.text + " " + lastnameInput.text
    property string dialogMessage
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

    Component.onDestruction: {
        Api.refreshModel(listView)
    }

    Text {
        id: hidden
        text: id
        visible: false
    }

    Rectangle {
        id: infoRectangle
        width: parent.width
        height: parent.height - 100
        color: "#2C2C2C"
        //        anchors.horizontalCenter: parent.horizontalCenter
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
                readOnly: isReadOnly
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
                readOnly: isReadOnly
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
                readOnly: isReadOnly
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
                readOnly: isReadOnly
            }

            //            Button {
            //                id: okButton
            //                text: isUpdateMode ? updateTxt : addTxt
            //                Layout.alignment: Qt.AlignRight
            //                onClicked: {
            //                    if (isUpdateMode) {
            //                        Api.updateContact(iidee, firstnameInput.text,
            //                                          lastnameInput.text, phoneInput.text,
            //                                          emailInput.text)
            //                    }
            //                    if (isCreateMode) {
            //                        Api.createContact(firstnameInput.text,
            //                                          lastnameInput.text, phoneInput.text,
            //                                          emailInput.text)
            //                    }
            //                }
            //            }
            //            Button {
            //                id: cancelButton
            //                text: "Close"
            //                Layout.alignment: Qt.AlignLeft
            //                onClicked: {
            //                    theDialog.close()
            //                    isDatabaseMode ? contacts.refreshSavedContacts(
            //                                         savedListView) : Api.refreshModel(
            //                                         listView)
            //                }
            //            }
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
                color: Material.color(Material.Red)
                Text {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }

                    text: Mdi.icon.mdTrash
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        wantToDelete = true
                        dialogMessage = "Do you wish to delete " + fullName + "?"
                        console.log(wantToDelete)
                        headsupLoader.item.open()
                    }
                }
            }
            Rectangle {
                width: 50
                height: 50
                radius: 20.0
                color: Material.color(Material.Orange)
                Text {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: Mdi.icon.iosPersonAdd
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        isReadOnly = false
                        firstnameInput.focus = true
                        console.log("Edit clicked")
                    }
                }
            }
            Rectangle {
                width: 50
                height: 50
                radius: 20.0
                color: "#42a51c"
                visible: isUpdateMode
                Text {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: Mdi.icon.iosPersonAdd
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Add clicked")
                        wantToDelete = false
                        dialogMessage = "Add " + fullName + " into your contacts?"
                        headsupLoader.item.open()
                        //                        contacts.insertContact(iidee, fullName, phoneInput.text,
                        //                                               emailInput.text)
                    }
                }
            }
        }
    }

    RoundButton {
        text: Mdi.icon.iosClose
        font.pixelSize: 20
        highlighted: true
        anchors.margins: 10
        y: parent.height - height - 12
        anchors.right: parent.right
        onClicked: {
            theDialog.close()
        }
    }

    Loader {
        id: headsupLoader
        sourceComponent: HeadsUpDialog {
            //            message: "Add " + fullName + " into your contacts?"
            message: dialogMessage
            onYes: {
                if (wantToDelete) {
                    Api.deleteContact(iidee)
                    theDialog.close()
                } else {
                    contacts.insertContact(iidee, fullName, phoneInput.text,
                                           emailInput.text)
                }
                console.log("Yippee you accepted!")
            }
        }
    }
}
