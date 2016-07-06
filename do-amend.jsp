<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.reservations.types.wsdl.Reservation.CancellationServiceLocator"%>
<%@page import="com.vbooking.reservations.types.wsdl.Reservation.Cancellation"%>
<%@page import="com.vbooking.reservations.types.wsdl.Reservation.UpdateServiceLocator"%>
<%@page import="com.vbooking.reservations.types.wsdl.Reservation.Update"%>
<%@page import="com.vbooking.reservations.schemas.CancelBookingRequest.CancelBookingRequestType"%>
<%@page import="com.vbooking.reservations.schemas.CancelBookingResponse.CancelBookingResponse"%>
<%@page import="com.vbooking.reservations.schemas.UpdateBookingRequest.UpdateBookingRequestType"%>
<%@page import="com.vbooking.reservations.schemas.UpdateBookingResponse.UpdateBookingResponse"%>
<%@page import="com.vbooking.reservations.types.schemas.Reservation.Reservation"%>
<%@page import="com.vbooking.reservations.types.schemas.Gender.Gender"%>
<%@page import="com.vbooking.reservations.schemas.AuthenticationFault.AuthenticationFault"%>
<%@page import="java.math.BigInteger"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page errorPage="error.jsp" %>
<%
String _pageTitle = "Vacation Booking online flight booking"; 
%>
<%@ include file="inc-page-init.jsp" %>
<div class ="wrapper">
<TABLE class="block" >
	<TR>
		<TD valign = "top">
			<DIV class="new_header">
				<%@ include file="inc-header-no-currency.jsp" %>
			</DIV> 		
		</TD>
	</TR>
	<TR>
	<TD align="center">
	<DIV style=" margin-left: auto; margin-right: auto;">
		<br>
		<%
	    String sessionID = (String) session.getAttribute("sessionID");
		if (sessionID == null) {
			((HttpServletResponse)response).sendRedirect("login.jsp?msg=User is not authenticated");
		}
	
		String referenceId = (String)request.getParameter("ref");
		String functionName = (String)request.getParameter("function");
		if("FIND ANOTHER BOOKING".equals(functionName)){
			//window.location = "find-bookings.jsp";
			response.sendRedirect("find-bookings.jsp");
			return;
		}
		else if ("CANCEL".equals(functionName)) {
		
			//Load some config parameters from web.xml
			ServletContext servletConfig = getServletContext();	
			String url = servletConfig.getInitParameter("cancelBookingWSURL");
		
			CancellationServiceLocator loc = new CancellationServiceLocator();
			if (url != null) {
				loc.setCancellationPortEndpointAddress(url);
			}
			Cancellation port = loc.getCancellationPort();
			
			CancelBookingRequestType cancelRequest = new CancelBookingRequestType();
			Reservation res = new Reservation();
			res.setReservationNumber(referenceId);
			res.setPassengerFirstName(request.getParameter("passengerfirstname"));
			res.setPassengerMiddleName(request.getParameter("passengermiddlename"));
			res.setPassengerLastName(request.getParameter("passengerlastname"));
			res.setPassengerGender(Gender.fromValue(request.getParameter("passengergender")));
			
			cancelRequest.setReservation(res);
			cancelRequest.setSessionID(sessionID);
			
			CancelBookingResponse resp = null;
			try {
				resp = port.cancelBooking(cancelRequest);
			} catch (AuthenticationFault af) {
				if ("ERR0001".equals(af.getErrorCode())) {
					response.sendRedirect("login.jsp?msg=Error authenticating user. The session is invalid");
				}
				response.sendRedirect("login.jsp?msg=There was a problem authenticating the current session. " + af.getErrorMessage());
			}
			
			if (resp != null) {
		%>
		<div CLASS="specialoffersbox">
			<% if (resp.getCancelledReservationNumber() != null) { %>
				<h1>Booking cancelled successfully [Reservation number: <%=resp.getCancelledReservationNumber()%>]</h1>
			<% } else { %>
				<h1>Failed to cancel.</h1>
			<% } %>
		</div>
		<%
			} else {
				response.sendRedirect("login.jsp?msg=There was a problem cancelling the booking");
			}
		} else {
			//Load some config parameters from web.xml
			ServletContext servletConfig = getServletContext();	
			String url = servletConfig.getInitParameter("updateBookingWSURL");
			
			UpdateServiceLocator loc = new UpdateServiceLocator();
			if (url != null) {
				loc.setUpdatePortEndpointAddress(url);
			}
			Update port = loc.getUpdatePort();
			
			UpdateBookingRequestType updateRequest = new UpdateBookingRequestType();
			updateRequest.setFlightNumber(request.getParameter("flightnumber"));
			String week = request.getParameter("weeknumber");
			if (week == null || week.length() == 0) {
				week = "1";
			}
			updateRequest.setWeekNumber(new BigInteger(week));
			updateRequest.setReservationNumber(referenceId);
			updateRequest.setPassengerFirstName(request.getParameter("passengerfirstname"));
			updateRequest.setPassengerMiddleName(request.getParameter("passengermiddlename"));
			updateRequest.setPassengerLastName(request.getParameter("passengerlastname"));
			updateRequest.setPassengerGender(request.getParameter("passengergender").substring(0,1));		
			updateRequest.setSessionID(sessionID);
			
			UpdateBookingResponse resp = null;
			try {
				resp = port.updateBooking(updateRequest);
			} catch (AuthenticationFault af) {
				if ("ERR0001".equals(af.getErrorCode())) {
					response.sendRedirect("login.jsp?msg=Error authenticating user. The session is invalid");
				}
				response.sendRedirect("login.jsp?msg=There was a problem authenticating the current session. " + af.getErrorMessage());
			}
			
			
			if (resp != null) {
		%>
		<div CLASS="specialoffersbox">
			<% if (resp.getReservationNumber() != null) { %>
				<h1>Booking updated successfully [Reservation number: <%=resp.getReservationNumber()%>]</h1>
			<% } else { %>
				<h1>Failed to update.</h1>
			<% } %>
		</div>
		<%
			} else {
				response.sendRedirect("login.jsp?msg=There was a problem updating the booking.");
			}	
		}
		%>

	   	<br><br>
<!-- 	   	<img src="graphics/new/gh_demo_compass.gif" style="height: 100px; width: 100px;"> -->
	   	<br><br>
		<form method="get" name="fin" action="find-bookings.jsp">
				<input class="btn" type="SUBMIT" value="FIND ANOTHER BOOKING" style="width: 200px"/>
		</form>
		<form method="get" name="fin" action="logout.jsp">
			<input class="btn" type="SUBMIT" value="LOGOUT" style=""/>
		</form>
	</DIV>
	</TD>	
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