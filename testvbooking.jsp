<%-- Vacation Booking test - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.booking.hotel.Hotel"%>
<%@page import="com.vbooking.booking.hotel.FindHotels"%>
<%@page import="com.vbooking.booking.web.AirportCodeMapper"%>
<%@page import="com.vbooking.flights.Flight"%>
<%@page import="com.vbooking.flights.FlightsRest"%>
<%@page import="com.vbooking.logon.*"%>
<%@page errorPage="error.jsp"%>
<%@ include file="inc-page-init.jsp"%>
<%
	String testCompleteText = request.getParameter("testComplete");
	String showTestComplete = "visibility:hidden";
	if (testCompleteText != null) {
		showTestComplete = "visibility:visible";
	}

	String result1 = request.getParameter("test1");
	if (result1 == null)
		result1 = "Not run";
	String result2 = request.getParameter("test2");
	if (result2 == null)
		result2 = "Not run";
	String result3 = request.getParameter("test3");
	if (result3 == null)
		result3 = "Not run";
	String result4 = request.getParameter("test4");
	if (result4 == null)
		result4 = "Not run";
	String result5 = request.getParameter("test5");
	if (result5 == null)
		result5 = "Not run";
	String result6 = request.getParameter("test6");
	if (result6 == null)
		result6 = "Not run";
	String result7 = request.getParameter("test7");
	if (result7 == null)
		result7 = "Not run";
	String result8 = request.getParameter("test8");
	if (result8 == null)
		result8 = "Not run";
	String result9 = request.getParameter("test9");
	if (result9 == null)
		result9 = "Not run";
	String result10 = request.getParameter("test10");
	if (result10 == null)
		result10 = "Not run";
	String result11 = request.getParameter("test11");
	if (result11 == null)
		result11 = "Not run";
		
	String _pageTitle = "Test Vacation Booking";

	// help messages
	String help1 = "";
	if (result1.equals("ERROR")) {
		help1 = "There is a problem connecting to WebsphereMQ.<BR>Check MQ is running and configured correctly.<BR>Check web.xml and config.xml set up correctly.";
	}
	String help2 = "";
	if (result2.equals("ERROR")) {
		help2 = "There is a problem connecting to Websphere.<BR>Check WAS is running and configured correctly.<BR>Check that the WAS applications are running.";
	}
	String help3 = "";
	if (result3.equals("ERROR")) {
		help3 = "There is a problem connecting to Database.<BR>Please check that DB is running and configured correctly.";
	}
	String help4 = "";
	if (result4.equals("ERROR")) {
		help4 = "There is a problem searching for flights.<BR>Please check the status of the flights application<BR>in WebSphere Application Server.";
	}
	String help5 = "";
	if (result5.equals("ERROR")) {
		help5 = "There is a problem connecting to Flight Confirmation Server.<BR>Please make sure standalone FCS Server is running<BR>and corresponding MQ is running and configured correctly.";
	}
	String help6 = "";
	if (result6.equals("ERROR")) {
		help6 = "There is a problem connecting to Hotels Service.<BR>Please make sure Tomcat is setup properly<BR>and Hotels Service is running.";
	}
	String help7 = "";
	if (result7.equals("ERROR")) {
		help7 = "There is a problem connecting to Currency Service.<BR>Please make sure standalone Currency Service is running.";
	}
	String help8 = "";
	if (result8.equals("ERROR")) {
		help8 = "There is a problem connecting to Frequent Flyer Service.<BR>Please make sure standalone Frequent Flyer Service is running.";
	}
	String help9 = "";
	if (result9.equals("ERROR")) {
		help9 = "There is a problem with the Database metadata that is being used.<BR>The DB metadata information doesn't match the required metadata for this application.";
	}
	String help10 = "";
	if (result10.equals("ERROR")) {
		help10 = "There is a problem connecting to ActiveMQ<BR>Please make sure it is running and try again.";
	}
	String help11 = "";
	if (result11.equals("ERROR")) {
		help11 = "There is a problem connecting to the server.<BR>Please make sure it is running and try again.";
	}
