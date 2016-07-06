<!-- inc-hotel-search-box.jsp-->
<%
String al = "right";
if (home) {
	al = "left";
}
%>
<link href="dropdown-style.css" rel="stylesheet" type="text/css" />
<DIV CLASS="hotelsearchbox" STYLE="float:<%=al%>;white-space: nowrap;">
	<h3 style="margin-left: 20px;"><a href="<%=hotelWSwsdlURL%>/HotelFinder.wsdl">Find a hotel</a></h3>
	<form name="hotelBookingForm" action="book-hotel.jsp">
	 	<input class="DateText" style="margin-left: 8px; width: 250px; border: 1px solid #003a8c;" name="city" type="text" value="<%=city%>" placeholder=" city"  />
		<br><script language="JavaScript" src="date.js"></script>
		
		
		<input style="margin-left: 8px; border: 1px solid #003a8c" class="DateText" value="<%=from%>" placeholder=" Check in" maxlength="10" size="10" id="from" name="from" type="text" class="DateText">
		<div id="calendarFrom" class="calendar-wrapper" onmouseleave="javascript:hideCalendar('calendarFrom');">
			<img onmouseover="javascript:showCalendar('calendarFrom', document.getElementById('from').value, 'from');" src="graphics/new/gh_demo_calendar.png" class="calendar" border="0" STYLE="cursor: pointer;position: relative; top: 10px; left: -1px;"> 
			<div class="arrow-left"></div>
	        <div class="calendar"  >
	        </div>
		</div>
	
		
		<input class="DateText" style="margin-left: 0; border: 1px solid #003a8c" value="<%=to%>" placeholder=" Check out" maxlength="10" size="10" id="to" name="to" type="text">
		<div id="calendarTo" class="calendar-wrapper" onmouseleave="javascript:hideCalendar('calendarTo');">
				<img onmouseover="javascript:showCalendar('calendarTo', document.getElementById('to').value, 'to')"  src="graphics/new/gh_demo_calendar.png" class="calendar" border="0" STYLE="cursor: pointer;position: relative; top: 10px; left: -1px;"> 
				<div class="arrow-left"></div>
		        <div class="calendar" >
		        </div>
		</div>	
		<br><br>
	
		<input class="btn" type="submit" value="SEARCH" style="float:left; margin-left: 20px; margin-bottom: 20px;"/>
  	 </form>

	<BR><BR>
</DIV>