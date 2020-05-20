console.log("new event script!");

let URLBase = "http://localhost:3000";
let apiURL = URLBase + "/api";

function findAddress() {
  let inputLocation = document.getElementById("location-input");
  let location = inputLocation.value;
  let inputText = location.split(" ").join("%20");
  let url = apiURL + "?inputText=" + inputText;

  var requestOptions = {
    method: "GET",
    redirect: "follow",
  };

  fetch(url, requestOptions)
    .then(response => response.json())
    .then((json) => {
      console.log(json);
      let addressArr = json.candidates;
      console.log(addressArr);

      function replaceInput(event) {
        inputLocation.value = "";
        inputLocation.value = event.target.value;
      }

      if (addressArr.length > 0) {
        let selectDiv = document.getElementById("location-select");
        selectDiv.textContent = "";
        let select = document.createElement("select");
        select.className = "custom-select";
        let text = document.createElement("div");
        text.textContent = "Select Location:";
        selectDiv.appendChild(text);
        select.addEventListener("change", replaceInput);

        let option = document.createElement("option");
        option.value = "";
        option.textContent = "";
        select.appendChild(option);

        for (let i=0; i<addressArr.length; i++) {
          option = document.createElement("option");
          option.value = addressArr[i].formatted_address;
          option.textContent = addressArr[i].formatted_address;
          select.appendChild(option);
        }
        selectDiv.appendChild(select);
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

function initLocationButton() {
  let searchButton = document.getElementById("google-button");
  console.log(searchButton);
  searchButton.addEventListener("click", findAddress);
}

window.addEventListener("load", initLocationButton, false);
