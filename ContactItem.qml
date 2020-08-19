import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import "ApiHelper.js" as Api
import "Icons.js" as Mdi

Item {
    property alias contactId: hiddenId.text
    property alias firstname: name.text
    property alias heightOfParent: contactItem.height
    property real itemHeight: 100
    property string fontColor: "#fff"

    id: contactItem
    height: heightOfParent
    width: Screen.width

    FontLoader {
        id: fontLoader
        source: "ionicons.ttf"
    }

    Loader {
        id: dialogLoader
        active: false
        sourceComponent: dialogComponent
    }

    Component {
        id: dialogComponent
        Dialog {
            id: theDialog
            visible: false
            contentItem: ContactDialog {
                iidee: contactId
            }
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width
        color: "#2C2C2C"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(contactId)
                dialogLoader.active = false
                dialogLoader.active = true
                dialogLoader.item.open()
            }
        }

        Rectangle {
            id: letterContainer
            height: 40
            width: 40
            radius: 50
            Text {
                text: firstname.charAt(0)
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 20
            }
        }

        Text {
            id: hiddenId
            visible: false
            text: contactId
        }

        Rectangle {
            border.color: "#fff"
            anchors {
                left: letterContainer.right
                baseline: letterContainer.baseline
                leftMargin: 10
            }
            Text {
                id: name
                text: firstname
                color: fontColor
                leftPadding: 5
                topPadding: 5
            }
        }
    }

    //    Rectangle {
    //        height: parent.height
    //        width: parent.width
    //        color: "#2C2C2C"
    //        Rectangle {
    //            id: letCont
    //            height: 40
    //            width: 40
    //            radius: 50
    //            Text {
    //                text: firstname.charAt(0)
    //                anchors {
    //                    horizontalCenter: parent.horizontalCenter
    //                    verticalCenter: parent.verticalCenter
    //                }
    //            }
    //            anchors {
    //                left: parent.left
    //                verticalCenter: parent.verticalCenter
    //                leftMargin: 20
    //            }
    //        }

    //        Text {
    //            id: hiddenId
    //            visible: false
    //            text: contactId
    //        }

    //        MouseArea {
    //            anchors.fill: parent
    //            onClicked: {
    //                console.log(contactId)
    //                dialogLoader.active = false
    //                dialogLoader.active = true
    //                dialogLoader.item.open()
    //            }
    //        }

    //        Text {
    //            id: name
    //            text: firstname
    //            color: fontColor
    //            leftPadding: 5
    //            topPadding: 5
    //            anchors {
    //                left: letCont.right
    //                leftMargin: 10
    //            }
    //        }

    //        Text {
    //            id: phoneNumber
    //            text: phone
    //            color: fontColor
    //            leftPadding: 5
    //            anchors {
    //                top: name.bottom
    //                left: letCont.right
    //                leftMargin: 10
    //            }
    //        }
    //    }
}
