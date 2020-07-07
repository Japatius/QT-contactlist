import QtQuick 2.0
import QtQuick.LocalStorage 2.12

Item {

    property variant model: contacts

    ListModel {
        id: contacts
    }

    function initDb() {
        try {
            console.log("Database initialized")
            return LocalStorage.openDatabaseSync("ContactsDatabase", "1.0",
                                                 "Contact DB", 1000000)
        } catch (e) {
            console.error(e)
        }
    }

    function initTable() {
        var db = initDb()

        try {
            db.transaction(function (trx) {
                trx.executeSql(
                            'CREATE TABLE IF NOT EXISTS Contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, email TEXT)')
                //                trx.executeSql(
                //                            'INSERT INTO Contacts VALUES(?,?,?,?)',
                //                            ["", "Test Name", "040123123", "initdata@test.com"])

                //                var rs = trx.executeSql('SELECT * FROM Contacts')

                //                var r = ""
                //                for (var i = 0; i < rs.rows.length; i++) {
                //                    r += rs.rows.item(i).id + ", " + rs.rows.item(
                //                                i).name + ", " + rs.rows.item(
                //                                i).phone + ", " + rs.rows.item(i).email + "\n"
                //                }
                //                console.log(r)
            })
        } catch (e) {
            console.error(e)
        }
    }

    function insertContact(id, name, phone, email) {
        var db = initDb()

        try {
            db.transaction(function (trx) {
                trx.executeSql('INSERT INTO Contacts VALUES(?,?,?,?)',
                               [name, phone, email])
            })

            var tp = tx.executeSql('SELECT * FROM Contacts')
            console.log(tp.rows)
        } catch (e) {
            console.error(e)
        }
    }

    function clearContacts() {
        var db = initDb()

        try {
            db.transaction(function (trx) {
                trx.execute('DELETE * FROM Contacts')
            })
            console.log("erased contacts")
        } catch (e) {
            console.error(e)
        }
    }

    function listContacts(viewId) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                var select = trx.executeSql('SELECT * FROM Contacts')
                for (var i = 0; i < select.rows.length; i++) {
                    viewId.model.append({
                                            "firstName": select.rows.item(
                                                             i).name
                                        })
                    console.log(i)
                }
            })
        } catch (e) {
            console.error(e)
        }
    }
}
