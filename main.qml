import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.12
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

ApplicationWindow {
    id: appWindow
    visible: true
    width: Screen.width
    height: Screen.height
    //    width: 640
    //    height: 480
    title: qsTr("Scroll")

    property string darkColor: "#242424"
    property string whiteColor: "#fff"
    property string titleName: "Contacts"
    property bool isSearchMode: false

    ContactModel {
        id: contacts
    }

    ListModel {
        id: theModel
    }

    ListModel {
        id: dbModel
    }

    Component.onCompleted: {
        contacts.initDb()
        contacts.initTable()
        console.log(Screen.width, Screen.height)
        Api.fetchContacts(theModel)
        console.log("Cur index: ", modelChooser.currentIndex)
    }

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    header: ToolBar {
        contentHeight: toolBtn.implicitHeight
        Material.background: Material.color(Material.BlueGrey)
        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: toolBtn
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                text: Mdi.icon.mdMenu
                onClicked: {
                    drawer.open()
                }
            }

            ComboBox {
                id: modelChooser
                //                anchors {
                //                    horizontalCenter: parent.
                //                    verticalCenter: Qt.AlignVCenter
                //                }
                model: ListModel {
                    ListElement {
                        text: "Contacts"
                    }
                    ListElement {
                        text: "My Contacts"
                    }
                }

                onCurrentTextChanged: {
                    console.log(modelChooser.currentIndex)
                }
            }
            Material.background: Material.color(Material.BlueGrey)
            width: 200
            Layout.fillWidth: true

            //            Label {
            //                text: titleName
            //                elide: Label.ElideRight
            //                horizontalAlignment: Qt.AlignHCenter
            //                verticalAlignment: Qt.AlignVCenter
            //                Layout.fillWidth: true
            //            }
            ToolButton {
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                text: Mdi.icon.mdSearch
                onClicked: {
                    contacts.dropContacts()
                    console.log("blii bloo nyt on kkona")
                }
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 5
        width: parent.width
        height: parent.height
        header: Rectangle {
            id: searchRectangle
            color: "#2C2C2C"
            width: Screen.width
            height: 50
            z: 2
            TextField {
                id: searchField
                color: "#fff"
                width: parent.width
                height: parent.height
                padding: 5
                inputMethodHints: Qt.ImhNoPredictiveText

                onTextChanged: {
                    Api.searchContacts(searchField.text)
                }
            }
        }
        onDragEnded: {
            if (lHeader.refresh) {
                Api.refreshModel(theModel)
            }
        }
        onDragStarted: {
            console.log(listView.contentY)
        }

        ListHeader {
            visible: false
            id: lHeader
            y: -listView.contentY - height
        }
        model: modelChooser.currentIndex <= 0 ? theModel : dbModel

        delegate: ContactItem {
            firstname: contactName
            contactId: idText
        }

        //        delegate: Loader {
        //            id: delegateLoader
        //            sourceComponent: ContactItem {
        //                firstname: contactName
        //                contactId: idText
        //            }
        //        }
        section.property: "contactName"
        section.criteria: ViewSection.FirstCharacter
        section.delegate: Initial {}
    }

    Component {
        id: createComp
        Dialog {
            id: theDialog
            visible: false
            contentItem: ContactDialog {}
        }
    }

    Loader {
        id: createContactLoader
        sourceComponent: createComp
        active: false
    }

    RoundButton {
        text: qsTr("+")
        highlighted: true
        Material.accent: Material.color(Material.BlueGrey)
        anchors.margins: 10
        //        anchors.bottom: contactsView.bottom
        y: parent.height - height - 12
        anchors.right: parent.right
        onClicked: {
            createContactLoader.active = false
            createContactLoader.active = true
            createContactLoader.item.open()
        }
    }

    Drawer {
        id: drawer
        width: appWindow.width * 0.66
        height: appWindow.height

        Column {
            anchors.fill: parent
            Label {
                padding: 10
                font.pointSize: 24
                text: "Contact List"
            }
            ItemDelegate {
                text: qsTr("Contacts")
                width: parent.width
                leftPadding: 15
                padding: 5
                font.pointSize: 20
                onClicked: {
                    titleName = "Contacts"
                    stack.push("main.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("My contacts")
                width: parent.width
                leftPadding: 15
                padding: 5
                font.pointSize: 20
                onClicked: {
                    titleName = "My Contacts"
                    stack.push("MyContacts.qml")
                    drawer.close()
                }
            }
        }
    }

    //    Item {
    //        id: contactPos
    //        Loader {
    //            id: viewLoader
    //            anchors.fill: parent
    //            source: "ContactsView.qml"
    //            asynchronous: true
    //            visible: status == Loader.Ready
    //        }
    //    }
    StackView {
        id: stack
        initialItem: listView
        anchors.fill: parent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }
}
