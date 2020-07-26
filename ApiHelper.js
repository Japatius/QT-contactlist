let URL = "https://qtphone.herokuapp.com/contact"


/**
  * Get contacts & append data for contacts list
  **/
function fetchContacts(viewId) {
    var req = new XMLHttpRequest()
    try {
        req.open("GET", URL, true)
        req.onload = function () {
            var objectArray = JSON.parse(req.responseText)

            for (var i = 0; i < objectArray.length; i++) {
                viewId.model.append({
                                        "contactName": objectArray[i].firstname
                                        + " " + objectArray[i].lastname,
                                        "contactNumber": objectArray[i].mobile,
                                        "idText": objectArray[i].id
                                    })
            }
        }
        req.send()
    } catch (e) {
        console.error(e)
    }
}

function refreshModel(viewId) {
    viewId.model.clear()
    fetchContacts(viewId)
    console.log(viewId.count)
}


/**
  * Get contact by ID
  **/
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


/**
  * Create a new contact
  **/
function createContact(firstname) {
    var req = new XMLHttpRequest()
    req.open("POST", URL, true)
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")

    req.send({
                 "firstname": firstname
             })
}


/**
  * Update a contact
  **/
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


/**
  * Delete a contact
  **/
function deleteContact() {}
