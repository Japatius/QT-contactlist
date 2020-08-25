import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "ApiHelper.js" as Api
import "Res.js" as Resource

Rectangle {
    height: 50
    width: parent.width
    color: Resource.colors.darkGray
    z: 100

    ContactModel {
        id: contacts
    }

    TextField {
        id: searchField
        Material.accent: Material.color(Material.BlueGrey)
        width: parent.width - 20
        placeholderText: Resource.placeholders.search
        color: Resource.colors.white
        inputMethodHints: Qt.ImhNoPredictiveText
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        onTextChanged: {
            if (modelChooser.currentIndex <= 0) {
                Api.searchContacts(searchField.text)
            } else {
                contacts.searchContacts(searchField.text)
            }
        }
    }
}
