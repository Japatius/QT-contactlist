
/**
 * This file contains all the functions that have something to do with REST API
**/

// get all contacts, sort alphabetically and append into model
function fetchContacts(viewModel) {
    var req = new XMLHttpRequest()
    try {
        req.open("GET", "https://qtphone.herokuapp.com/contact/", true)
        req.onprogress = function () {
            console.log('LOADING', req.readyState) // readyState will be 3
        }
        req.onreadystatechange = function () {
            if (req.readyState === XMLHttpRequest.DONE) {
                var objectArray = JSON.parse(req.responseText)

                var sorted = objectArray.sort(function (a, b) {
                    if (a.firstname < b.firstname) {
                        return -1
                    }
                    if (a.firstname > b.firstname) {
                        return 1
                    }

                    return 0
                })

                for (var i in sorted) {
                    viewModel.append({
                                         "idText": objectArray[i].id,
                                         "contactName": objectArray[i].firstname
                                         + " " + objectArray[i].lastname,
                                         "phone": objectArray[i].mobile,
                                         "email": objectArray[i].email
                                     })
                }
            }
            appWindow.loadingRequest = false
        }
        req.send()
    } catch (e) {
        console.error(e)
    }
}

// refresh contacts
function refreshModel(viewModel) {
    viewModel.clear()
    fetchContacts(viewModel)
    console.log(viewModel.count)
}

// search contacts from API
function searchContacts(searchString) {
    var req = new XMLHttpRequest()
    req.onreadystatechange = function () {
        if (req.readyState === XMLHttpRequest.DONE) {
            var objectArray = JSON.parse(req.responseText)
            theModel.clear()

            var sorted = objectArray.sort(function (a, b) {
                if (a.firstname < b.firstname) {
                    return -1
                }
                if (a.firstname > b.firstname) {
                    return 1
                }

                return 0
            })

            for (var i in sorted) {
                if (sorted[i].firstname.includes(searchString)
                        || sorted[i].lastname.includes(searchString)) {

                    theModel.append({
                                        "idText": objectArray[i].id,
                                        "contactName": objectArray[i].firstname
                                        + " " + objectArray[i].lastname
                                    })
                }
            }
        }
    }
    req.open("GET", "https://qtphone.herokuapp.com/contact")
    req.send()
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
            if (req.readyState === XMLHttpRequest.DONE) {
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
    var req = new XMLHttpRequest()
    try {
        req.open("PUT", "https://qtphone.herokuapp.com/contact/" + id, true)
        req.setRequestHeader('Content-type', 'application/json; charset=utf-8')
        req.onload = function () {
            var users = JSON.parse(req.responseText)
            if (req.readyState === XMLHttpRequest.DONE) {
                console.log(users)
            }
        }
        req.send(json)
    } catch (e) {
        console.error(e)
    }
}

// delete contact
function deleteContact(id) {
    var req = new XMLHttpRequest()
    try {
        req.open("DELETE", "https://qtphone.herokuapp.com/contact/" + id, true)
        req.send()
        refreshModel(theModel)
    } catch (e) {
        console.error(e)
    }
}
