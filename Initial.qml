import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Rectangle {
    height: 25
    width: parent.width
    color: Material.color(Material.BlueGrey)
    Label {
        anchors.fill: parent
        leftPadding: 5
        text: section
        font.bold: true
    }
}
