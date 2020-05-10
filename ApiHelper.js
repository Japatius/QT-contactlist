function func() {
    return console.log("Moro")
}


/**
  * Append data for contacts list
  **/
function fetchContacts(viewId) {
    var req = new XMLHttpRequest()
    req.open("GET", "https://qtphone.herokuapp.com/contact", true)
    req.onload = function () {
        var objectArray = JSON.parse(req.responseText)

        for (var i = 0; i < objectArray.length; i++) {
            viewId.model.append({
                                    "contactName": objectArray[i].firstname
                                    + " " + objectArray[i].lastname,
                                    "contactNumber": objectArray[i].mobile
                                })
            console.log(objectArray[i].firstname)
        }
    }
    req.send()
}
