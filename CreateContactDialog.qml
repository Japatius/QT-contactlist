import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12

GridLayout {
    id: grid
    columns: 2
    rows: 5

    width: appWindow.width
    height: 600
    property string firstname
    property string lastname
    property string mobile
    property string email
    property string placeholderText: "Enter"
    property int inputWidth: 100
    property alias closeButton: closeButton
    property string testString

    Label {
        text: qsTr("Firstname")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextField {
        id: firstnameInput
        Layout.fillWidth: inputWidth
        Layout.minimumWidth: grid.minimumInputSize
        placeholderText: placeholderText
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    Label {
        text: qsTr("Lastname")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextField {
        id: lastnameInput
        Layout.fillWidth: inputWidth
        Layout.minimumWidth: grid.minimumInputSize
        placeholderText: placeholderText
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    Label {
        text: qsTr("Email")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextField {
        id: emailInput
        Layout.fillWidth: inputWidth
        Layout.minimumWidth: grid.minimumInputSize
        placeholderText: placeholderText
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    Label {
        text: qsTr("Mobile")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextField {
        id: mobileInput
        Layout.fillWidth: inputWidth
        Layout.minimumWidth: grid.minimumInputSize
        placeholderText: placeholderText
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    Button {
        id: submitButton
        text: qsTr("Submit")
        onClicked: {


            /**
                  * TODO: do some validations
                  **/
            var url = "https://qtphone.herokuapp.com/contact"

            var data = {}
            data.firstname = firstnameInput.text
            data.lastname = lastnameInput.text
            data.email = emailInput.text
            data.mobile = mobileInput.text
            var json = JSON.stringify(data)

            var req = new XMLHttpRequest()
            req.open("POST", url, true)
            req.setRequestHeader('Content-type',
                                 'application/json; charset=utf-8')
            req.onload = function () {
                var contacts = JSON.parse(req.responseText)
                if (req.readyState === 4 && req.status === "201") {
                    firstnameInput.text = ""
                    lastnameInput.text = ""
                    emailInput.text = ""
                    mobileInput.text = ""
                    console.log(contacts)
                } else {
                    console.log(contacts)
                }
            }
            req.send(json)
        }
    }

    Button {
        id: closeButton
        text: qsTr("Close")
    }
}
