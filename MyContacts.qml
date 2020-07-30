import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import "ApiHelper.js" as Api

Item {
    id: savedContact

    //    width: Screen.width
    //    height: Screen.height
    Loader {
        anchors.fill: parent
        //        source: "SavedContact.qml"
        source: "SavedContactsView.qml"
        visible: status == Loader.Ready
    }


    /*Rectangle {
        width: parent.width

        TextField {
            id: enterText
            text: qsTr("Jada jada jada..")
        }
    }*/
}
