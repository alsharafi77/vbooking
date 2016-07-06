<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.booking.hotel.Hotel"%>
<%@page import="com.vbooking.booking.hotel.FindHotels"%>
<%@page import="com.vbooking.booking.web.AirportCodeMapper"%>
<%@page import="com.vbooking.flights.Flight"%>
<%@page import="com.vbooking.flights.FlightsRest"%>
<%@page import="java.io.*"%>
<%@page errorPage="error.jsp" %>
<%
String _pageTitle = "Vacation Booking online flight booking"; 
String tripType = request.getParameter("tripType");
// string specialOffer = request.getParameter("specialOffer");
String flightnumber= request.getParameter("flightnumber");     
String weeknumber  = request.getParameter("weeknumber");    
String flyingfrom  = request.getParameter("flyingfrom");    
String flyingto    = request.getParameter("flyingto");    
String departs     = request.getParameter("departs");  //(format: 10/12/2006 05:20)
String arrives     = request.getParameter("arrives");    
String price       = request.getParameter("price");    //integer number of pounds


String city = request.getParameter("city");
String hotelFrom  = request.getParameter("hotelFrom");
String hotelTo  = request.getParameter("hotelTo");
String from = request.getParameter("from");
String to = request.getParameter("to");
boolean home = true;
%>
<%@ include file="inc-page-init.jsp" %>


<TABLE class="block" >
	<TR>
		<TD valign="top">
			<DIV class="new_header">
				<%@ include file="inc-header-no-currency.jsp" %>
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

<br>

<br><br><br>
<div class="FOOTER">
<SPAN CLASS="smallprint">
	<%@ include file="inc-build-copyright.jsp"  %>
</SPAN>
</div>


<%@ include file="inc-footer.jsp" %>
<%@ include file="currency-change.jsp" %>