
var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var leapYearDays = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
var yearDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];



function Calendar (year, month, selected, id, formId) {
	this.date = new Date(year, month, 1);
	this.selected = selected;
	this.elementId = id;
	this.formId = formId;
	
	this.switchToNextMonth = function() {
		if (this.date.getMonth() == 11)
			this.date = new Date(this.date.getFullYear() + 1, 0, 1);
		else 
			this.date = new Date(this.date.getFullYear(), this.date.getMonth() + 1, 1);
	};
	
	this.switchToPrevMonth = function() {
		if (this.date.getMonth() == 0)
			this.date = new Date(this.date.getFullYear() - 1, 11, 1);
		else 
			this.date = new Date(this.date.getFullYear(), this.date.getMonth() - 1, 1);
	};
	
	this.generateTableHTML = function() {
		var htmlCode = "<table>";
		
		var lastMonthDays = this.date.getDay();
		var lastDay = isLeapYear(this.date.getFullYear()) ? leapYearDays[(((this.date.getMonth()-1)%12)+12)%12] : yearDays[(((this.date.getMonth()-1)%12)+12)%12];
		lastDay -= lastMonthDays;
		var day = 1;
		
		htmlCode += "<tr>";
		for (i = 0; i < lastMonthDays; i++) {
			htmlCode += "<td style=\"background-color: #3361A3; color: #6789bb;\">" + ++lastDay + "</td>";
		}
		for (i = 0; i < 7 - lastMonthDays; i++) {
			var sel = selected[0] == day && selected[1] == this.date.getMonth() && selected[2] == this.date.getFullYear() ? "background-color: #ea5600; color: #ffffff;\"": "\"";
			htmlCode += "<td style=\"cursor: pointer;"+ sel +" onclick=\"javacript:clickDate(this, '" + this.elementId  + "')\">" + day++ + "</td>";
		}
		htmlCode += "</tr>";
		
		lastDay = isLeapYear(this.date.getFullYear()) ? leapYearDays[this.date.getMonth()] : yearDays[this.date.getMonth()];
		
		while (day <= lastDay) {
			htmlCode += "<tr>";
			var i = 0;
			while (day <= lastDay && i < 7) {
				var sel = selected[0] == day && selected[1] == this.date.getMonth() && selected[2] == this.date.getFullYear() ? "background-color: #ea5600; color: #ffffff;\"": "\"";
				htmlCode += "<td style=\"cursor: pointer;"+ sel +" onclick=\"javacript:clickDate(this, '" + this.elementId  + "')\">" + day++ + "</td>";
				i++;
			}
			htmlCode += "</tr>";
		}
		
		htmlCode += "</table>";
		
		return htmlCode;
		
	};
}

function clickDate(cell, id) {
	var cal = document.getElementById(id).calendar;
	
	cal.selected[0] = parseInt(cell.innerHTML);
	var textString = (cell.innerHTML.length == 1 ? '0' + cell.innerHTML: cell.innerHTML) + '/';
	
	cal.selected[1] = cal.date.getMonth();
	textString += (cal.date.getMonth() + 1 < 10 ? '0' + (cal.date.getMonth() + 1): (cal.date.getMonth() + 1)) + '/';
	
	cal.selected[2] = cal.date.getFullYear();
	textString += cal.date.getFullYear();
	
	document.getElementById(cal.formId).value = textString;
	
	var code = "<div>" 
		code += "<img class=\"left\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-left_white.png\" onclick=\"" + "javascript:prevMonth('" + id + "')\"  />";
		code += "<p>" + monthNames[cal.date.getMonth()] + ' ' + cal.date.getFullYear() + "</p>";
		code += "<img class=\"right\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-right_white.png\" onclick=\"" + "javascript:nextMonth('" + id + "')\"  />";
		code += "</div>";
		code += cal.generateTableHTML();
	
	document.getElementById(id).getElementsByTagName("div")[1].innerHTML = code
	
	
	
}
	
