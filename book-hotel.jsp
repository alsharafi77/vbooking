<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.booking.hotel.CardTypeDef"%>
<%@page import="com.vbooking.booking.hotel.Hotel"%>
<%@page import="com.vbooking.booking.hotel.Booking"%>
<%@page import="com.vbooking.booking.hotel.Person"%>
<%@page import="com.vbooking.booking.hotel.Payment"%>
<%@page import="com.vbooking.booking.hotel.CardTypeDef"%>
<%@page import="com.vbooking.booking.hotel.FindHotels"%>
<%@page import="com.vbooking.booking.web.AirportCodeMapper"%>
<%@page import="java.io.*" %>	
<%@page errorPage="error.jsp" %>
<%@ include file="inc-page-init.jsp" %>
<%

String passengerFirstNameParam  = request.getParameter("passengerfirstname");
String passengerMiddleNameParam = request.getParameter("passengermiddlename");
String passengerLastNameParam   = request.getParameter("passengerlastname");
String passengerGenderParam     = request.getParameter("passengergender");
String cardTypeParam        = request.getParameter("cardtype");
String securityCodeParam    = request.getParameter("securityCode");
String cardHoldersNameParam = request.getParameter("cardholdersname");
String cardNumberParam      = request.getParameter("cardnumber");
String addressLine1Param    = request.getParameter("addressline1");
String addressLine2Param    = request.getParameter("addressline2");
String postcodeParam        = request.getParameter("postcode");

if (passengerFirstNameParam == null) passengerFirstNameParam = "";
if (passengerMiddleNameParam == null) passengerMiddleNameParam = "";
if (passengerLastNameParam == null) passengerLastNameParam = "";
if (passengerGenderParam == null) passengerGenderParam = "";
if (cardTypeParam == null) cardTypeParam = "";
if (securityCodeParam == null) securityCodeParam = "";
if (cardHoldersNameParam == null) cardHoldersNameParam = "";
if (cardNumberParam == null) cardNumberParam = "";
if (addressLine1Param == null) addressLine1Param = "";
if (addressLine2Param == null) addressLine2Param = "";
if (postcodeParam == null) postcodeParam = "";

boolean bookIt = request.getParameter("bookIt") != null;  

String city = request.getParameter("city");
String from = request.getParameter("from");
String to = request.getParameter("to");
 
String _pageTitle = "Book Hotel";

if (bookIt) {
    //Do some validation
    String paramError = null;
	
    if (passengerFirstNameParam==null   || passengerFirstNameParam.equals("")) paramError = "Missing 'passengerfirstname' parameter";
    if (passengerMiddleNameParam==null) passengerMiddleNameParam="";
    if (passengerLastNameParam==null    || passengerLastNameParam.equals(""))  paramError = "Missing 'passengerlastname' parameter";
    if (passengerGenderParam==null      || passengerGenderParam.equals(""))    paramError = "Missing 'passengergender' parameter";

    if (cardTypeParam==null             || cardTypeParam.equals(""))           paramError = "Missing 'cardtype' parameter";
    if (securityCodeParam==null         || securityCodeParam.equals(""))       paramError = "Missing 'securityCode' parameter";
    if (cardHoldersNameParam==null      || cardHoldersNameParam.equals(""))    paramError = "Missing 'cardholdersname' parameter";
    if (cardNumberParam==null           || cardNumberParam.equals(""))         paramError = "Missing 'cardnumber' parameter";
    if (addressLine1Param==null         || addressLine1Param.equals(""))       paramError = "Missing 'addressline1' parameter";
    if (addressLine2Param==null) addressLine2Param="";                         
    if (postcodeParam==null             || postcodeParam.equals(""))           paramError = "Missing 'postcode' parameter";

    if (paramError!=null) {
        request.setAttribute("msg", paramError);
        RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
        dispatcher.forward(request, response);
        return;
    }


    List<Hotel> hotels = (List<Hotel>) session.getAttribute("hotels");
    String selectedHotel = request.getParameter("selectedHotel");
    Hotel hotelToBook = null;
    if (hotels != null) {
        for(Hotel hotel : hotels)
        {
            if (hotel.getName().equals(selectedHotel)) {
	            hotelToBook = hotel;
			    break;
	        }	
        }
    }

    if (hotelToBook != null) {    			
        Person person = new Person(passengerFirstNameParam,passengerGenderParam,passengerLastNameParam,passengerMiddleNameParam);
        CardTypeDef cardType = CardTypeDef.fromString(cardTypeParam);
        Payment payment = new Payment(addressLine1Param,addressLine2Param,cardNumberParam,cardType,cardHoldersNameParam,postcodeParam,securityCodeParam);
    	FindHotels finder = new FindHotels(hotelWSURL);		
		System.out.println("Booking hotel from " + from + " to " + to);
    	Booking hotelBookingResponse = finder.bookHotel(hotelToBook, from, to, person, payment);
    	System.out.println("HOTEL BOOKING: " + hotelBookingResponse.getMessage());
    	session.setAttribute("hotelBookingResponse", hotelBookingResponse);
		RequestDispatcher dispatcher = request.getRequestDispatcher("booking-made.jsp?hotelOnly=true");
		dispatcher.forward(request, response);
		return;
    }
}

