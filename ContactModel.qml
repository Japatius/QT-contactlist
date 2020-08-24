import QtQuick 2.0
import QtQuick.LocalStorage 2.12

Item {
    property variant model: contacts
    property string dbName: "ContactsDB"
    property string version: "1.0"
    property string description: "Database for contacts"
    property real limit: 1000000

    ListModel {
        id: contacts
    }

    function initDb() {
        try {
            return LocalStorage.openDatabaseSync(dbName, version,
                                                 description, limit)
        } catch (e) {
            console.error(e)
        }
    }

    function initTable() {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                var sql = 'CREATE TABLE IF NOT EXISTS Contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, phone TEXT, email TEXT)'
                trx.executeSql(sql)
                console.log("TABLE CREATED")
            })
        } catch (e) {
            console.error(e)
        }
    }

    function clearContacts() {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                trx.executeSql('DELETE FROM Contacts')
            })
            console.log("erased contacts")
        } catch (e) {
            console.error(e)
        }
    }

    function dropContacts() {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                trx.executeSql('DROP TABLE Contacts')
            })
            console.log("kontaktipöytä poistettu")
        } catch (e) {
            console.error(e)
        }
    }

    function listContacts(viewModel) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                var select = trx.executeSql('SELECT * FROM Contacts')
                for (var i = 0; i < select.rows.length; i++) {
                    viewModel.append({
                                         "id": select.rows.item(i).id,
                                         "firstname": select.rows.item(
                                                          i).firstname,
                                         "lastname": select.rows.item(
                                                         i).lastname,
                                         "phone": select.rows.item(i).phone,
                                         "email": select.rows.item(i).email
                                     })
                }
            })
        } catch (e) {
            console.error(e)
        }
    }

    function refreshSavedContacts(viewId) {
        viewId.model.clear()
        listContacts(viewId)
    }

    //    function fetchOne(id) {
    //        var db = initDb()
    //        try {
    //            db.transaction(function (trx) {
    //                trx.executeSql('SELECT * from Contacts WHERE id=?', [id])
    //                var res = trx.executeSql(
    //                            'SELECT * from Contacts WHERE id is $1', [id])
    //                var select = executeSql('SELECT * from Contacts WHERE id=?',
    //                                        [id])
    //                for (var i = 0; i < select.rows.length; i++) {

    //                }

    //                console.log(res.name)
    //            })
    //        } catch (e) {
    //            console.error(e)
    //        }
    //    }
    function insertContact(name, phone, email) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                //                var sql = 'INSERT INTO Contacts(name, phone, email) VALUES(?,?,?)'
                trx.executeSql(
                            'INSERT INTO Contacts(name, phone, email) VALUES(?,?,?)',
                            [name, phone, email])
                var tp = trx.executeSql('SELECT * FROM Contacts')
            })
        } catch (e) {
            console.error(e)
        }
    }

    function updateContact(name, phone, email, id) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                trx.executeSql(
                            'UPDATE Contacts SET name=?, SET phone=?, SET email=? WHERE id=?',
                            [name, phone, email, id])
            })
        } catch (e) {
            console.error(e)
        }
    }

    function deleteContact(id) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                trx.executeSql('DELETE FROM Contac ts WHERE id=?', [id])
            })
            console.log("Deleted: ", id)
        } catch (e) {
            console.error(e)
        }
    }
}
