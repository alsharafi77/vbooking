var flightCostUpdating = false;
var flightCostUpdate = function(costElement) {
	if (costElement) {
		if (flightCostUpdating === false) {
			flightCostUpdating = true;
			var lastFlightPrice = costElement.getAttribute('lastFlightPrice');
			var update = false;

			if (typeof lastFlightPrice !== 'undefined' && lastFlightPrice) {
				if (lastFlightPrice !== costElement.getAttribute('price')) {
					update=true;
				}
			} else { 
				update=true;
			}
			if (update === true) {
				var currencySelector = document.getElementById('currencySelector');
				var currencySelectedIndex = currencySelector.selectedIndex;
				var currency = currencySelector.options[currencySelectedIndex];
				var currRate = parseFloat(currency.getAttribute('rate'));
				var currSymbol = currency.getAttribute('symbol');
				var newPrice = parseFloat(costElement.getAttribute('price')) * currRate;
				costElement.textContent = currSymbol + newPrice.toFixed(2).toString();
				costElement.setAttribute('lastFlightPrice', newPrice);
			}    	
			flightCostUpdating = false;
		}
	}
};

function updateFlightInfo(){
	var fSelector = document.getElementById('flightSelector');
	var fSelectedIndex = fSelector.selectedIndex;
	var selectedFlight = fSelector.options[fSelectedIndex];
	
	var flightNumber = selectedFlight.getAttribute('flightNumber');
   	var weekNumber = selectedFlight.getAttribute('weekNumber');
   	var departs = selectedFlight.getAttribute('departs');
   	var arrives = selectedFlight.getAttribute('arrives');
   	var newPrice = selectedFlight.getAttribute('fprice');
   
	var flightElement = document.getElementById("flightNumberUI");
	flightElement.innerHTML = flightNumber + "-" + weekNumber;
	document.getElementById("flightNumber").setAttribute("value", flightNumber);
	document.getElementById("weekNumber").setAttribute("value", weekNumber);
	
	var departsElement = document.getElementById("departsParamUI");
	departsElement.innerHTML = departs;
	document.getElementById("departsFrom").setAttribute("value", departs);
	
	var arrivesElement = document.getElementById("arrivesParamUI");
	arrivesElement.innerHTML = arrives;
	document.getElementById("arrivesTo").setAttribute("value", arrives);
	
	document.getElementById("flightPrice").setAttribute("value", newPrice);
	var fCostElement = document.getElementById("flightCost");
	fCostElement.setAttribute("price", newPrice);
	if (document.getElementById("totalCost")) {
		document.getElementById("totalCost").setAttribute("flightPrice", newPrice);
	}
	flightCostUpdate(document.getElementById('flightCost'));
}

function updatePassengerDetails(){
	var fSelector = document.getElementById('passengerSelector');
	var fSelectedIndex = fSelector.selectedIndex;
	var selectedPassenger = fSelector.options[fSelectedIndex];
	
	var pFirstName = selectedPassenger.getAttribute('pFirstName');
	var pMiddleName = selectedPassenger.getAttribute('pMiddleName');
	var pLastName = selectedPassenger.getAttribute('pLastName');
	var pGender = selectedPassenger.getAttribute('pGender');
	var pCardType = selectedPassenger.getAttribute('pCardType');
	var pCardHolderName = selectedPassenger.getAttribute('pCardHolderName');
	var pCardNumber = selectedPassenger.getAttribute('pCardNumber');
	var pCardSecurityCode = selectedPassenger.getAttribute('pCardSecurityCode');
	var pAddressLine1 = selectedPassenger.getAttribute('pAddressLine1');
	var pAddressLine2 = selectedPassenger.getAttribute('pAddressLine2');
	var pPostalCode = selectedPassenger.getAttribute('pPostalCode');
	var pFF = selectedPassenger.getAttribute('pFF'); //Only available when frequent flyer page is loaded
	
	document.forms["bookingForm"]["passengerfirstname"].value = pFirstName;
	document.forms["bookingForm"]["passengermiddlename"].value = pMiddleName;
	document.forms["bookingForm"]["passengerlastname"].value = pLastName;
	
	if(pGender === "M") {
		document.forms["bookingForm"]["passengergender"].options.selectedIndex = 1;
	} else if(pGender === "F") {
		document.forms["bookingForm"]["passengergender"].options.selectedIndex = 2;
	} else {
		document.forms["bookingForm"]["passengergender"].options.selectedIndex = 0;
	}
	
	if(pCardType === "multinational") {
		document.forms["bookingForm"]["cardtype"].options.selectedIndex = 1;
	} else if(pCardType === "global") {
		document.forms["bookingForm"]["cardtype"].options.selectedIndex = 2;
	} else {
		document.forms["bookingForm"]["cardtype"].options.selectedIndex = 3;
	}
	if (pFF != null && document.forms["bookingForm"]["frequentflyer"]) {
		document.forms["bookingForm"]["frequentflyer"].value = pFF;
	}
	document.forms["bookingForm"]["cardholdersname"].value = pCardHolderName;
	document.forms["bookingForm"]["cardnumber"].value = pCardNumber;
	document.forms["bookingForm"]["securityCode"].value = pCardSecurityCode;
	document.forms["bookingForm"]["addressline1"].value = pAddressLine1;
	document.forms["bookingForm"]["addressline2"].value = pAddressLine2;
	document.forms["bookingForm"]["postcode"].value = pPostalCode;
}