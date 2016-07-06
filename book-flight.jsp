<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.booking.hotel.Hotel"%>
<%@page import="com.vbooking.booking.hotel.FindHotels"%>
<%@page import="com.vbooking.booking.web.AirportCodeMapper"%>
<%@page import="com.vbooking.flights.Flight"%>
<%@page import="com.vbooking.flights.FlightsRest"%>
<%@page import="java.io.*" %>
<%@page errorPage="error.jsp" %>
<%@ include file="inc-page-init.jsp" %>
<% String _pageTitle = "Book Flight"; %>



<%
if ("h".equals(request.getParameter("tripType"))) {
    RequestDispatcher dispatcher = request.getRequestDispatcher("book-hotel.jsp");
	dispatcher.forward(request, response);
	return;
}
boolean specialOffer = request.getParameter("specialOffer") != null;   

String flightNumberParam= request.getParameter("flightnumber");     
String weekNumberParam  = request.getParameter("weeknumber");    
String flyingFromParam  = request.getParameter("flyingfrom");    
String flyingToParam    = request.getParameter("flyingto");    
String departsParam     = request.getParameter("departs");  //(format: 10/12/2006 05:20)
String arrivesParam     = request.getParameter("arrives");    
String priceParam       = request.getParameter("price");    //integer number of pounds

int numberOfFlights = 1; // Default set as 1

String hotelFromParam  = request.getParameter("hotelFrom");
String hotelToParam  = request.getParameter("hotelTo");
String from = request.getParameter("from");
String to = request.getParameter("to");
if (hotelFromParam != null) {
	from = hotelFromParam; 
}
if (hotelToParam != null) {
	to = hotelToParam;
}

if (from == null) {
	from = "";
}
if (to == null) {
	to = "";
}

ServletContext servletConfig = getServletContext();	
String url = servletConfig.getInitParameter("flightWSURL");
List<Flight> flights = null;

if (flightNumberParam == null) {
	try {
		flights = new FlightsRest(url).getFlightsByCriteria(flyingFromParam, flyingToParam, from);
	}  catch (Exception e) {
	    throw new Exception("An error occurred contacting the flights service. Please check the status of the flights application in WebSphere Application Server.", e);
	}
	Flight flight = null;
	if(flights.size()>0){
	   numberOfFlights = flights.size();
	   flight = flights.get(0);
	}
	if (flight != null) {
	    flightNumberParam = flight.getFlightNumber();
	    weekNumberParam = "" + flight.getWeekNumber();
	    departsParam = from + " " + flight.departsTimeAsString();
	    arrivesParam = from + " " + flight.arrivesTimeAsString();
	    priceParam = "" + flight.getPrice();
	}
}


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

boolean flightOnly = "f".equals(request.getParameter("tripType"));  
boolean getHotels = "h".equals(request.getParameter("tripType")) || "fh".equals(request.getParameter("tripType"));

String city = new AirportCodeMapper().getCityName(flyingToParam);
%>
<!--  SEARCHING  SCREEN IS SHOWN HERE AS A DIV -->
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
		<% if ("fh".equals(request.getParameter("tripType"))){ %>
			<h1  style= " margin-top: -120px; ">Searching for a flight and hotel...</h1>
		<% }else{ %>
			<h1  style= " margin-top: -120px; ">Searching for flights...</h1>
		<%} %>
	   	<br><br>
	   	<img src="graphics/new/gh_demo_compass.gif" LOOP=infinite style="height: 100px; width: 100px;" >
	   	<br><br>	
		<h3 style= "font-size:1.6EM; "> <strong style="font-size: 2.5EM;"><%=flyingFromParam%> </strong>to <strong style="font-size: 2.5EM;"><%=flyingToParam%> </strong> on <strong ><%=from%></strong></h3>
	</DIV>
	</TD>	
	</tr>
</TABLE>
</div></div>
<!-- SCRIPT TO KILL THE SEARCHING SCREEN AFTER 3 SECONDS, TIME CAN BE ADJUSTED -->
<script>
setTimeout(function(){var load_screen = document.getElementById("load_screen");
	document.body.removeChild(load_screen);}, 3000);
</script>

