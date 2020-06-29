import QtQuick 2.0

// Icon component
Item {
    property string iconName
    property string iconColor
    property int pointSize

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    Text {
        id: icon
        font.family: "Ionicons"
        font.pointSize: pointSize
        text: iconName
        color: iconColor
    }
}
