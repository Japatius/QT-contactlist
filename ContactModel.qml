import QtQuick 2.12
import QtQuick.LocalStorage 2.12
import "Res.js" as Resource

Item {
    ListModel {
        id: contacts
    }

    function initDb() {
        try {
            return LocalStorage.openDatabaseSync(Resource.database.name,
                                                 Resource.database.version,
                                                 Resource.database.description,
                                                 Resource.database.limit)
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
            refreshSavedContacts(dbModel)
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
                                         "idText": select.rows.item(i).id,
                                         "contactName": select.rows.item(
                                                            i).firstname + " " + select.rows.item(
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
        viewId.clear()
        listContacts(viewId)
    }

    function insertContact(firstname, lastname, phone, email) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                trx.executeSql(
                            'INSERT INTO Contacts(firstname, lastname, phone, email) VALUES(?,?,?,?)',
                            [firstname, lastname, phone, email])
                var tp = trx.executeSql('SELECT * FROM Contacts')
            })
            refreshSavedContacts(dbModel)
        } catch (e) {
            console.error(e)
        }
    }

    function updateContact(id, firstname, lastname, mobile, email) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                trx.executeSql(
                            'UPDATE Contacts SET firstname=?, lastname=?, phone=?, email=? WHERE id=?',
                            [firstname, lastname, mobile, email, id])
            })
            //            refreshSavedContacts(dbModel)
        } catch (e) {
            console.error(e)
        }
    }

    function searchContacts(searchString) {
        var db = initDb()
        dbModel.clear()

        db.transaction(function (trx) {

            var res = trx.executeSql(
                        'SELECT * from Contacts WHERE firstname LIKE ? OR lastname LIKE ?',
                        [searchString, searchString])
            for (var i = 0; i < res.rows.length; i++) {
                dbModel.append({
                                   "idText": res.rows.item(i).id,
                                   "contactName": res.rows.item(
                                                      i).firstname + " " + res.rows.item(
                                                      i).lastname
                               })
            }
        })
    }

    function deleteContact(id) {
        var db = initDb()
        try {
            db.transaction(function (trx) {
                trx.executeSql('DELETE FROM Contacts WHERE id=?', [id])
            })
            console.log("Deleted: ", id)
            refreshSavedContacts(dbModel)
        } catch (e) {
            console.error(e)
        }
    }
}
