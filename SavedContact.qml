import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.12

Item {
    width: Screen.width
    height: Screen.height

    ListView {
        id: savedContactList
        anchors.fill: parent
        model: ListModel {}
        spacing: 10
        delegate: Rectangle {
            width: parent.width
            height: 50
            border.color: "#fff"

            Text {
                id: name
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                font.pointSize: 16
                color: "#000000"
                text: "incoming"

                function findContacts() {
                    var db = LocalStorage.openDatabaseSync(
                                "ContactsDatabase", "1.0",
                                "Database for contacts", 1000000)

                    db.transaction(function (tx) {
                        // create DB
                        tx.executeSql(
                                    'CREATE TABLE IF NOT EXISTS Contacts(firstname TEXT, phone TEXT)')

                        tx.executeSql('INSERT INTO Contacts VALUES (?, ?)',
                                      ['Matti Mallikas', '358012331'])

                        var getGot = tx.executeSql('SELECT * FROM Contacts')

                        var res = ""
                        for (var i = 0; i < getGot.rows.length; i++) {

                            res += getGot.rows.item(
                                        i).firstname + ": " + getGot.rows.item(
                                        i).phone + "\n"
                        }
                        text = res
                    })
                }
                Component.onCompleted: {
                    findContacts()
                }
            }
        }
    }
}
