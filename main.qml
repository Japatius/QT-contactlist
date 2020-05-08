import QtQuick 2.13
import QtQuick.Controls 2.13

ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")

    Component.onCompleted: {


        /**
             *  Need to refactor this..
             *  Probably should create a helper file for JS functions..
            **/
        var req = new XMLHttpRequest()
        req.open("GET", "https://qtphone.herokuapp.com/contact", true)
        req.onload = function () {
            var objectArray = JSON.parse(req.responseText)

            for (var i = 0; i < objectArray.length; i++) {
                listView.model.append({
                                          "name": objectArray[i].firstname + " "
                                          + objectArray[i].lastname
                                      })
                console.log(objectArray[i].firstname)
            }
        }
        req.send()

        console.log("blii bloo")
    }

    ListModel {
        id: contactModel
    }
    Component {
        id: contactDelegate
        Rectangle {
            id: contactId
            width: appWindow.width
            height: appWindow.height / 10
            color: "#2C2C2C"
            Text {
                color: "#fff"
                text: name
            }

            Button {
                id: button
                text: "add"
                anchors.right: parent.right
                background: Rectangle {
                    implicitWidth: 50
                    implicitHeight: 20
                    color: button.down ? "black" : "#2C2C2C"
                    border.color: "#ff4"
                    border.width: 1
                    radius: 4
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        delegate: contactDelegate
        model: ContactsModel {}
        spacing: 5

        headerPositioning: ListView.OverlayHeader
        header: Rectangle {
            id: header
            color: "#2C2C2C"
            border.color: "#fff"
            width: parent.width
            height: 50
            z: 2
            Text {
                text: "Contactlist"
                color: "#fff"
                font.pointSize: 20
            }
        }
    }
    footer: Rectangle {
        width: parent.width
        height: 50
        z: 2

        TextInput {
            text: qsTr("Syötä tekstiä tähän...")
        }
    }
}
