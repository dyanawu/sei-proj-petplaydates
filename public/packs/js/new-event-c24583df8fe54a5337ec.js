/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/new-event.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/new-event.js":
/*!*******************************************!*\
  !*** ./app/javascript/packs/new-event.js ***!
  \*******************************************/
/*! no static exports found */
/***/ (function(module, exports) {

console.log("new event script!"); //URL base needs to change after deploy

var URLBase = "http://localhost:3000";
var apiURL = URLBase + "/api";

function findAddress() {
  //Prepare user input for append to query string at server side
  var inputLocation = document.getElementById("location-input");
  var location = inputLocation.value;
  var inputText = location.split(" ").join("%20");
  var url = apiURL + "?inputText=" + inputText; //Basic setup

  var requestOptions = {
    method: "GET",
    redirect: "follow"
  }; //fetch AJAX call

  fetch(url, requestOptions).then(function (response) {
    return response.json();
  }).then(function (json) {
    var addressArr = json.candidates;
    console.log(addressArr); //Alter location input depending on selected search result

    function replaceInput(event) {
      inputLocation.value = "";
      inputLocation.value = event.target.value;
    } //If there are search results


    if (addressArr.length > 0) {
      //Create select element
      var selectDiv = document.getElementById("location-select");
      selectDiv.textContent = "";
      var select = document.createElement("select");
      select.classList.add("custom-select");
      select.classList.add("form-control");
      var text = document.createElement("div");
      text.textContent = "Select Location";
      text.className = "form-label";
      selectDiv.appendChild(text);
      select.addEventListener("change", replaceInput); //Create first option element with value ""

      var option = document.createElement("option");
      option.value = "";
      option.textContent = addressArr.length + " Result(s) Found...";
      option.disabled = true;
      option.selected = true;
      select.appendChild(option); //Create subsequent option elements depending on search result(s)

      for (var i = 0; i < addressArr.length; i++) {
        option = document.createElement("option");
        option.value = addressArr[i].formatted_address;
        option.textContent = addressArr[i].formatted_address;
        select.appendChild(option);
      }

      selectDiv.appendChild(select); //If there are no search results, communicate to user
    } else {
      var message = "No matching locations found. Please try again.";

      var _selectDiv = document.getElementById("location-select");

      _selectDiv.textContent = "";
      var messageP = document.createElement("p");
      messageP.className = "text-danger";
      messageP.classList.add("error-msg");
      messageP.textContent = message;

      _selectDiv.appendChild(messageP);
    }
  })["catch"](function (error) {
    return console.log("error", error);
  });
} //Initialize search for location button


function initLocationButton() {
  var searchButton = document.getElementById("google-button");
  console.log(searchButton);
  searchButton.addEventListener("click", findAddress);
}

window.addEventListener("load", initLocationButton, false);

/***/ })

/******/ });
//# sourceMappingURL=new-event-c24583df8fe54a5337ec.js.map