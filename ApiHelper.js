let URL = "https://qtphone.herokuapp.com/contact"

function func() {
    return console.log("Moro")
}


/**
  * Get contacts & append data for contacts list
  **/
function fetchContacts(viewId) {
    var req = new XMLHttpRequest()
    req.open("GET", URL, true)
    req.onload = function () {
        var objectArray = JSON.parse(req.responseText)

        for (var i = 0; i < objectArray.length; i++) {
            viewId.model.append({
                                    "contactName": objectArray[i].firstname
                                    + " " + objectArray[i].lastname,
                                    "contactNumber": objectArray[i].mobile,
                                    "idOfContact": objectArray[i].id
                                })
            console.log(objectArray[i].firstname)
        }
    }
    req.send()
}


/**
  * Get contact by ID
  **/
function fetchContactById(id) {
    var req = new XMLHttpRequest()
    req.open("GET", URL + id, true)
    req.onload = function () {
        var objectArray = JSON.parse(req.responseText)
        console.log("with id: ", objectArray)
    }
    req.send()
}


/**
  * Create a new contact
  **/
function createContact(firstname, lastname, mobile, email) {
    var req = new XMLHttpRequest()
    req.open("POST", URL, true)
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    req.onload = function () {}
    req.send()
}


/**
  * Update a contact
  **/
function updateContact() {}


/**
  * Delete a contact
  **/
function deleteContact() {}
