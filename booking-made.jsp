<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.booking.hotel.FindHotels"%>
<%@page import="com.vbooking.booking.hotel.Booking"%>
<%@page import="com.vbooking.booking.web.AirportCodeMapper"%>
<%@page errorPage="error.jsp" %>
<%@ include file="inc-page-init.jsp" %>
<%
String _pageTitle = "Booking made";
boolean home = false;
boolean hotel_flight = false;
%>
<div class="wrapper">
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
	<%	
	String city = request.getParameter("city");
	String from = request.getParameter("from");
	String to = request.getParameter("to");
	if (to == null) {
		to = "";
	}
	if (from == null) {
		from = "";
	}
	if (city == null) {
		city = "";
	}
	
	String hotelOnly = request.getParameter("hotelOnly");
	Booking hotelBooking = (Booking) session.getAttribute("hotelBookingResponse"); 
	if (hotelOnly == null ) {
	   String reservationNumberParam=request.getParameter("reservationnumber");
	   if (reservationNumberParam==null) reservationNumberParam=(String)request.getAttribute("reservationNumber");
	   if (reservationNumberParam==null) {
	       request.setAttribute("msg", "Missing 'reservationnumber' parameter");
	       RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	       dispatcher.forward(request, response);
	   }           
	   if (hotelBooking == null){
	   %>
	   <script language="JavaScript" src="date-picker.js"></script>
		   <DIV style=" margin-left: auto; margin-right: auto;">
				<br><br><br>
				<h1  style= " margin-top: -120px; FONT-SIZE: 3EM;">Flight booked!</h1>
				<h3 style="font-size: 1.6em;"> You have successfully booked a flight.</h3>
			   	<br><br>
			   	<img src="graphics/new/gh_demo_flight.png" style="height: 100px; width: 100px;">
			   	<br><br>	
				<h3 style="font-size: 1.6em;">Your flight reservation number is: <BR><B><SPAN ID="FlightReservationNumber"><%=reservationNumberParam%></SPAN></B></h3>
			</DIV>
		</TD>
		<td>
			<DIV CLASS="hotelBook_box">
				<DIV CLASS="banner_manage_flight">
					<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -11px;"> 
					<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
					<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">BOOK HOTEL</h4>
				</DIV>
				<%@ include file="inc-hotel-search-box.jsp" %>		
			</DIV>
		</td> 
		
		<%
		}else if(hotelBooking != null){
			hotel_flight = true;
			String confTitle = "Hotel Booking Confirmation"; 
	    	boolean hotelConfirmed = hotelBooking.isConfirmed();
	     	if (!hotelConfirmed) {
	      		confTitle = "Hotel Booking Unconfirmed";
	     	}
	     	String hotelBookingMessage = hotelBooking.getMessage();
		 	if (hotelBookingMessage != null) {
				hotelBookingMessage = hotelBookingMessage.replace(". ", ".<br>");
			} else {
		    	hotelBookingMessage = "";
		 	}
		 %>
			
		<DIV style=" margin-left: auto; margin-right: auto;">	
			<h1  style= " margin-top: -50px; FONT-SIZE: 3EM;">Flight booked!</h1>
			<h3 style="font-size: 1.6em;"> You have successfully booked a flight.</h3>
			<h3 style="font-size: 1.6em;">Your flight reservation number is: <BR><B><SPAN ID="FlightReservationNumber"><%=reservationNumberParam%></SPAN></B></h3>
		   	<br>
		   	<img src="graphics/new/gh_demo_flighthotel.png" style="height: 100px; width: 100px;">
		   	<br>
		   	<h1  style= "  FONT-SIZE: 3.0EM;"><%=confTitle%></h1>
			<h3 style="font-size: 1.0em;"><%=hotelBookingMessage%></h3> 
		</DIV>
	   	
	   
		<%	
			session.removeAttribute("hotelBookingResponse");
		}
	   }
	
	
	// 	Booking hotelBooking = (Booking) session.getAttribute("hotelBookingResponse");
	  if (hotelBooking != null && hotel_flight == false) {
	     String confTitle = "Hotel Booking Confirmation"; 
	     boolean hotelConfirmed = hotelBooking.isConfirmed();
	     if (!hotelConfirmed) {
	         confTitle = "Hotel Booking Unconfirmed";
	     }
	     String hotelBookingMessage = hotelBooking.getMessage();
		 if (hotelBookingMessage != null) {
			hotelBookingMessage = hotelBookingMessage.replace(". ", ".<br>");
		 } else {
		    hotelBookingMessage = "";
		 }
	%>
	<DIV style=" margin-left: auto; margin-right: auto;">
		<br><br><br>		
		<h1  style= " margin-top: -120px; FONT-SIZE: 3EM;"><%=confTitle%></h1>
		<br><br>
	   	<img src="graphics/new/gh_demo_hotel.png" style="height: 100px; width: 100px;">
	   	<br><br>	
		<h3 style="font-size: 1.6em;"><%=hotelBookingMessage%></h3>
	</DIV>
	<BR><BR>
	<%
	      session.removeAttribute("hotelBookingResponse");
	  }
	%>
   </tr>
</TABLE>
 

<div class="push"></div>
</div>

<div class="footer">
	<SPAN CLASS="smallprint" > 
	<%@ include file="inc-build-copyright.jsp"%>
	</SPAN>
	
</div>

<%@ include file="inc-footer.jsp"%>
<%@ include file="currency-change.jsp"%>