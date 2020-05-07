import QtQuick 2.0
import QtQuick.Controls 2.13

Item {

    Component.onCompleted: {
        for (var i = 0; i < 10; i++) {
            listView.model.append({textLoc: "Porfavor amigo" + i})
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        width: parent.width
        model: ListModel {}
        spacing: 5
        delegate: Text {
            text: textLoc
            color: "#00FF00"
        }

    }
}
