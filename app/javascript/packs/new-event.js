console.log("new event script!");

//URL base needs to change after deploy
let URLBase = "http://localhost:3000";
let apiURL = URLBase + "/api";

function findAddress() {
  //Prepare user input for append to query string at server side
  let inputLocation = document.getElementById("location-input");
  let location = inputLocation.value;
  let inputText = location.split(" ").join("%20");
  let url = apiURL + "?inputText=" + inputText;

  //Basic setup
  var requestOptions = {
    method: "GET",
    redirect: "follow",
  };

  //fetch AJAX call
  fetch(url, requestOptions)
    .then(response => response.json())
    .then((json) => {
      let addressArr = json.candidates;
      console.log(addressArr);

      //Alter location input depending on selected search result
      function replaceInput(event) {
        inputLocation.value = "";
        inputLocation.value = event.target.value;
      }

      //If there are search results
      if (addressArr.length > 0) {
        //Create select element
        let selectDiv = document.getElementById("location-select");
        selectDiv.textContent = "";
        let select = document.createElement("select");
        select.className = "custom-select";
        let text = document.createElement("div");
        text.textContent = "Select Location:";
        selectDiv.appendChild(text);
        select.addEventListener("change", replaceInput);

        //Create first option element with value ""
        let option = document.createElement("option");
        option.value = "";
        option.textContent = addressArr.length + " Result(s) Found...";
        option.disabled = true;
        option.selected = true;
        select.appendChild(option);

        //Create subsequent option elements depending on search result(s)
        for (let i=0; i<addressArr.length; i++) {
          option = document.createElement("option");
          option.value = addressArr[i].formatted_address;
          option.textContent = addressArr[i].formatted_address;
          select.appendChild(option);
        }
        selectDiv.appendChild(select);
        //If there are no search results, communicate to user
      } else {
        let message = "No matching locations found. Please try again."
        let selectDiv = document.getElementById("location-select");
        selectDiv.textContent = "";
        let messageP = document.createElement("p");
        messageP.className = "text-danger";
        messageP.textContent = message;
        selectDiv.appendChild(messageP);
      }
     
    })
    .catch((error) => console.log("error", error));
}

//Initialize search for location button
function initLocationButton() {
  let searchButton = document.getElementById("google-button");
  console.log(searchButton);
  searchButton.addEventListener("click", findAddress);
}

window.addEventListener("load", initLocationButton, false);
