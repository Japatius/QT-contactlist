import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import "Icons.js" as Mdi

Item {
    width: parent.width
    height: parent.height
    property int parentHeight: 150
    property string rectangleColor: "#2C2C2C"
    property string textColor: "#fff"

    Rectangle {
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        width: 50
        height: 50
        Text {
            text: qsTr("Vamos amigos!")
        }
    }
}
