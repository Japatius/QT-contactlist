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
                                    "id": objectArray[i].id
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

    //    var data = {
    //        "firstname": firstname
    //    }
    //    var formattedData = data

    //    req.onreadystatechange = function () {
    //        if (req.readyState === 4 && req.status === 201) {
    //            console.log("Contact created")
    //        } else {
    //            console.log("Something went wrong")
    //        }
    //    }
    req.send({
                 "firstname": firstname
             })
}


/**
  * Update a contact
  **/
function updateContact() {
    // TODO: Make it take an id from item
    var data = {}
    data.firstname = "Koksal"
    data.lastname = "Baba"
    data.mobile = "+90-12323"
    data.email = "koksal.baba@turkey.tr"
    var json = JSON.stringify(data)

    var xhr = new XMLHttpRequest()
    xhr.open("PUT", URL + '/48', true)
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
}


/**
  * Delete a contact
  **/
function deleteContact() {}
