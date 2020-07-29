import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Rectangle {
    id: searchRectangle
    color: "#2C2C2C"
    width: Screen.width
    height: 50
    z: 2

    //            Button {
    //                id: doSearchBtn
    //                anchors.right: searchField.left
    //                font.family: "Ionicons"
    //                text: Mdi.icon.mdRefresh
    //                padding: 15
    //                onClicked: {

    //                    //                    Api.refreshModel(listView)
    //                }
    //            }
    TextField {
        id: searchField
        color: "#fff"
        width: parent.width
        height: parent.height
        text: "Search.."
        onTextChanged: {
            console.log(searchField.text)
        }
    }
}
