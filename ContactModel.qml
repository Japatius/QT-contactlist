import QtQuick 2.13
import "HttpHelper.js" as HttpHelper

Rectangle {
    id: container
    width: 500; height: 400
    color: "#343434"
    property string  URL: "https://qtphone.herokuapp.com/contact"

    ListModel {
        id: contacts

        ListElement {
            name: "John Wick";
            attributes: [
                ListElement { description: "Breathtaking" }
            ]
        }

        ListElement {
            name: "Chuck Norris";
            attributes: [
                ListElement { description: "Legend" }
            ]
        }

        ListElement {
            name: "Kim Jong Un";
            attributes: [
                ListElement { description: "a Manchild" }
            ]
        }

        ListElement {
            name: "Donald Trump";
            attributes: [
                ListElement { description: "China!" }
            ]
        }
    }

    Component {
        id: listDelegate

        Item {
            id: delegateItem
            width: listView.width; height: 80
            clip: true

            Column {
                anchors {
                    left: arrows.right
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.verticalCenter
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: name
                    font.pixelSize: 15
                    color: "white"
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 5
                    Repeater {
                        model: attributes
                        Text { text: description; color: "White" }
                    }
                }
            }
            Item {
                anchors {
                    left: arrows.right
                    horizontalCenter: parent.horizontalCenter;
                    top: parent.verticalCenter
                    bottom: parent.bottom
                }

                Row {
                    anchors.centerIn: parent
                    spacing: 10

                    Rectangle
                }
            }

        }

    }

    /*function getContacts() {
        var data = HttpHelper.fetch("https://qtphone.herokuapp.com/contact");
        data.then(function(res) {
            contacts.append(res)
            console.log(res)
        })

    }*/

}
