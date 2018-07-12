let pickerApiLoaded = false;
// Use the Google API Loader script to load the google.picker script.
function loadPicker() {
    gapi.load('picker', {'callback': onPickerApiLoad});
}

function onPickerApiLoad() {
    pickerApiLoaded = true;
    $(document).ready(function (){
        $("#add").click(function(){
            createPicker()
        });
    });
}


// Create and render a Picker object for searching images.
function createPicker() {
    if (pickerApiLoaded) {
        let view =new google.picker.DocsUploadView();
       let picker = new google.picker.PickerBuilder()
            .setOAuthToken(gon.token)
            .addView(view.setParent(gon.material.toString()))
            .setDeveloperKey(gon.key)
            .setCallback(pickerCallback)
            .build();
        picker.setVisible(true);
    }
}

// A simple callback implementation.
function pickerCallback(data) {
    if (data.action == google.picker.Action.PICKED) {
    location.reload()
    }
}