import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item {
    //    readonly property int animationDuration: 750
    property alias isRunning: animation.running
    height: 100
    width: 100

    BusyIndicator {
        width: parent.width
        height: parent.height
        id: animation
        Material.accent: Material.color(Material.BlueGrey)
        running: running
    }
}
