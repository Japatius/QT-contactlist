import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

ApplicationWindow {
    id: contactDialog
    width: appWindow.width
    height: appWindow.height
    visible: true

    property string recievedId
    property alias okButton: okButton
    property alias cancelButton: cancelButton
    property string title: "Foo Bar"
    property string fNameText: "Firstname"
    property string lNameText: "Lastname"
    property string emailText: "Email"
    property string mobileText: "Mobile"
    property string updateText: "Update"

    property string fName
    property string lName
    property string email
    property string mobile

    property string whiteColor: "#fff"
    property string blackColor: "#000000"
    property string darkColor: "#242424"

    // toggling edit state for inputs
    property bool fnameEdit: false
    property bool lnameEdit: false
    property bool emailEdit: false
    property bool mobileEdit: false

    property int titleSize: 48
    property int tstid: 16

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    ContactModel {
        id: contactModel
    }

    Component.onCompleted: {
        var req = new XMLHttpRequest()
        // TODO: Pass ID when opening dialog
        req.open("GET",
                 "https://qtphone.herokuapp.com/contact/" + recievedId, true)
        req.onload = function () {
            var objectArray = JSON.parse(req.responseText)
            for (var i = 0; i < objectArray.length; i++) {
                fName = objectArray[i].firstname
                lName = objectArray[i].lastname
                email = objectArray[i].email
                mobile = objectArray[i].mobile
                console.log(fName, lName, email, mobile)
                console.log(recievedId)
            }
        }
        req.send()
    }

    Rectangle {
        id: backgroundRectangle
        height: parent.height
        width: parent.width
        color: "#282828"

        Column {
            anchors.fill: parent
            width: appWindow.width
            spacing: 10
            Rectangle {
                width: 100
                height: 100
                color: whiteColor
                radius: width * 0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    id: contactDialogName
                    text: fName.charAt(0)
                    font.pointSize: titleSize
                    color: blackColor
                }
            }

            Rectangle {
                width: parent.width
                height: 60
                color: darkColor
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: fNameTextId
                    color: whiteColor
                    text: fNameText
                }

                TextField {
                    anchors {
                        baseline: fNameTextId.baseline
                        horizontalCenter: parent.horizontalCenter
                        left: fNameTextId.right
                        leftMargin: 15
                    }

                    id: firstNameInput
                    readOnly: fnameEdit
                    text: fName
                    color: whiteColor
                }
            }

            Rectangle {
                width: parent.width
                height: 60
                color: darkColor
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: lNameTextId
                    color: whiteColor
                    text: lNameText
                }

                TextField {
                    anchors {
                        baseline: lNameTextId.baseline
                        horizontalCenter: parent.horizontalCenter
                        left: lNameTextId.right
                        leftMargin: 15
                    }
                    id: lastNameInput
                    readOnly: lnameEdit
                    text: lName
                    color: whiteColor
                }
            }

            Rectangle {
                width: parent.width
                height: 60
                color: darkColor
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: mobileTextId
                    color: whiteColor
                    text: mobileText
                }

                TextField {
                    anchors {
                        baseline: mobileTextId.baseline
                        horizontalCenter: parent.horizontalCenter
                        left: mobileTextId.right
                        leftMargin: 15
                    }
                    id: mobileInput
                    readOnly: lnameEdit
                    text: mobile
                    color: whiteColor
                }
            }

            Rectangle {
                width: parent.width
                height: 60
                color: darkColor
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: emailTextId
                    color: whiteColor
                    text: emailText
                }

                TextField {
                    anchors {
                        baseline: emailTextId.baseline
                        horizontalCenter: parent.horizontalCenter
                        left: emailTextId.right
                        leftMargin: 15
                    }
                    id: emailInput
                    readOnly: lnameEdit
                    text: email
                    color: whiteColor
                }
            }

            Rectangle {
                width: parent.width
                height: 60
                color: "#282828"
                Button {
                    id: updateButton
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: updateText
                    onClicked: {
                        Api.updateContact(recievedId, firstNameInput.text,
                                          lastNameInput.text, mobileInput.text,
                                          emailInput.text)
                    }
                }
            }
        }

        Row {
            anchors {
                bottom: backgroundRectangle.bottom
                horizontalCenter: horizontalCenter
            }

            Button {
                id: okButton
                text: "OK"
            }
            Button {
                id: cancelButton
                text: "Close"
                onClicked: {
                    contactDialog.destroy()
                    Api.refreshModel(listView)
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
        onClicked: {
            contactModel.insertContact(recievedId, fName, mobile, email)
        }
    }
}
