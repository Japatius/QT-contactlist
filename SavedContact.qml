import QtQuick 2.0
import QtQuick.Controls 2.12

Item {

    ListModel {
        id: listModelo
        ListElement {
            name: "Kontakti1"
            number: "123"
            email: "1@1.fi"
        }
        ListElement {
            name: "Kontakti2"
            number: "1234"
            email: "2@2.fi"
        }
        ListElement {
            name: "Kontakti3"
            number: "12345"
            email: "3@3.fi"
        }
    }

    Rectangle {
        width: 180
        height: 200

        Component {
            id: contactDelegate
            Item {
                width: 180
                height: 40
                Column {
                    Text {
                        text: '<b>Name:</b> ' + name
                    }
                    Text {
                        text: '<b>Number:</b> ' + number
                    }
                    Text {
                        text: '<b>Email:</b> ' + email
                    }
                }
            }
        }

        ListView {
            anchors.fill: parent
            model: listModelo
            delegate: contactDelegate
            spacing: 10
            highlight: Rectangle {
                color: "lightsteelblue"
                radius: 5
            }
            focus: true
        }
    }
}
