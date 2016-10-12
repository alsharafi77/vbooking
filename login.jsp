<%-- Vacation Booking demo - � 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.logon.*"%>
<%@page errorPage="error.jsp" %>
<%
String _pageTitle = "Vacation Booking online flight booking2"; 
%>
<%@ include file="inc-page-init.jsp" %>

<%
	// Load some config parameters from web.xml
	ServletContext servletConfig = getServletContext();	
	String url = servletConfig.getInitParameter("logonWSURL");
		
	LogonServiceImplServiceLocator loc = new LogonServiceImplServiceLocator();
	if (url != null) {
		loc.setLogonServiceImplEndpointAddress(url);
	}
	LogonServiceImpl port = loc.getLogonServiceImpl();
	
	String sessionID = (String) session.getAttribute("sessionID");
	if (port.isLoggedOn("greenhat", sessionID)){
		((HttpServletResponse)response).sendRedirect("find-bookings.jsp");
	}
%>
<div class="wrapper">
<TABLE class="block">
	<TR>
		<TD>
			<DIV class="new_header">
				<%@ include file="inc-header-no-currency.jsp"%>
			</DIV>
		</TD>
	</TR>
	<TR>
		<TD align="center">
			<table width="300" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="margin: 100px auto;">
				<tr>
				<td>
					<DIV CLASS="banner_manage_flight" style="margin-top: -20px"> 
						<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -4px;"> 
						<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
						<h4 style="font-weight: bold; text-align: center; margin-top: 3px;">Member login</h4>
					</DIV>
					<BR><BR>
				</TD>
				</tr>
				<tr align="center">
					<form name="form1" method="post" action="find-bookings.jsp">
						<td>
							<table border="0" bgcolor="#FFFFFF">
								<TR><td> 
									<input class="DateText" style="  width: 175px; border: 1px solid #003a8c;" name="myusername" type="text" id="myusername" placeholder=" Username"  />
								</td></tr>
								<tr><td>
									<input class="DateText" style="  width: 175px; border: 1px solid #003a8c;" name="mypassword" type="password" id="mypassword" placeholder=" Password"  />
								</td></tr>
								<tr><td>
									<input class="btn" type="submit" value="LOGIN" style="float:right;  margin-top: 20px; margin-bottom: 20px;"/>
								</td></tr>
							</table> 
						<% if (request.getParameter("msg") != null) {  %>
							<center>
								<div CLASS="specialoffersbox">
									<b> <%=request.getParameter("msg")%> </b>
								</div>
							</center> 
						<% } %>
						</td>
					</form>
				</tr>
			</table>
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
