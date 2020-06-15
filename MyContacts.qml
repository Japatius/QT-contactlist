import QtQuick 2.0
import QtQuick.Controls 2.12
import "ApiHelper.js" as Api

Item {
    id: savedContact

    Loader {
        source: "SavedContact.qml"
    }


    /*Rectangle {
        width: parent.width

        TextField {
            id: enterText
            text: qsTr("Jada jada jada..")
        }
    }*/
}
