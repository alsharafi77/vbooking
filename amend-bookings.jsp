<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="java.math.BigInteger"%>
<%@page import="com.vbooking.reservations.types.wsdl.Reservation.GetBookingByReservationNumberServiceLocator"%>
<%@page import="com.vbooking.reservations.types.wsdl.Reservation.GetBookingByReservationNumber"%>
<%@page import="com.vbooking.reservations.schemas.GetBookingRequest.GetBookingRequestType"%>
<%@page import="com.vbooking.reservations.schemas.GetBookingResponse.DetailRecord"%>
<%@page import="com.vbooking.reservations.schemas.AuthenticationFault.AuthenticationFault"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page errorPage="error.jsp" %>
<%
String _pageTitle = "Vacation Booking online flight booking"; 
%>
<%@ include file="inc-page-init.jsp" %>
<br>
<br>
<div class="wrapper">
<%
    String sessionID = (String) session.getAttribute("sessionID");
	if (sessionID == null) {
		((HttpServletResponse)response).sendRedirect("login.jsp?msg=User is not authenticated");
	}
	
	String referenceId = (String)request.getParameter("ref");
	if (referenceId == null) {
		((HttpServletResponse)response).sendRedirect("find-bookings.jsp?msg=Booking Reference not found&ref="+referenceId);
	}
	
	//Load some config parameters from web.xml
	ServletContext servletConfig = getServletContext();	
	String url = servletConfig.getInitParameter("getBookingWSURL");
	
	GetBookingByReservationNumberServiceLocator loc = new GetBookingByReservationNumberServiceLocator();
	if (url != null) {
		loc.setGetBookingByReservationNumberPortEndpointAddress(url);
	}
	GetBookingByReservationNumber port = loc.getGetBookingByReservationNumberPort();
	
	GetBookingRequestType getBookingRequest = new GetBookingRequestType();
	getBookingRequest.setReservationNumber(referenceId);
	getBookingRequest.setFlightNumber("myFlight");
	getBookingRequest.setSessionID(sessionID);
	
	DetailRecord[] records = null;
	try {
		records = port.getBookingByReservationNumber(getBookingRequest);
	} catch (AuthenticationFault af) {
	    if ("ERR0001".equals(af.getErrorCode())) {
	        ((HttpServletResponse)response).sendRedirect("login.jsp?msg=Error authenticating user. The session is invalid");
		}
		((HttpServletResponse)response).sendRedirect("login.jsp?msg=There was a problem authenticating the current session. " + af.getErrorMessage());
	}
	if (records == null || records.length == 0) {
		((HttpServletResponse)response).sendRedirect("find-bookings.jsp?msg=No bookings with reference "+referenceId+"&ref="+referenceId);
	}
%>

