import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: nappi
    signal testaus(variant nimi)
    property alias nimiArvo: asdi.text

    Button {
        id: asdi
        text: nimiArvo
        onClicked: {
            console.log(nimiArvo)
        }
    }
}
