import QtQuick 2.0

Rectangle {
    id: contactId
    width: appWindow.width
    height: appWindow.height / 10
    color: "#2C2C2C"
    Text {
        color: "#fff"
        text: nameLoc
    }
    Text {
        color: "#fff"
        text: numLoc
    }

//    Button {
//        id: button
//        text: "add"
//        anchors.right: parent.right
//        background: Rectangle {
//            implicitWidth: 50
//            implicitHeight: 20
//            color: button.down ? "black" : "#2C2C2C"
//            border.color: "#ff4"
//            border.width: 1
//            radius: 4

//        }
//    }
}