function properDateFormat(dateString) {
	var dateArray = dateString.split("/");
	if (dateArray.length != 3) return false;
	
	var year = parseInt(dateArray[2]);
	if ( !(/^\d+$/.test(dateArray[2])) || year <= 0) return false;
	
	var month = parseInt(dateArray[1]);
	if ( !(/^\d+$/.test(dateArray[1])) || month < 1 || month > 12) return false;
	
	var day = parseInt(dateArray[0]);
	if ( !(/^\d+$/.test(dateArray[0])) || day < 1) return false;
	
	if (isLeapYear(year) && day > leapYearDays[month-1] || !isLeapYear(year) && day > yearDays[month-1]) return false;
	
	return true;
	
	
}	

function isLeapYear(year) {
	return year%4 == 0 && year%100 != 0 || year%400 == 0;
	
}

function nextMonth(elementId) {
	calendarElement = document.getElementById(elementId);
	
	calendarElement.calendar.switchToNextMonth();
	
	var code = "<div>" 
		code += "<img class=\"left\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-left_white.png\" onclick=\"" + "javascript:prevMonth('" + elementId + "')\"  />";
		code += "<p>" + monthNames[calendarElement.calendar.date.getMonth()] + ' ' + calendarElement.calendar.date.getFullYear() + "</p>";
		code += "<img class=\"right\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-right_white.png\" onclick=\"" + "javascript:nextMonth('" + elementId + "')\"  />";
		code += "</div>";
		code += calendarElement.calendar.generateTableHTML();
	
	calendarElement.getElementsByTagName("div")[1].innerHTML = code;
}

function prevMonth(elementId) {
	calendarElement = document.getElementById(elementId);

	calendarElement.calendar.switchToPrevMonth();
	
	var code = "<div>" 
		code += "<img class=\"left\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-left_white.png\" onclick=\"" + "javascript:prevMonth('" + elementId + "')\"  />";
		code += "<p>" + monthNames[calendarElement.calendar.date.getMonth()] + ' ' + calendarElement.calendar.date.getFullYear() + "</p>";
		code += "<img class=\"right\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-right_white.png\" onclick=\"" + "javascript:nextMonth('" + elementId + "')\"  />";
		code += "</div>";
		code += calendarElement.calendar.generateTableHTML();
	
	calendarElement.getElementsByTagName("div")[1].innerHTML = code;
}

function showCalendar(elementId, startDate, formId) {
	
	calendarElement = document.getElementById(elementId);
	var selected;
	
	if (startDate == null || !properDateFormat(startDate)){
		var d = new Date();
		selected = [d.getDate(), d.getMonth(), d.getFullYear()];
	} else {
		var dateArr = startDate.split('/').map(Number);
		dateArr[1] -= 1;
		selected = dateArr;
	}
	
	
	var code = "<div>" 
	code += "<img class=\"left\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-left_white.png\" onclick=\"" + "javascript:prevMonth('" + elementId + "')\"  />";
	code += "<p>" + monthNames[selected[1]] + ' ' + selected[2] +"</p>";
	code += "<img class=\"right\" style=\"cursor: pointer;\" src=\"graphics/gh_demo_arrow-right_white.png\" onclick=\"" + "javascript:nextMonth('" + elementId + "')\"  />";
	code += "</div>";
	
	var cal = new Calendar(selected[2], selected[1], selected, elementId, formId);
	
	code += cal.generateTableHTML();
	
	calendarElement.getElementsByTagName("div")[1].innerHTML = code;
	
	calendarElement.calendar = cal;
	

	calendarElement.getElementsByTagName("div")[0].style.display = "inline-block";
	calendarElement.getElementsByTagName("div")[1].style.display = "inline-block";



}

function hideCalendar(elementId) {

	document.getElementById(elementId).getElementsByTagName("div")[0].style.display = "none";
	document.getElementById(elementId).getElementsByTagName("div")[1].style.display = "none";
	
}