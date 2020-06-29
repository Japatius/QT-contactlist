import QtQuick 2.0
import QtQuick.LocalStorage 2.12

Item {

    property variant model: contacts

    ListModel {
        id: contacts
    }

    function findGreetings() {
        var db = LocalStorage.openDatabaseSync("ContactDB", "1.0",
                                               "Database for contacts!",
                                               1000000)

        db.transaction(function (tx) {
            // Create the database if it doesn't already exist
            tx.executeSql(
                        'CREATE TABLE IF NOT EXISTS Greeting(salutation TEXT, salutee TEXT)')

            // Add (another) greeting row
            tx.executeSql('INSERT INTO Greeting VALUES(?, ?)',
                          ['hello', 'world'])

            // Show all added greetings
            var rs = tx.executeSql('SELECT * FROM Greeting')

            var r = ""
            for (var i = 0; i < rs.rows.length; i++) {
                r += rs.rows.item(i).salutation + ", " + rs.rows.item(
                            i).salutee + "\n"
            }
            console.log(r)
        })
    }
}