%>
<%@ include file="inc-header.jsp"%>
<style type="text/css">
td
{
    padding:8px 15px 8px 15px;
}
</style>
<script language="JavaScript" src="date-picker.js"></script>
<table BORDER=0 CELLPADDING="2px" CELLSPACING=0 WIDTH="100%" class="block">
	<TR>
		<TD><br> <b>Test Vacation Booking Operations</b> <br>
			<FORM id="testvbookingForm" name="testvbookingForm"
				ACTION="pleaseWait.jsp">
				<TABLE BORDER=0 CELLPADDING="2px" CELLSPACING=0 class="noTopBorder">


					

					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test1" class="btn"/>
						</TD>
						<TD><%=result1%></TD>
						<TD>Test that MQ is running</TD>
						<TD><%=help1%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test2" class="btn"/>
						</TD>
						<TD><%=result2%></TD>
						<TD>Test that WAS is running</TD>
						<TD><%=help2%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test3" class="btn"/>
						</TD>
						<TD><%=result3%></TD>
						<TD>Test that DB is up and running</TD>
						<TD><%=help3%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test4" class="btn" />
						</TD>
						<TD><%=result4%></TD>
						<TD>Test that Flight Search is working correctly</TD>
						<TD><%=help4%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test5" class="btn"/>
						</TD>
						<TD><%=result5%></TD>
						<TD>Test that Flight Confirmation Server is working correctly</TD>
						<TD><%=help5%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test6" class="btn"/>
						</TD>
						<TD><%=result6%></TD>
						<TD>Test that Hotels Service is working correctly</TD>
						<TD><%=help6%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test7"  class="btn"/>
						</TD>
						<TD><%=result7%></TD>
						<TD>Test that Currency Service is working correctly</TD>
						<TD><%=help7%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test8" class="btn" />
						</TD>
						<TD><%=result8%></TD>
						<TD>Test that Frequent Flyer Service is working correctly</TD>
						<TD><%=help8%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test9" class="btn" />
						</TD>
						<TD><%=result9%></TD>
						<TD>Test that DB metadata is configured correctly</TD>
						<TD><%=help9%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test10" class="btn" />
						</TD>
						<TD><%=result10%></TD>
						<TD>Test that ActiveMQ is running</TD>
						<TD><%=help10%></TD>
					</TR>
					<TR>
						<TD ALIGN="RIGHT"><INPUT TYPE="SUBMIT" name="actionBtn"
							VALUE="test11" class="btn" />
						</TD>
						<TD><%=result11%></TD>
						<TD>Test that Available Seats Server is working correctly</TD>
						<TD><%=help11%></TD>
					</TR>
					<TR>
						<TD ALIGN="CENTER" COLSPAN=3><INPUT type="Submit"
							name="actionBtn" value="Test All" class="btn" />
						</TD>
					</TR>
					<TR>
						<TD ALIGN="Center" COLSPAN=3><BR>
							<p style="<%=showTestComplete%>"><%=testCompleteText%></p> <BR>
						</TD>
					</TR>
					<INPUT TYPE="HIDDEN" name="test1" value="<%=result1%>" />
					<INPUT TYPE="HIDDEN" name="test2" value="<%=result2%>" />
					<INPUT TYPE="HIDDEN" name="test3" value="<%=result3%>" />
					<INPUT TYPE="HIDDEN" name="test4" value="<%=result4%>" />
					<INPUT TYPE="HIDDEN" name="test5" value="<%=result5%>" />
					<INPUT TYPE="HIDDEN" name="test6" value="<%=result6%>" />
					<INPUT TYPE="HIDDEN" name="test7" value="<%=result7%>" />
					<INPUT TYPE="HIDDEN" name="test8" value="<%=result8%>" />
					<INPUT TYPE="HIDDEN" name="test9" value="<%=result9%>" />
					<INPUT TYPE="HIDDEN" name="test10" value="<%=result10%>" />
					<INPUT TYPE="HIDDEN" name="test11" value="<%=result11%>" />
				</TABLE>
			</FORM></TD>
	</TR>
</TABLE>
<div style="width: 98%">
	<HR>
	<SPAN CLASS="smallprint"> <%@ include
			file="inc-build-copyright.jsp"%> <BR> </SPAN>
</div>

<%@ include file="inc-footer.jsp"%>