%>

<link href="dropdown-style.css" rel="stylesheet" type="text/css" />
<div id="load_screen"><div id="loading" class = "loaded">
<TABLE class="block" >
	<TR>
		<TD valign = "top">
			<DIV class="new_header">
				<%@ include file="inc-header-noclick.jsp" %>
			</DIV> 			
		</TD>
	</TR>
	<TR>
		<TD align="center">
			<DIV style=" margin-left: auto; margin-right: auto;">
				<br><br><br>
				<h1  style= " margin-top: -120px; ">Searching for hotels...</h1>
			   	<br><br>
			   	<img src="graphics/new/gh_demo_compass.gif" style="height: 100px; width: 100px;">
			   	<br><br>	
				<h3 style= "font-size:1.6EM; "> <strong style="font-size: 2.5EM;"><%=city%> </strong><br> <strong ><%=from%> </strong> to<strong> <%=to%></strong></h3>
			</DIV>
		</TD>
	</tr>
</TABLE>
</div></div>

<script>
setTimeout(function(){var load_screen = document.getElementById("load_screen");
	document.body.removeChild(load_screen);}, 3000);
</script>
<div class="wrapper">
<script language="JavaScript" src="date.js"></script>
<FORM class='usesCurrencyCode' id="bookingForm" ACTION="book-hotel.jsp">
<table class="container">
	<TR>
 	<TD valign="bottom">
	<table class="block_searched" style="float: left; padding: 20px; margin-right: 5px; height: 500px;">
		<TR>
			<TD valign="top" style="height: 5px;">
				<DIV class="new_header" >
					<%@ include file="inc-header.jsp"%>
				</DIV>
				
			</TD>
		</TR>
		<TR> 
		<TD valign="top">
						<h3 style="margin-left: 20px;"><a href="<%=hotelWSwsdlURL%>/HotelFinder.wsdl">Find a hotel</a></h3>

    	<%
	
		    FindHotels finder = new FindHotels(hotelWSURL);    
			System.out.println("Finding hotels");
		    List<Hotel> hotels = null;
			String errorMsg = null;
		    try {
		        hotels = finder.findHotels(city, from, to);
			} catch (Exception e) {
				// default message
				errorMsg = "An error occurred processing hotel request. Probably a communication problem with the web service.";
				// Check for AxisFault BeanPropertyTarget (probably caused by missing requried attributes)
				if (e instanceof org.apache.axis.AxisFault) {
					org.apache.axis.AxisFault af = (org.apache.axis.AxisFault)e;
					if (null != af.detail) {
					    StackTraceElement ste[] = af.detail.getStackTrace();
					    String steClass = ste[0].getClassName();
					    if (steClass.equals("org.apache.axis.encoding.ser.BeanPropertyTarget")) {
					    	errorMsg = "The response did not match the format expected when searching for hotels. Each hotel should include a name and a valid rate.";
						} 
					} else {
						// was not for us re-throw
						String faultStr = af.getFaultString();
						if (null != faultStr)
							if (!faultStr.isEmpty()) {
								errorMsg = faultStr + ". The response did not match the format expected when searching for hotels.";
							} else {
								errorMsg = "The response did not match the format expected when searching for hotels.";
							}
					}
				}
				
			    throw new Exception(errorMsg, e);
			}
			if (hotels != null && hotels.size() > 0)
			{
				for(Hotel hotel : hotels)
		    	{
		    		if (hotel.getRate() <= 0)
		    		{
		    			errorMsg = "An error occurred processing hotel request. Rate is invalid.";
		    			break;
		    		}
		    		if (hotel.getName()==null || hotel.getName().equals(""))
		    		{
		    			errorMsg = "An error occurred processing hotel request. Hotel name is missing.";
		    			break;
		    		}
				}
			}
			session.setAttribute("hotels", hotels);    
		    %>
			<%
			    int i=0;				
				if (errorMsg != null) {
			%>
				   <b><%=errorMsg%></b>
				   <INPUT TYPE="hidden" NAME="selectedHotel" VALUE="none" checked>
			<%
				} else if (hotels == null || hotels.size() == 0) {
			%>
			<h1 style="margin-left: 20px;">No hotels available in <%=city%> </h1> <h3 style="margin-left: 20px;">from <%=from%> to <%=to%> </h3><br><br>
			<form class='usesCurrencyCode' action="book-hotel.jsp" name="bookingForm">
			<table>
				<tr><td > 
					<DIV CLASS="banner_book_flight" style="position: relative; margin-bottom: 10px;">
							<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
							<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
							<h4 style="font-weight: bold;text-align: center; margin-top: 3px;">HOTEL SEARCH</h4>			
					</DIV>
				</td></tr>
				<tr><td style="border:0px"><input class="DateText" style="margin-left: 20px; margin-right: 20px; width: 300px;" name="city" type="text" 
						value=" <%=city%>" placeholder=" City"  /></td></tr>
				<tr><td style="border:0px">
						<input class="DateText" style="margin-left: 20px;" value=" <%=from%>" placeholder=" From" maxlength="10" size="10" id="from" name="from" type="text">
							<div id="calendarFrom" class="calendar-wrapper" onmouseleave="javascript:hideCalendar('calendarFrom');">
								<img onmouseover="javascript:showCalendar('calendarFrom', document.getElementById('from').value, 'from');" src="graphics/new/gh_demo_calendar.png" class="calendar" border="0" STYLE="cursor: pointer;position: relative; top: 10px; left: -1px;"> 
								<div class="arrow-left"></div>
	       						<div class="calendar"  >
	       						</div>
							</div>
						<input class="DateText" style="margin-left: 5px;" value=" <%=to%>" placeholder=" To" maxlength="10" size="10" id="to" name="to" type="text">
							<div id="calendarTo" class="calendar-wrapper" onmouseleave="javascript:hideCalendar('calendarTo');">
								<img onmouseover="javascript:showCalendar('calendarTo', document.getElementById('to').value, 'to')"  src="graphics/new/gh_demo_calendar.png" class="calendar" border="0" STYLE="cursor: pointer;position: relative; top: 10px; left: -1px;"> 
								<div class="arrow-left"></div>
						        <div class="calendar" >
						        </div>
							</div>	
				</td></tr>
   				<tr><td>
  			 		<br><br>
  					 <input class="btn" type="submit" value="SEARCH" style="float:left; margin-left: 20px;"/>
  				 </td></tr>
			</table>
   			</form>
		<%		
			} else {
		%>
		
		<script language="JavaScript" src="updateScript.js"></script>		
		
			<input name="from" type="hidden" value="<%=from%>"/>
			<input name="to" type="hidden" value="<%=to%>"/>
			<input name="city" type="hidden" value="<%=city%>"/>
		<TABLE BORDER=0 CELLPADDING="2px" CELLSPACING=0 class="noTopBorder">
			<TR>
			<TD valign="top">
				<br>
				<h1 style="margin-left: 20px; white-space: nowrap;">Available hotels in <%=city%> </h1><h3 style="margin-left: 20px;">from <%=from%> to <%=to%></h3>
				<BR>	
				<DIV CLASS="banner_book_flight" style="position: relative;">
						<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
						<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
						<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">HOTEL DETAILS</h4>
				</DIV>
				<BR><BR>
				<table>
					<tr style="font-weight: bold">
						<td  style="margin-left: 20px;"></td>
						<td><h3> Hotel</h3></td>
						<td><h3 > Room rate</h3></td>
						<td></td>
					</tr>
		
			<%		
			    for(Hotel hotel : hotels)
			    {
			%>
				<tr>
					<td><INPUT TYPE="radio" NAME="selectedHotel" style="margin-left: 20px;" VALUE="<%=hotel.getName()%>" <% if (i==0) { %>checked<%}%> \></td>
					<td style="padding-right:20px"><%=hotel.getName()%></td>
					<td><div style='display: inline;' class='currency' price='<%=hotel.getRate() %>' ><%=hotel.getRate() %></div></td>
				</tr>
			<%      i++;
			    } 
			%>
				</table>
			<INPUT TYPE="hidden" name="bookIt" value="true"> 
		</TD></TR>
	</TABLE>
	</TABLE>
</TD>
<TD valign="bottom">

<table class="block_searched" style="float: left; padding: 20px; margin-left: 5px; margin-right:5px; " >
<!-- Customer table -->
		<TR>
			<TD valign="top">
				<DIV CLASS="banner_book_flight" style="position: relative; margin-top: 20px;">
					<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
					<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
					<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">PASSENGER</h4>
				</DIV>
				<BR><BR><BR><BR>
		<select id='passengerSelector' onchange="updatePassengerDetails()" class="booked_set" style="width: 150px; background-color: #003a8c; margin-left: 20px; margin-bottom: 5px;" >
		<%
			String pFirstName = "";
			String pMiddleName = "";
			String pLastName = "";
			String pGender = "";
			String pCardType = "";
			String pCardHolderName = "";
			String pCardNumber = "";
			String pCardSecurityCode = "";
			String pAddressLine1 = "";
			String pAddressLine2 = "";
			String pPostalCode = ""; %>
			<option pFirstName="<%=pFirstName%>" pMiddleName="<%=pMiddleName%>" pLastName="<%=pLastName%>" pGender="<%=pGender%>"
				pCardType="<%=pCardType%>" pCardHolderName="<%=pCardHolderName%>" pCardNumber="<%=pCardNumber%>" 
				pCardSecurityCode="<%=pCardSecurityCode%>" pAddressLine1="<%=pAddressLine1%>" pAddressLine2="<%=pAddressLine2%>" 
				pPostalCode="<%=pPostalCode%>" selected>Autofill Customer
		 	</option>
			<%
			try {
				String fileName = application.getRealPath("/autofillPassengers.csv");
      			FileReader fr = new FileReader(fileName);        
      			BufferedReader br = new BufferedReader(fr);

      			String line;
	   	 		while ((line = br.readLine()) != null) {
		        	String[] parts = line.split(",");
		        	pFirstName = parts[0];
					pMiddleName = parts[1];
					pLastName = parts[2];
					pGender = parts[3];
					pCardType = parts[4];
					pCardHolderName = parts[5];
					pCardNumber = parts[6];
					pCardSecurityCode = parts[7];
					pAddressLine1 = parts[8];
					pAddressLine2 = parts[9];
					pPostalCode = parts[10];
		      %>
		        <option pFirstName="<%=pFirstName%>" pMiddleName="<%=pMiddleName%>" pLastName="<%=pLastName%>" pGender="<%=pGender%>"
		        	pCardType="<%=pCardType%>" pCardHolderName="<%=pCardHolderName%>" pCardNumber="<%=pCardNumber%>" pCardSecurityCode="<%=pCardSecurityCode%>"
		        	pAddressLine1="<%=pAddressLine1%>" pAddressLine2="<%=pAddressLine2%>" pPostalCode="<%=pPostalCode%>"><%=pFirstName%></option>
		        <%
	   	 		}
			} catch (Exception e) {
				// Just log the error and show an empty list of auto-fill options,
				// allowing the user to manually fill in the details to book the flight or hotel
	    		e.printStackTrace();
			}
		%>
		</select>				
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengerfirstname"
				VALUE="<%=passengerFirstNameParam%>" placeholder=" First Name" size="20"\>
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengermiddlename"
				VALUE="<%=passengerMiddleNameParam%>" placeholder=" Middle Name" size="20"\>					
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengerlastname"
				VALUE="<%=passengerLastNameParam%>" placeholder=" Last Name" size="20"\>
			<SELECT class="booked_set" style="width: 150px; background-color: #003a8c; margin-top: 5px; margin-left: 20px;" NAME="passengergender">
				<OPTION VALUE="">gender</OPTION>
				<OPTION VALUE="M" <% if ("M".equals(passengerGenderParam)) { %>
						selected <% } %>>Male</OPTION>
				<OPTION VALUE="F" <% if ("F".equals(passengerGenderParam)) { %>
						selected <% } %>>Female</OPTION>
			</SELECT>
			<BR>
			</TD>
		</TR>
</table>
</TD>
<TD valign="bottom"> 
<table class="block_searched" style="float: left; padding: 20px; margin-left: 5px;">
<!-- Payment Details table -->
	<TR>
		<TD valign="top">
			<DIV CLASS="banner_book_flight" style="position: relative; margin-top: 20px;">
				<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
				<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
				<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">PAYMENT</h4>
			</DIV>
			<BR><BR><BR><BR>
			<SELECT class="booked_set" style="width: 150px; background-color: #003a8c; margin-left: 20px; margin-bottom: 5px;" NAME="cardtype">
				<OPTION VALUE="">Select Card Type</OPTION>
				<OPTION VALUE="multinational"
					<% if ("multinational".equals(cardTypeParam)) { %> selected <% } %>>Multinational</OPTION>
				<OPTION VALUE="global"
					<% if ("global".equals(cardTypeParam)) { %> selected <% } %>>Global</OPTION>
				<OPTION VALUE="worldwide"
					<% if ("worldwide".equals(cardTypeParam)) { %> selected <% } %>>Worldwide</OPTION>
			</SELECT>
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="cardholdersname"
				VALUE="<%=cardHoldersNameParam%>" placeholder=" Card Holder's Name" size="25"/>
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="cardnumber"
				VALUE="<%=cardNumberParam%>" placeholder=" Card Number" size="25"/>
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="securityCode"
				VALUE="<%=securityCodeParam%>" placeholder=" Security Code" size="25"/>					
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="addressline1"
				VALUE="<%=addressLine1Param%>" placeholder=" Billing Address 1" size="35"/>
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="addressline2"
				VALUE="<%=addressLine2Param%>" placeholder=" Billing Address 2" size="35"/>
			<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px; width: 80px;" TYPE="TEXT" placeholder=" Post Code" NAME="postcode"
				VALUE="<%=postcodeParam%>" size="10"/>	
			<br><br>
			<INPUT TYPE="SUBMIT" class="btn" style="margin-left: 20px;" VALUE="PROCEED" />
						
						
		<% } // End flightNumberParam block %>

		</TD>
	</TR>
</TABLE>
</TD>
</TR>
</table>
</FORM>

<div class="push"></div>
</div>

<div class="footer">
	<SPAN CLASS="smallprint" > 
	<%@ include file="inc-build-copyright.jsp"%>
	</SPAN>
	
</div>

<%@ include file="inc-footer.jsp"%>
<%@ include file="currency-change.jsp"%>