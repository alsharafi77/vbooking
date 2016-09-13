<%-- Vacation Booking demo - � 2001,2015 IBM Corporation. --%>
<%@page errorPage="error.jsp"%>
<%
	String _pageTitle = "Vaction Booking online flight booking";
	String city = "";
	String from = "";
	String to = "";
	boolean home = true;
%>
<%@ include file="inc-page-init.jsp"%>

<%
	ServletContext servletConfig = getServletContext();
	String FFVersion = servletConfig.getInitParameter("FFVersion");
	if (FFVersion.equals("YES")) {
		System.out.println("Redirecting to \"indexFF.jsp\"");
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("indexFF.jsp");
		dispatcher.forward(request, response);
	}
%>
<div class="wrapper">
<TABLE class="block">
	<TR>
<!-- HEADER GOES HERE ONTO THE BIG BLUE BOX -->
		<TD>
			<DIV class="new_header">
				<%@ include file="inc-header.jsp"%>
			</DIV>
		</TD>
	</TR>
	<TR>
<!-- INITIAL GREETINGS AND TRIP BOX -->
		<TD>
			<br><br><br>
			<h1 style="text-indent: 20px; margin-top: -60px;">Welcome to Vacation Booking, the best way to plan your holiday. </h1>
			<h3 style="text-indent: 20px;">Find a flight or hotel using our search options or take advantage of our latest special offers.</h3> 
			<br>
			<DIV CLASS="banner_book_flight">
				<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -10px"> 
				<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
				<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">BOOK A TRIP</h4>
			</DIV> 
			<br> 
			<%@ include file="inc-create-trip-box.jsp"%>
		</TD>
<!-- MANAGING FLIGHT BOX -->
		<TD>
			<DIV CLASS="flightBook_box" style="float: right;">
				<DIV CLASS="banner_manage_flight">
					<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -11px;"> 
					<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
					<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">MANAGE FLIGHTS</h4>
				</DIV>
				<br>
				<h2>Manage your existing flights.</h2>
				<h3>Looking for a trip or another purchase? Find it here.</h3>
				<br><br>
				<FORM NAME="amendBookings" METHOD="GET" ACTION="login.jsp">
					<INPUT class="btn-flight" TYPE="SUBMIT" VALUE="FIND A BOOKING" STYLE="float: left;" />
				</FORM>
			</DIV>
		</TD>
	</tr>

</TABLE>
<br>
<!-- IMAGES BELOW BIG BLUE BOX BACKGROUND -->
<TABLE class="images">
	<tr>
<!-- BARCELONA W/ BANNER -->	
		<TD STYLE="padding: 10px;">
			<DIV CLASS="banner_specials">
				<img src="graphics/new/gh_demo_banner_fold_orange.png" style="float: left; margin-left: -10px"> 
				<img src="graphics/new/gh_demo_banner_point_orange.png" style="float: right; margin-right: -28px;">
				<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">FLIGHT SPECIALS</h4>
			</DIV>
			
			<DIV CLASS="transparent"></DIV>
			
			<DIV style="position: absolute; margin-top: 0px; margin-left: 180px; font-size: 3.0EM; color: #ea5600; font-weight: bold;" class='currency' price='100'>100</DIV>
			<h6 style="font-size: 1.1em; font-weight: bold; position: absolute; margin-top: 43px; margin-left: 190px;">book by Dec 10*</h6>

			<FORM NAME="barcelonaoffer" METHOD="GET" ACTION="book-flight.jsp" class='usesCurrencyCode'>
				<INPUT TYPE="HIDDEN" NAME="flightnumber" VALUE="VB297" /> 
				<INPUT TYPE="HIDDEN" NAME="weeknumber" VALUE="49" /> 
				<INPUT TYPE="HIDDEN" NAME="flyingfrom" VALUE="STN" /> 
				<INPUT TYPE="HIDDEN" NAME="flyingto" VALUE="BCN" /> 
				<INPUT TYPE="HIDDEN" NAME="from" VALUE="10/12/<%=Calendar.getInstance().get(Calendar.YEAR)%>" /> 
				<INPUT TYPE="HIDDEN" NAME="departs" VALUE="10/12/<%=Calendar.getInstance().get(Calendar.YEAR)%> 05:45" />
				<INPUT TYPE="HIDDEN" NAME="arrives" VALUE="10/12/<%=Calendar.getInstance().get(Calendar.YEAR)%> 07:20" />
				<INPUT TYPE="HIDDEN" NAME="price" VALUE="100" /> 
				<INPUT TYPE="HIDDEN" NAME="tripType" VALUE="f" /> 
				<INPUT TYPE="HIDDEN" NAME="specialOffer" VALUE="true" /> 
				<INPUT TYPE="SUBMIT" NAME="submit" class="trans_btn" value="Barcelona" />
			</FORM> 
			<!--    		 Image supplied by Pixabay  -->
			<img src="graphics/new/gh_demo_flightbarcelona.jpg" style="width: 330px; height: 200px;">
		</TD>
		
