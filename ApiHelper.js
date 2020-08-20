
/**
 * This file contains all the functions that have something to do with REST API
**/

// get all contacts and append into model
function fetchContacts(viewId) {
    var req = new XMLHttpRequest()
    try {
        req.open("GET", "https://qtphone.herokuapp.com/contact/", true)
        req.onload = function () {
            var objectArray = JSON.parse(req.responseText)

            for (var i = 0; i < objectArray.length; i++) {
                viewId.model.append({
                                        "idText": objectArray[i].id,
                                        "contactName": objectArray[i].firstname
                                        + " " + objectArray[i].lastname
                                    })
            }
        }
        req.send()
    } catch (e) {
        console.error(e)
    }
}

// refresh contacts
function refreshModel(viewId) {
    viewId.model.clear()
    fetchContacts(viewId)
    console.log(viewId.count)
}

// get contact by id
function fetchContactById(id) {
    var req = new XMLHttpRequest()
    req.open("GET", "https://qtphone.herokuapp.com/contact/" + id, true)
    req.onload = function () {
        var objectArray = JSON.parse(req.responseText)
        for (var i = 0; i < objectArray.length; i++) {

            console.log("with id: ", objectArray[i].id,
                        objectArray[i].firstname)
        }
    }
    req.send()
}

// search contacts from API
function searchContacts(searchString) {
    try {

        if (!searchString) {
            return
        }

        var req = new XMLHttpRequest()
        req.open("GET", "https://qtphone.herokuapp.com/contact", true)
        req.onload = function () {
            var objectArray = JSON.parse(req.responseText)
            listView.model.clear()

            for (var i = 0; i < objectArray.length; i++) {
                if (objectArray[i].firstname.includes(searchString)
                        || objectArray[i].lastname.includes(searchString)) {
                    console.log(objectArray[i].firstname)
                    listView.model.append({
                                              "idText": objectArray[i].id,
                                              "contactName": objectArray[i].firstname
                                              + " " + objectArray[i].lastname
                                          })
                }
            }
        }

        req.send()
    } catch (e) {
        console.error(e)
    }
}

// create new contact
function createContact(firstname, lastname, email, phone) {
    try {
        var data = {}
        data.firstname = firstname
        data.lastname = lastname
        data.email = email
        data.mobile = phone
        var json = JSON.stringify(data)

        var req = new XMLHttpRequest()
        req.open("POST", "https://qtphone.herokuapp.com/contact", true)
        req.setRequestHeader('Content-type', 'application/json; charset=utf-8')
        req.onload = function () {
            var contacts = JSON.parse(req.responseText)
            if (req.readyState === 4 && req.status === "201") {
                console.log("201", contacts)
            }
        }
        req.send(json)
    } catch (e) {
        console.error(e)
    }
}

// update contact
function updateContact(id, firstName, lastName, mobile, email) {
    var data = {}
    data.firstname = firstName
    data.lastname = lastName
    data.mobile = mobile
    data.email = email
    var json = JSON.stringify(data)
    var xhr = new XMLHttpRequest()
    try {
        xhr.open("PUT", "https://qtphone.herokuapp.com/contact/" + id, true)
        xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8')
        xhr.onload = function () {
            var users = JSON.parse(xhr.responseText)
            if (xhr.readyState === 4 && xhr.status === "200") {
                console.log(users)
            } else {
                console.error(users)
            }
        }
        xhr.send(json)
    } catch (e) {
        console.error(e)
    }
}

// delete contact
function deleteContact(id) {
    var xhr = new XMLHttpRequest()
    try {
        xhr.open("DELETE", "https://qtphone.herokuapp.com/contact/" + id, true)
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('DELETE HEADERS_RECEIVED')
            } else if (xhr.readyState === XMLHttpRequest.DONE) {
                print('DELETE DONE')
            }
        }
        xhr.send()
    } catch (e) {
        console.error(e)
    }
}
