<!-- <!-- inc-create-trip-box.jsp--> 
<link href="dropdown-style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function changeDisplay(hc, fp, rd, d, r) {
document.getElementById('hotelCheckin').style.display=hc;
document.getElementById('flightPicker').style.display=fp;
document.getElementById('retDate').style.display=rd;
document.getElementById('dep').innerHTML = d;
document.getElementById('ret').innerHTML = r;
}
</script>
<%
	String fFrom = request.getParameter("flyingfrom");    
	String fTo = request.getParameter("flyingto"); 

%>

<DIV CLASS="hotelsearchbox">	
	<form name="tripBookingForm" method="get" action="book-flight.jsp" class='usesCurrencyCode' style="width:600px;">
		<input type="radio" id = "radio1" name="tripType" value="f" checked onclick="changeDisplay('none','inline','none','Travelling:','Returning:');"><label for="radio1">Flight</label>
		<input type="radio" id = "radio2" name="tripType" value="h" onclick="changeDisplay('inline','none','inline','Check-in:&nbsp;&nbsp;','Check-out:');"><label for="radio2">Hotel</label>
		<input type="radio" id = "radio3" name="tripType" value="fh" onclick="changeDisplay('none','inline','inline','Departing:','Returning:');"><label for="radio3">Flight + Hotel</label><br><br>
		
			
	<script language="JavaScript" src="date.js"></script>
		<%String searching ="t"; %>
		<span id="flightPicker">
		<br>
		<div style="margin-left:10px; font-size: 1em; color: #fffff">ONE-WAY</div>
	 	<br>
	<!-- 	<select name="flyingfrom" onchange="this.className=this.options[this.selectedIndex].className" class="default"> -->
		<select name="flyingfrom"  class="create_set" id="fromDropDown">
		<option  value="" >From Departing City</option>
		<option  value="AMS" <% if ("AMS".equals(fFrom)) {%>selected="true"<%} %> >Amsterdam (AMS)</option>
		<option  value="BLR" <% if ("BLR".equals(fFrom)) {%>selected="true"<%} %> >Bangalore (BLR)</option>
		<option  value="BCN" <% if ("BCN".equals(fFrom)) {%>selected="true"<%} %> >Barcelona (BCN)</option>
		<option  value="EDI" <% if ("EDI".equals(fFrom)) {%>selected="true"<%} %> >Edinburgh (EDI)</option>
		<option  value="STN" <% if ("STN".equals(fFrom)) {%>selected="true"<%} %> >London Stansted (STN)</option>
		</select>
		
	<!-- 	<select name="flyingto" onchange="this.className=this.options[this.selectedIndex].className" class="default"> -->
	<!-- 	<option class = "default" value="" >to destination</option> -->
	<%-- 	<option class = "set" value="AMS" <% if ("AMS".equals(fTo)) {%>selected="true"<%} %> >Amsterdam (AMS)</option> --%>
	<%-- 	<option class = "set" value="BLR" <% if ("BLR".equals(fTo)) {%>selected="true"<%} %> >Bangalore (BLR)</option> --%>
	<%-- 	<option class = "set" value="BCN" <% if ("BCN".equals(fTo)) {%>selected="true"<%} %> >Barcelona (BCN)</option> --%>
	<%-- 	<option class = "set" value="EDI" <% if ("EDI".equals(fTo)) {%>selected="true"<%} %> >Edinburgh (EDI)</option> --%>
	<!-- 	</select> -->
		
		<select name="flyingto" class="create_set" id="toDropDown">
		<option  value="" >To Destination</option>
		<option  value="AMS" <% if ("AMS".equals(fTo)) {%>selected="true"<%} %> >Amsterdam (AMS)</option>
		<option  value="BLR" <% if ("BLR".equals(fTo)) {%>selected="true"<%} %> >Bangalore (BLR)</option>
		<option  value="BCN" <% if ("BCN".equals(fTo)) {%>selected="true"<%} %> >Barcelona (BCN)</option>
		<option value="EDI" <% if ("EDI".equals(fTo)) {%>selected="true"<%} %> >Edinburgh (EDI)</option>
		</select>
		<br><br>
		</span>
	
		<span id="hotelCheckin" style="display:none">
		<br>
<%-- 		<a href="<%=hotelWSwsdlURL%>/HotelFinder.wsdl"><span class="findHotelsName" style= "margin-left:10px;">Find a hotel</span></a> --%>
			<h3 style="margin-left: 10px;"><a href="<%=hotelWSwsdlURL%>/HotelFinder.wsdl">Find a hotel</a></h3>
		<br>
	      <input class="DateText" style="margin-left: 10px; width: 300px;" name="city" type="text" value="<%=city%>" placeholder=" City"  /><br><br>
	    </span>
		
		
		<input style="margin-left: 10px;" class="DateText" value="<%=from%>" placeholder=" From" maxlength="10" size="10" id="from" name="from" type="text" class="DateText">
		<div id="calendarFrom" class="calendar-wrapper" onmouseleave="javascript:hideCalendar('calendarFrom');">
			<img onmouseover="javascript:showCalendar('calendarFrom', document.getElementById('from').value, 'from');" src="graphics/new/gh_demo_calendar.png" class="calendar" border="0" STYLE="cursor: pointer;position: relative; top: 10px; left: -1px;"> 
			<div class="arrow-left"></div>
	        <div class="calendar"  >
	        </div>
		</div>
		
		
		
		<div id="retDate"  style="display: none">
			<input class="DateText" style="margin-left: 10px;" value="<%=to%>" placeholder=" To" maxlength="10" size="10" id="to" name="to" type="text">
			<div id="calendarTo" class="calendar-wrapper" onmouseleave="javascript:hideCalendar('calendarTo');">
				<img onmouseover="javascript:showCalendar('calendarTo', document.getElementById('to').value, 'to')"  src="graphics/new/gh_demo_calendar.png" class="calendar" border="0" STYLE="cursor: pointer;position: relative; top: 10px; left: -1px;"> 
				<div class="arrow-left"></div>
		        <div class="calendar" >
		        </div>
			</div>	
		
		</div>
	<br><br>
	   <input class="btn" type="submit" value="SEARCH" style="float:left; margin-left: 10px;"/>
	   
	   </form>
	   
		<BR>
		<BR>
</DIV>