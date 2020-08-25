import QtQuick 2.12

Item {
    height: 60
    width: parent.width
    property bool refresh: state == "pulled" ? true : false
    z: -1
    Row {
        spacing: 6
        height: 50
        anchors.centerIn: parent

        Text {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            text: "Pull to refresh..."
            font.pixelSize: 18
            color: "#999999"
        }
    }

    states: [
        State {
            name: "base"
            when: listView.contentY >= -120
        },
        State {
            name: "pulled"
            when: listView.contentY <= -120
            PropertyChanges {
                target: label
                text: "Release to refresh..."
            }
        }
    ]
}
