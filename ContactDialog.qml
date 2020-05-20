import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "ApiHelper.js" as Api

Item {
    id: contactDialog
    width: appWindow.width
    height: 600
    property string recievedId
    property alias okButton: okButton
    property alias cancelButton: cancelButton
    property string title: "Foo Bar"
    property string fNameText: "Firstname"
    property string lNameText: "Lastname"
    property string emailText: "Email"
    property string mobileText: "Mobile"

    property string fName
    property string lName
    property string email
    property string mobile

    property string whiteColor: "#fff"
    property string blackColor: "#000000"

    // toggling edit state for inputs
    property bool fnameEdit: false
    property bool lnameEdit: false
    property bool emailEdit: false
    property bool mobileEdit: false

    property int titleSize: 48
    property int tstid: 16

    Component.onCompleted: {
        var req = new XMLHttpRequest()
        // TODO: Pass ID when opening dialog
        req.open("GET", "https://qtphone.herokuapp.com/contact/16", true)
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

    Component.onDestruction: {
        Api.fetchContacts()
    }

    Rectangle {
        id: backgroundRectangle
        height: parent.height
        width: appWindow.width
        color: "#757575"
        Column {
            width: appWindow.width
            spacing: 10
            anchors.fill: parent
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
                color: blackColor
                Text {
                    id: fNameTextId
                    color: whiteColor
                    text: fNameText
                }

                TextField {
                    anchors {
                        left: fNameTextId.right
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
                color: blackColor
                Text {
                    id: lNameTextId
                    color: whiteColor
                    text: lNameText
                }

                TextField {
                    anchors {
                        left: lNameTextId.right
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
                color: blackColor
                Text {
                    id: mobileTextId
                    color: whiteColor
                    text: mobileText
                }

                TextField {
                    anchors {
                        left: mobileTextId.right
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
                color: blackColor
                Text {
                    id: emailTextId
                    color: whiteColor
                    text: emailText
                }

                TextField {
                    anchors {
                        left: emailTextId.right
                        leftMargin: 10
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
                color: blackColor
                Button {
                    text: "Test"
                    onClicked: {
                        Api.updateContact(firstNameInput.text,
                                          lastNameInput.text, mobileInput.text,
                                          emailInput.text)
                    }
                }
            }
        }

        //    Rectangle {
        //        width: parent.width
        //        height: parent.height

        //        Text {
        //            anchors {
        //                horizontalCenter: parent.horizontalCenter
        //            }
        //            id: contactDialogName
        //            text: title
        //            font.pointSize: titleSize
        //        }

        //        Text {
        //            id: firstName
        //            text: fNameText
        //            anchors.baseline: firstNameInput.baseline
        //        }

        //        TextField {
        //            anchors.top: contactDialogName.bottom
        //            anchors {
        //                top: contactDialogName.bottom
        //                horizontalCenter: parent.horizontalCenter
        //            }
        //            id: firstNameInput
        //            readOnly: fnameEdit
        //            placeholderTextColor: "black"
        //            placeholderText: qsTr("Enter firstname..")
        //        }

        //        Text {
        //            id: lastName
        //            text: lNameText
        //            anchors.baseline: lastNameInput.baseline
        //        }

        //        TextField {
        //            anchors {
        //                top: firstNameInput.bottom
        //                horizontalCenter: parent.horizontalCenter
        //            }
        //            id: lastNameInput
        //            readOnly: lnameEdit
        //            placeholderTextColor: "black"
        //            placeholderText: qsTr("Enter lastname..")
        //        }

        //        Button {
        //            // TODO: make into icon button
        //            id: toggleFnameButton
        //            text: "tglFname"
        //            anchors.left: firstNameInput.right
        //        }

        //        Button {
        //            // TODO: make into icon button
        //            id: toggleLnameButton
        //            text: "tgLname"
        //            anchors.left: lastNameInput.right
        //        }

        //        Button {
        //            id: updateBtn
        //            text: "Update"
        //            onClicked: {
        //                console.log("Do updating..")
        //            }
        //            anchors {
        //                horizontalCenter: parent.horizontalCenter
        //                top: lastNameInput.bottom
        //            }
        //        }
        //    }
        Row {
            anchors.bottom: backgroundRectangle.bottom
            Button {
                id: okButton
                text: "OK"
            }

            Button {
                id: cancelButton
                text: "NOPE"
            }
        }
    }
}
