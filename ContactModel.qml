import QtQuick 2.0
import QtQuick.LocalStorage 2.12

Item {

    property variant model: contacts

    ListModel {
        id: contacts
    }

    function initDb() {
        return LocalStorage.openDatabaseSync("ContactsDatabase", "1.0",
                                             "Contact DB", 1000000)
    }

    function initTable() {
        var db = initDb()

        try {
            db.transaction(function (trx) {
                trx.executeSql(
                            'CREATE TABLE IF NOT EXISTS Contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, email TEXT)')
                trx.executeSql(
                            'INSERT INTO Contacts VALUES(?,?,?,?)',
                            ["", "Test Name", "040123123", "initdata@test.com"])

                var rs = trx.executeSql('SELECT * FROM Contacts')

                var r = ""
                for (var i = 0; i < rs.rows.length; i++) {
                    r += rs.rows.item(i).id + ", " + rs.rows.item(
                                i).name + ", " + rs.rows.item(
                                i).phone + ", " + rs.rows.item(i).email + "\n"
                }
                console.log(r)
            })
        } catch (e) {
            console.error(e)
        }
    }

    function insertContact(name, phone, email) {
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

    //    function findGreetings() {
    //        var db = LocalStorage.openDatabaseSync("ContactDB", "1.0",
    //                                               "Database for contacts!",
    //                                               1000000)

    //        db.transaction(function (tx) {
    //            // Create the database if it doesn't already exist
    //            tx.executeSql(
    //                        'CREATE TABLE IF NOT EXISTS Greeting(salutation TEXT, salutee TEXT)')

    //            //            tx.executeSql('INSERT INTO Greeting VALUES(?, ?)',
    //            //                          ['hello', 'world'])

    //            // Show all added greetings
    //            var rs = tx.executeSql('SELECT * FROM Greeting')

    //            var r = ""
    //            for (var i = 0; i < rs.rows.length; i++) {
    //                r += rs.rows.item(i).salutation + ", " + rs.rows.item(
    //                            i).salutee + "\n"
    //            }
    //            console.log(r)
    //        })
    //    }
}
