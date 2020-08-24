import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

Item {
    property alias contactId: hiddenId.text
    property alias firstname: name.text
    property real itemHeight: 100
    property string fontColor: "#fff"
    id: contactItem
    height: 80
    width: Screen.width

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    Loader {
        id: deleteDialogLoader
        sourceComponent: HeadsUpDialog {
            message: "Do you wish to delete " + firstname + "?"
            onYes: {
                Api.deleteContact(contactId)
                Api.refreshModel(listView)
            }
        }
    }

    Loader {
        id: editContactLoader
        sourceComponent: editDialogComponent
    }

    Component {
        id: editDialogComponent
        Dialog {
            id: editDialog
            visible: false
            contentItem: EditContactDialog {
                idContact: contactId
            }
        }
    }

    Text {
        id: hiddenId
        visible: false
        text: contactId
    }

    RowLayout {
        anchors.fill: parent
        Label {
            id: name
            text: firstname
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }

        Rectangle {
            width: 30
            height: 30
            radius: 10.0
            color: Material.color(Material.Orange)
            Text {
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                text: Mdi.icon.iosPersonAdd
                color: "white"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    editContactLoader.item.open()
                }
            }
        }

        Rectangle {
            width: 30
            height: 30
            radius: 10.0
            color: Material.color(Material.Red)
            Text {
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                text: Mdi.icon.mdTrash
                color: "white"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    deleteDialogLoader.item.open()
                }
            }
        }
    }
}
