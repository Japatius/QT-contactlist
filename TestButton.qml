import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: nappi
    signal testaus(variant nimi)

    property alias iidee: tekstiä.text
    width: 200
    height: 400

    Rectangle {
        width: parent.width
        height: parent.height
        Text {
            id: tekstiä
            text: iidee
        }
        Button {
            text: "Sulje"
            onClicked: {
                console.log(iidee)
            }
        }
    }

    //    Button {
    //        id: asdi
    //        text: nimiArvo
    //        onClicked: {
    //            console.log(nimiArvo)
    //        }
    //    }
}
