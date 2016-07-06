<script type="text/javascript">

var gCurrency = '<%=request.getSession().getAttribute("currency") %>';
var queryParamCount = function(queryString) {
// takes a url / query string typically window.location.search
	var count = 0;
	if (queryString.length > 0) {
		tmp =  queryString.match(/&/g);
		if (tmp) {
			count = tmp.length + 1;
		} else {
			count = 1;
		}
	}
	return count;
};
var queryParamValue = function(queryString, key, value) {
// takes a url / query string typically window.location.search
	var patt = new RegExp(key + '=([^&]*)', 'i');
	var searchResult = patt.exec(queryString);
	if (typeof value === 'undefined' && value) {
		// get param
		var result = '';
		if (searchResult) {
			result = decodeURI(searchResult[1]);
		}  
		return result;
	} else {
		// set param
		if (searchResult) {
			// replace
			queryString = queryString.replace(patt, key + '=' + encodeURI(value));
		} else {
			// new
			var leadChar = '?';
			var loc = queryString.indexOf(leadChar);
			if (loc >= 0) {
				// not first param
				leadChar = '&';
			}
			queryString = queryString + leadChar + key + '=' + encodeURI(value);
		}
		return queryString;
	}
};

var totalCostUpdating = false;
var totalCostUpdate = function(totalElement) {
	if (totalElement) {
		if (totalCostUpdating === false) {
			totalCostUpdating = true;
			var lastHotelPrice = totalElement.getAttribute('lastHotelPrice');
			var update = false;

			if (typeof lastHotelPrice !== 'undefined' && lastHotelPrice) {
				if (lastHotelPrice !== totalElement.getAttribute('hotelPrice')) {
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
				var newPrice = (parseFloat(totalElement.getAttribute('hotelPrice')) + parseFloat(totalElement.getAttribute('flightPrice'))) * currRate;
				totalElement.textContent = currSymbol + newPrice.toFixed(2).toString();
				totalElement.setAttribute('lastHotelPrice', newPrice);
			}    	
			totalCostUpdating = false;
		}
	}
};
var currencyUpdate = function() {
	var currencySelector = document.getElementById('currencySelector');
	var currencySelectedIndex = currencySelector.selectedIndex;
	var currency = currencySelector.options[currencySelectedIndex];
	var elementsToCheck = document.getElementsByClassName('currency');
	var i;
	for (i=0; i < elementsToCheck.length; i++) {
		var elementLookingAt = elementsToCheck[i];
		if (!(elementLookingAt.id && elementLookingAt.id == 'totalCost')) {
			var currRate = parseFloat(currency.getAttribute('rate'));
			var currSymbol = currency.getAttribute('symbol');
			var newPrice = elementLookingAt.getAttribute('price') * currRate;
			elementLookingAt.textContent = currSymbol + newPrice.toFixed(2).toString();
		}
	}
	var totalElement = document.getElementById('totalCost');
	if (typeof totalElement !== 'undefined' && totalElement) {
		totalCostUpdate(totalElement);
	}
};
document.addEventListener( "DOMContentLoaded", function() {
	if (document.getElementById('currencySelector')) {
		document.getElementById('currencySelector').onchange = function() {
		
			var currencySelector = document.getElementById('currencySelector');
			var currencySelectedIndex = currencySelector.selectedIndex;
			var currCode = currencySelector.options[currencySelectedIndex].getAttribute('code');
			var newQueryParam = queryParamValue(window.location.search, 'currency', currCode);
			history.pushState({}, "", window.location.pathname + newQueryParam); // update URL

			gCurrency = currCode;
			
			var elementsToCheck = document.getElementsByClassName('usesCurrencyCode');
			var i;
			for (i=0; i < elementsToCheck.length; i++) { // update forward postings
				var elementLookingAt = elementsToCheck[i];
				var ref;
				if (elementLookingAt.nodeName == 'A') {
					ref = 'href';
					var val = elementLookingAt.getAttribute(ref);
					val = queryParamValue(val, 'currency', currCode);
					elementLookingAt.setAttribute(ref, val);
				} else if (elementLookingAt.nodeName == 'FORM') {
					var inputs = elementLookingAt.getElementsByTagName('INPUT');
					var j;
					for (j=0; j<inputs.length; j++) {
						var inputnode = inputs[j];
						if (inputnode.getAttribute('Name') == 'currency') {
							// remove node
							elementLookingAt.removeChild(inputnode);
							break;
						}
					}
					var inputelement = document.createElement("INPUT");
					inputelement.setAttribute("TYPE", "HIDDEN");
					inputelement.setAttribute("NAME", "currency");
					inputelement.setAttribute("VALUE", gCurrency);
					elementLookingAt.appendChild(inputelement);
				}
			}
			
			currencyUpdate();
		};
	}
	
	if (document.getElementById('totalCost')) {
		document.getElementById('totalCost').addEventListener ('DOMSubtreeModified', function() {
			totalCostUpdate(document.getElementById('totalCost'));
		}, false);
	}
	
	var currency = gCurrency; // queryParamValue(window.location.search, 'currency');
	if (typeof currency !== 'undefined' && currency) {
		var currencySelector = document.getElementById('currencySelector');
		var currencyOptions = currencySelector.getElementsByTagName('OPTION');
		var i;
		for (i=0; i<currencyOptions.length; i++) {
			var elementToLookat = currencyOptions[i];
			if (elementToLookat.getAttribute('code') == currency) {
				elementToLookat.setAttribute('selected', true);
				break;
			}
		}
	}
	var bookingForm = document.getElementById('bookingForm');
	if (bookingForm) {
		var inputs = bookingForm.getElementsByTagName('input');
		for (i=0; i<inputs.length; i++) {
			var inputnode = inputs[i];
			if (inputnode.hasAttribute('name') && inputnode.getAttribute('name') == 'selectedHotel') {
				if (inputnode.checked) {
					var totalElement = document.getElementById('totalCost');
					if (typeof totalElement !== 'undefined' && totalElement) {
						// ensure hotelPrice correct on load
						var hotelRate = 1;
						if (inputnode.hasAttribute('RATE')) {
							hotelRate = inputnode.getAttribute('RATE');
						}
						totalElement.setAttribute('hotelPrice', hotelRate);
					}
				}
			}
		}
	}
	currencyUpdate();
}, false );
</script>