<!-- EDINBOROUGH NO BANNER -->		
		<TD STYLE="padding: 10px;">
			<DIV CLASS="transparent"></DIV>
			<div style="position: absolute;  margin-top: 0px; margin-left: 180px; font-size: 3.0EM; color: #ea5600; font-weight: bold;"	class='currency' price='80'>80</div>
			<h6 style="font-size: 1.1em; font-weight: bold; position: absolute; margin-top: 43px; margin-left: 190px;">book by Oct 14*</h6>

			<FORM NAME="edinboroughoffer" METHOD="GET" ACTION="book-flight.jsp" class='usesCurrencyCode'>
				<INPUT TYPE="HIDDEN" NAME="flightnumber" VALUE="VB047" /> 
				<INPUT TYPE="HIDDEN" NAME="weeknumber" VALUE="41" /> 
				<INPUT TYPE="HIDDEN" NAME="flyingfrom" VALUE="STN" /> 
				<INPUT TYPE="HIDDEN" NAME="flyingto" VALUE="EDI" /> 
				<INPUT TYPE="HIDDEN" NAME="from" VALUE="14/10/<%=Calendar.getInstance().get(Calendar.YEAR)%>" /> 
				<INPUT TYPE="HIDDEN" NAME="departs" VALUE="14/10/<%=Calendar.getInstance().get(Calendar.YEAR)%> 08:45" />
				<INPUT TYPE="HIDDEN" NAME="arrives" VALUE="14/10/<%=Calendar.getInstance().get(Calendar.YEAR)%> 09:30" />
				<INPUT TYPE="HIDDEN" NAME="price" VALUE="80" /> 
				<INPUT TYPE="HIDDEN" NAME="tripType" VALUE="f" /> 
				<INPUT TYPE="HIDDEN" NAME="specialOffer" VALUE="true" /> 
				<INPUT TYPE="SUBMIT" NAME="submit" class="trans_btn" value="Edinburgh" />
			</FORM> 
			<!--    		 Image supplied by Pixabay  -->
			<img src="graphics/new/gh_demo_flightedinburgh.jpg" style="width: 330px; height: 200px;">
		</TD>
		
<!-- HOTEL + FLIGHT W/ BANNER  -->		
		<TD STYLE="padding: 10px;">
			<DIV CLASS="banner_deals">
				<img src="graphics/new/gh_demo_banner_fold_orange.png" style="float: left; margin-left: -10px"> 
				<img src="graphics/new/gh_demo_banner_point_orange.png" style="float: right; margin-right: -28px;">
				<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">FLIGHT + HOTEL DEALS</h4>
			</DIV>

			<DIV CLASS="transparent"></DIV>
			<h6 style="font-size: 1.5em; position: absolute; margin-top: 10px; margin-left: 180px; white-space: nowrap;">Weekend Trip</h6>
			<h6 style="font-size: 1.1em; font-weight: bold; position: absolute; margin-top: 35px; margin-left: 190px; white-space: nowrap;">book by Dec 10*</h6>
			<FORM NAME="barcelonaweekendoffer" METHOD="GET" ACTION="book-flight.jsp" class='usesCurrencyCode'>
				<INPUT TYPE="HIDDEN" NAME="flightnumber" VALUE="VB232" /> 
				<INPUT TYPE="HIDDEN" NAME="weeknumber" VALUE="49" /> 
				<INPUT TYPE="HIDDEN" NAME="flyingfrom" VALUE="STN" /> 
				<INPUT TYPE="HIDDEN" NAME="flyingto" VALUE="BCN" /> 
				<INPUT TYPE="HIDDEN" NAME="departs" VALUE="08/12/<%=Calendar.getInstance().get(Calendar.YEAR)%> 05:45" />
				<INPUT TYPE="HIDDEN" NAME="arrives" VALUE="09/12/<%=Calendar.getInstance().get(Calendar.YEAR)%> 07:20" />
				<INPUT TYPE="HIDDEN" NAME="hotelFrom" VALUE="08/12/<%=Calendar.getInstance().get(Calendar.YEAR)%>" /> 
				<INPUT TYPE="HIDDEN" NAME="hotelTo" VALUE="09/12/<%=Calendar.getInstance().get(Calendar.YEAR)%>" /> 
				<INPUT TYPE="HIDDEN" NAME="tripType" VALUE="fh" /> 
				<INPUT TYPE="HIDDEN" NAME="price" VALUE="100" /> 
				<INPUT TYPE="HIDDEN" NAME="specialOffer" VALUE="true" /> 
				<INPUT TYPE="SUBMIT" NAME="submit" class="trans_btn" value="Barcelona" />
			</FORM> 
			<!--    		 Image supplied by Pixabay  -->
			<img src="graphics/new/gh_demo_hotelbarcelona.jpg" style="width: 330px; height: 200px;">
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
