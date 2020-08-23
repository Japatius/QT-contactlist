import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "ApiHelper.js" as Api

Row {
    height: 50
    width: parent.width
    spacing: 10

    TextField {
        id: searchField
        anchors.fill: parent
        placeholderText: qsTr("Search")
        inputMethodHints: Qt.ImhNoPredictiveText
        onTextChanged: {
            Api.searchContacts(searchField.text)
        }
    }
}