<div class="wrapper">
<script language="JavaScript" src="date-picker.js"></script>
<% if (flightNumberParam != null) { %>
<FORM id="bookingForm" name="bookingForm" ACTION="book-flight-control.jsp" class='usesCurrencyCode'>
<%} %>
<table class="container">
	<TR>
	<%if(flightOnly){ %>
		<TD valign="bottom"><%
	} else {%>
		<TD valign="middle"><%
	}%>
	<table class="block_searched" style="float: left; padding: 20px; margin-right: 5px; height: 600px;">
	<TR>
		<TD valign="top" style="height: 0px;">
			<DIV class="new_header" >
				<%@ include file="inc-header.jsp"%>
			</DIV>
		</TD>
	</TR>
	<TR>
		<TD valign="top" >
			<% if (flightNumberParam == null) {%> 
				<br> 
				<b style="margin-left: 20px;">No flights found from <%=flyingFromParam%> to <%=flyingToParam%> on <%=from%></b> <br> <br> 
				<%@ include	file="inc-create-trip-box.jsp"%> 
			<% } else { %> 
				<% if (!specialOffer) { %> 
					<h1 style="margin-left: 20px;"><b>Search results:</b></h1>
					<h3 style="margin-left: 20px;"><%=numberOfFlights%> flight(s) found</h3>
				<% } %> 
			<script language="JavaScript" src="updateScript.js"></script>

			
					<% if((flights != null) && (flights.size() > 1)) { %>				
						<BR> 
					<select id='flightSelector' onchange="updateFlightInfo()" class="booked_set" style="width: 120px; background-color: #003a8c; margin-left: 20px; margin-bottom: 5px;">
					<%
						Flight flightInfo = null;
						String fNumber = "";
						String fwNumber = "";
						String fDeparts = "";
						String fArrives = "";
						String fPrice = "";
						for (int i = 0; i < flights.size(); i++) {
							flightInfo = flights.get(i);
							if (flightInfo != null) {
							    fNumber = flightInfo.getFlightNumber();
							    fwNumber = "" + flightInfo.getWeekNumber();
							    fDeparts = from + " " + flightInfo.departsTimeAsString();
							    fArrives = from + " " + flightInfo.arrivesTimeAsString();
							    fPrice = "" + flightInfo.getPrice();
							}
					%>
						<option flightNumber="<%=fNumber%>" weekNumber="<%=fwNumber%>" departs="<%=fDeparts%>" arrives="<%=fArrives%>" 
							fprice="<%=fPrice%>" <% if (i == 0) {%> selected <%} %>><%=fNumber%>-<%=fwNumber%></option>
					<% } %>
					</select>

					<% } %>
					<br><br>
						<DIV CLASS="banner_book_flight" style="position: relative;">
							<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
							<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
							<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">FLIGHT DETAILS</h4>
						</DIV>
						<BR><BR><BR>	
						<div>
							<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">FLIGHT</h3> 
							<p id="flightNumberUI" style="font-weight: bold; float: right; margin-right: 20px;" ><%=flightNumberParam%></p>
<%-- 							<p id="flightNumberUI" style="font-weight: bold; float: right; margin-right: 20px;" ><%=flightNumberParam%>-<%=weekNumberParam%></p> --%>
						</div>
						
					<INPUT TYPE="HIDDEN" id="flightNumber" NAME="flightnumber" VALUE="<%=flightNumberParam%>" size="8" />
					<INPUT TYPE="HIDDEN" id="weekNumber" NAME="weeknumber" VALUE="<%=weekNumberParam%>" size="8" />
					<INPUT name="from" type="hidden" value="<%=from%>" />
					<INPUT name="to" type="hidden" value="<%=to%>" />
					<INPUT name="city" type="hidden" value="<%=city%>" />
					<br><br>
						<div>
							<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">FROM</h3>
							<p id="flyingFromParamUI" style="font-weight: bold; float: right; margin-right: 20px;"><%=flyingFromParam%></p>
						</div>	
					<INPUT TYPE="HIDDEN" id="flyingFrom" NAME="flyingfrom" VALUE="<%=flyingFromParam%>" size="8" />
					<br><br>
						<div>
							<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">DEPARTING</h3>
							<p id="departsParamUI" style="font-weight: bold; float: right; margin-right: 20px;"><%=departsParam%></p>
						</div>
					<INPUT TYPE="HIDDEN" id="departsFrom" NAME="departs" VALUE="<%=departsParam%>" size="8" />
					<br><br>
						<div>
							<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">TO</h3>
							<p id="flyingToParamUI" style="font-weight: bold; float: right; margin-right: 20px;"><%=flyingToParam%></p>
						</div>				
					<INPUT TYPE="HIDDEN" id="flyingTo" NAME="flyingto" VALUE="<%=flyingToParam%>" size="8" />
					<br><br>
						<div>
							<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">ARRIVING</h3>
							<p id="arrivesParamUI" style="font-weight: bold; float: right; margin-right: 20px;"><%=arrivesParam%></p>
						</div>						
					<INPUT TYPE="HIDDEN" id="arrivesTo" NAME="arrives" VALUE="<%=arrivesParam%>" size="8" />
					<br><br>
						<div>
						<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">COST</h3>
						<B><FONT SIZE=+1>
							<div id="flightCost" style='display: inline; float: right; margin-right: 20px;' class='currency' price='<%=priceParam%>'><%=priceParam%></div>
						</FONT></B>
						</div>				
						
						<INPUT TYPE="HIDDEN" id="flightPrice" NAME="price" VALUE="<%=priceParam%>" size="3" />
						</TD>
					</TR>
					<tr>
						<td colspan=2>&nbsp;</td>
					</tr>

			<% if (!flightOnly) { %>
			<TR>
			<% if (getHotels) { %>
					<TD valign="top">
								<h3 style="margin-left: 20px;"><a href="<%=hotelWSwsdlURL%>/HotelFinder.wsdl">Find a hotel</a></h3>
 						<br>
						<DIV CLASS="banner_book_flight" style="position: relative;">
								<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
								<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
								<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">HOTEL DETAILS</h4>
						</DIV>
							
			<% } else { %>
									<h3 style="margin-left: 20px;"><a href="<%=hotelWSwsdlURL%>/HotelFinder.wsdl">Find a hotel</a></h3>
						
						<br><br>Amazing hotel rates<br>for <%=city%>!<br>
			<% } %>
				<INPUT TYPE="hidden" name="addHotel" value="true">
			<%
				boolean hotelsFound = false;
				if (getHotels) { 
				    FindHotels finder = new FindHotels(hotelWSURL);
					List<Hotel> hotels = null;
					String errorMsg = null;
				    try {   
				        hotels = finder.findHotels(city, from, to);	
					} catch (Exception e) {
						e.printStackTrace();
					    errorMsg = "An error occurred processing hotel request.";
					}
					session.setAttribute("hotels", hotels);    
				    
					if (errorMsg != null) {
				%> 
					<b><%=errorMsg%></b> <INPUT TYPE="hidden" NAME="selectedHotel" VALUE="none" checked> 
				<% } else if (hotels == null || hotels.size() == 0) {%> 
					<br><br><h1 style="margin-left: 20px;">No hotels available in <%=city%> </h1> <h3 style="margin-left: 20px;">from <%=from%> to <%=to%> </h3> 
					<INPUT TYPE="hidden" NAME="selectedHotel" VALUE="none" checked>
				<%
					} else {
						hotelsFound = true;
				%>
				 <br><br><h1 style="margin-left: 20px; white-space: nowrap;">Available hotels in <%=city%> </h1><h3 style="margin-left: 20px;">from <%=from%> to <%=to%></h3>
				 <br> <INPUT TYPE="radio" NAME="selectedHotel" VALUE="none" style="margin-left: 20px;" RATE="0" checked onclick="document.getElementById('totalCost').setAttribute('hotelPrice', '0');"\> No hotel required<br>
				 <br>
				<table>
					<input name="hotelFrom" type="hidden" value="<%=from%>" />
					<input name="hotelTo" type="hidden" value="<%=to%>" />
						<tr style="font-weight: bold">
							<td  style="margin-left: 20px;"></td>
							<td><h3> Hotel</h3></td>
							<td><h3 > Room rate</h3></td>
							<td></td>
						</tr>
				<% for(Hotel hotel : hotels){ %>
						<tr>
						<td><INPUT TYPE="radio" NAME="selectedHotel" VALUE="<%=hotel.getName()%>" style="margin-left: 20px;" RATE='<%=hotel.getRate() %>'
										onclick="document.getElementById('totalCost').setAttribute('hotelPrice', '<%=hotel.getRate() %>');"\></td>
						<td><%=hotel.getName()%></td>
						<td class='currency' price='<%=hotel.getRate() %>'><%=hotel.getRate() %></td>
						</tr>
								
				<% } %>
								
				</table> <br> 
				<font size=-2 style="margin-left: 20px;">* Hotel billed separately</font> 
				<% }
				} else { %> 
				<h1 style="margin-left: 20px;"> Find a hotel: </h1><br>
				<table style = "margin-left: 20px;">
					<tr>
					<td style="border: 0px;">From</td>
					<td style="border: 0px"><input value="<%=from%>"
										maxlength="10" size="10" id="hotelFrom" name="hotelFrom"
										type="text"> <a
										href="javascript:show_calendar('bookingForm.hotelFrom', document.getElementById('hotelFrom').value);"
										onmouseover="window.status='Date Picker';return true;"
										onmouseout="window.status='';return true;"> <img
											src="graphics/new/gh_demo_calendar.png" class="calendar" border="0"
											STYLE="position: relative; top: 10px; left: -1px;"></a></td>
					</tr>
					<tr>
						<td style="border: 0px;">To</td>
						<td style="border: 0px"><input value="<%=to%>"
										maxlength="10" size="10" id="hotelTo" name="hotelTo"
										type="text"> <a
										href="javascript:show_calendar('bookingForm.hotelTo', document.getElementById('hotelTo').value);"
										onmouseover="window.status='Date Picker';return true;"
										onmouseout="window.status='';return true;"> <img
											src="graphics/new/gh_demo_calendar.png" class="calendar" border="0"
											STYLE="position: relative; top: 10px; left: -1px;"></a></td>
					</tr>
				</table> <br>
				<button	onclick="var f = document.getElementById('bookingForm'); f.action='book-flight.jsp'; f.submit(); ">Find hotels</button> 
				<% } %>
				</td>
				</TD>
				</TR>
				<% if (hotelsFound) {  %>
					<TR>
						<td>
						<div>
							<br>
							<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;"> TOTAL COST</h3>
							<B><FONT SIZE=+1>
								<div style='display: inline;float: right; margin-right: 20px;' id='totalCost' class='currency' hotelPrice='0' flightPrice='<%=priceParam%>'><%=priceParam%></div>
							</FONT></B>
						</div>	
						</td>				
					</TR>
					<% } %>
					<tr>
						<td colspan=2>&nbsp;</td>
					</tr>
					<% } // End flightOnly %>
			</table >
			</TD>
		<%if(flightOnly){ %>
				<TD valign="bottom"><%
			} else {%>
				<TD valign="middle"><%
		}%>
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
								
				<option pFirstName="<%=pFirstName%>"pMiddleName="<%=pMiddleName%>" pLastName="<%=pLastName%>"
									pGender="<%=pGender%>" pCardType="<%=pCardType%>"pCardHolderName="<%=pCardHolderName%>" pCardNumber="<%=pCardNumber%>"
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
								<option pFirstName="<%=pFirstName%>" pMiddleName="<%=pMiddleName%>" pLastName="<%=pLastName%>"
									pGender="<%=pGender%>" pCardType="<%=pCardType%>" pCardHolderName="<%=pCardHolderName%>" pCardNumber="<%=pCardNumber%>"
									pCardSecurityCode="<%=pCardSecurityCode%>" pAddressLine1="<%=pAddressLine1%>" pAddressLine2="<%=pAddressLine2%>"
									pPostalCode="<%=pPostalCode%>"><%=pFirstName%>
								</option>
					<%
	   	 			}
					} catch (Exception e) {
						// Just log the error and show an empty list of auto-fill options,
						// allowing the user to manually fill in the details to book the flight or hotel
			    		e.printStackTrace();
					}
					%>
						</select>
						
						<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengerfirstname" VALUE="<%=passengerFirstNameParam%>" placeholder=" First Name" size="20"\>					
						<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengermiddlename" VALUE="<%=passengerMiddleNameParam%>" placeholder=" Middle Name" size="20"\>				
						<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengerlastname"	VALUE="<%=passengerLastNameParam%>" placeholder=" Last Name" size="20"\>
						<SELECT class="booked_set" style="width: 150px; background-color: #003a8c; margin-top: 5px; margin-left: 20px;" NAME="passengergender">
								<OPTION VALUE="">Gender</OPTION>
								<OPTION VALUE="M" <% if ("M".equals(passengerGenderParam)) { %>
									selected <% } %>>Male</OPTION>
								<OPTION VALUE="F" <% if ("F".equals(passengerGenderParam)) { %>
									selected <% } %>>Female</OPTION>
						</SELECT>
						<BR></TD>
					</TR>
