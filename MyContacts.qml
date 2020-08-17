import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import "ApiHelper.js" as Api

Item {
    id: savedContact
    Loader {
        anchors.fill: parent
        source: "SavedContactsView.qml"
        visible: status == Loader.Ready
    }
}