<%
	if (records != null && records.length > 0) {
		String flightNumberParam = records[0].getFlightNumber()!= null ? records[0].getFlightNumber() : "0";
		String weekNumberParam = records[0].getWeekNumber() != null ? records[0].getWeekNumber() : "<unknown>";
		BigInteger priceParam = records[0].getPrice() != null ? records[0].getPrice() : new BigInteger("0");
		String firstNameParam = records[0].getPassengerFirstName() != null ? records[0].getPassengerFirstName() : "";
		String middleNameParam = records[0].getPassengerMiddleName() != null ? records[0].getPassengerMiddleName() : "";
		String lastNameParam = records[0].getPassengerLastName() != null ? records[0].getPassengerLastName() : "";
		String genderParam = records[0].getPassengerGender() != null ? records[0].getPassengerGender() : "M";
		
%>

<!-- Form for updating and canceling a booking. -->
<FORM name="form41251" method="post" action="do-amend.jsp">
<table class="container">
	<TR>
 	<TD valign="bottom">
	<table class="block_searched" style="float: left; padding: 20px; margin-right: 5px; height: 400px;">
		<TR>
			<TD valign="top" style="height: 5px;">
				<DIV class="new_header" >
					<%@ include file="inc-header.jsp"%>
				</DIV>
				<br><br>
			</TD>
		</TR>
		<TR>
			<TD valign="top" >
			<%
				if (request.getParameter("msg") != null) {
			%>
				<div CLASS="specialoffersbox">
					<h1><b> <%=request.getParameter("msg")%></b></h1>
				</div>		
			<%
				} else if (referenceId != null) {
			%>		
			<div CLASS="specialoffersbox">
				<h1><b> <%=referenceId%></b></h1>
			</div>		
			<%
				}
			%>
			<DIV CLASS="banner_book_flight" style="position: relative;">
				<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
				<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
				<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">FLIGHT DETAILS</h4>
			</DIV>
			<BR><BR><BR>
			<div>
				<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">FLIGHT</h3> 
				<p  style="font-weight: bold; float: right; margin-right: 20px;" ><%=flightNumberParam%>-<%=weekNumberParam%></p>
			</div>
			<br><br>
			<div>
				<h3 style="font-weight: bold; margin-left: 20px; margin-bottom: 5px; float: left;">COST</h3>
				<B><FONT SIZE=+1><div style='display: inline; float: right; margin-right: 20px;' class='currency' price='<%=priceParam%>'><%=priceParam%></div></FONT></B>
			</div>
			<INPUT TYPE="HIDDEN" NAME="ref" VALUE="<%=referenceId%>" readonly="true"\>
			<INPUT TYPE="HIDDEN" NAME="flightnumber" VALUE="<%=flightNumberParam%>" readonly="true" size="8"\>
			<INPUT TYPE="HIDDEN" NAME="weeknumber" VALUE="<%=weekNumberParam%>" readonly="true" size="8"\>
			</TD>
		</TR>
	</table>
	</TD>
	<TD valign="bottom">
		<table class="block_searched" style="float: left; padding: 20px; margin-left: 5px; margin-right:5px; height: 400px; " >
			<!-- Customer table -->
					<TR>
						<TD valign="top">
							<DIV CLASS="banner_book_flight" style="position: relative; margin-top: 20px;">
								<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
								<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
								<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">PASSENGER</h4>
							</DIV>
						<BR><BR><BR><BR>
							<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengerfirstname"
								VALUE="<%=firstNameParam%>" placeholder=" First Name" size="20"\>
						<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengermiddlename"
							VALUE="<%=middleNameParam%>" placeholder=" Middle Name" size="20"\>					
						<INPUT class="PassengerText" style="margin-top: 5px; margin-bottom: 5px;" TYPE="TEXT" NAME="passengerlastname"
							VALUE="<%=lastNameParam%>" placeholder=" Last Name" size="20"\>					
						<SELECT class="booked_set" style="width: 150px; background-color: #003a8c; margin-top: 5px; margin-left: 20px;" NAME="passengergender">
								<OPTION VALUE="Male" <%=genderParam.equals("M")?"selected=\"selected\"":""%>>Male</OPTION>
								<OPTION VALUE="Female" <%=!genderParam.equals("M")?"selected=\"selected\"":""%>>Female</OPTION>
						</SELECT>	
						
						
						<BR><BR>
						<div style="float: left;">
							<INPUT TYPE="SUBMIT" class="btn" style="margin-left: 20px;" VALUE="UPDATE" NAME="function" />
							<br><br>
							<INPUT TYPE="SUBMIT" class="btn" style="margin-left: 20px;" VALUE="CANCEL" NAME="function"/>
							<br><br>
						</div>
						<!-- Form to find another booking - FIX FORM WITHIN FORM -->
<!-- 						<form method="get" name="sa" action="find-bookings.jsp"> -->
<!-- 							<INPUT TYPE="SUBMIT" class="btn" style="margin-left: 20px; width: 255px" VALUE="FIND ANOTHER BOOKING" /> -->
<!-- 						</form> -->
						<INPUT TYPE="SUBMIT" class="btn" style="margin-left: 20px; width: 255px" VALUE="FIND ANOTHER BOOKING" NAME="function" />
						
						</TD>
					</TR>																			
			</table>
		</TD>
	</TR>
	
</table>		
</form>


<%
	}
%>

<div class="push"></div>
</div>

<div class="footer">
	<SPAN CLASS="smallprint" > 
	<%@ include file="inc-build-copyright.jsp"%>
	</SPAN>
	
</div>

<%@ include file="inc-footer.jsp"%>
<%@ include file="currency-change.jsp"%>