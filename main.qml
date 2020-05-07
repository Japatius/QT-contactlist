import QtQuick 2.13
import QtQuick.Controls 2.13

ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")

    // testing data fetching...
    function getData(url, callback) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = (function(data) {
            return function() {
                if (data.readystate === 4) {
                    callback(data);
                }
            }
        })(xhttp);
        xhttp.open("GET", url);
        xhttp.send();

    }

    Component.onCompleted: {
        for (var i = 0; i < 10; i++) {
            listView.model.append({ textLoc: "Contact " + i })
        }

        getData("https://qtphone.herokuapp.com/contact", function(fn) {
            if (fn.status === 200) {
                console.log(fn.responseText);
            } else {
                console.log("error occurred")
            }
        })
    }

    ListView {
        id: listView
        anchors.fill: parent
        width: parent.width
        model: ListModel {}
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

        delegate: Rectangle {
            id: contactId
            width: appWindow.width
            height: appWindow.height / 10
            color: "#2C2C2C"
            Text {
                color: "#fff"
                text: textLoc
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

}