</table>
</TD>
<!-- <TD valign="bottom"> -->
<%if(flightOnly){ %>
		<TD valign="bottom"><%
	} else {%>
		<TD valign="middle"><%
	}%>
<table class="block_searched" style="float: left; padding: 20px; margin-left: 5px;">
<!-- Payment Details table -->
					<TR>

						<TD valign="top">
							<DIV CLASS="banner_book_flight" style="position: relative; margin-top: 20px;">
								<img src="graphics/new/gh_demo_banner_fold_blue.png"
								style="float: left; margin-left: -10px"> 
								<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
								<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">PAYMENT</h4>
						</DIV>
						<BR><BR><BR><BR>
				
						<SELECT class="booked_set" style="width: 150px; background-color: #003a8c; margin-left: 20px; margin-bottom: 5px;" NAME="cardtype">
								<OPTION VALUE="">Select Card Type</OPTION>
								<OPTION VALUE="multinational"
									<% if ("multinational".equals(cardTypeParam)) { %> selected
									<% } %>>Multinational</OPTION>
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
					<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px; width: 110px;" TYPE="TEXT" placeholder=" Post Code" NAME="postcode"
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
<% if (flightNumberParam != null) {%>
</FORM>
<%} %>

<div class="push"></div>
</div>

<div class="footer">
	<SPAN CLASS="smallprint" > 
	<%@ include file="inc-build-copyright.jsp"%>
	</SPAN>
	
</div>

<%@ include file="inc-footer.jsp"%>
<%@ include file="currency-change.jsp"%>
