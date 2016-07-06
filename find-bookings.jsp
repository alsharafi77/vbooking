<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.logon.*"%>
<%@page import="javax.xml.rpc.holders.*"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page errorPage="error.jsp" %>
<%
String _pageTitle = "Vacation Booking online flight booking"; 
%>
<%@ include file="inc-page-init.jsp" %>

<%
	//Load some config parameters from web.xml
	ServletContext servletConfig = getServletContext();	
	String url = servletConfig.getInitParameter("logonWSURL");
		
	LogonServiceImplServiceLocator loc = new LogonServiceImplServiceLocator();
	if (url != null) {
		loc.setLogonServiceImplEndpointAddress(url);
	}
	LogonServiceImpl port = loc.getLogonServiceImpl();
	
	String user = (String)request.getParameter("myusername");
	String sessionID = (String) session.getAttribute("sessionID");
	if (!port.isLoggedOn("greenhat", sessionID)){
		((HttpServletResponse)response).sendRedirect("login.jsp?msg=Failed to authenticate&myusername="+(user!=null?user:""));
	}
	if (user != null) {	
		String password = (String)request.getParameter("mypassword");
		BooleanHolder successHolder = new BooleanHolder();
		StringHolder sessionHolder = new StringHolder();
		port.logon(user, password, successHolder, sessionHolder);
		boolean success = successHolder.value;
		if (!success) {
			((HttpServletResponse)response).sendRedirect("login.jsp?msg=Failed to authenticate&myusername="+user);
		} else {
			session.setAttribute("sessionID", sessionHolder.value);
		}
	}
%>
<div class="wrapper"> 
<TABLE class="block" >
	<TR>
		<TD valign=top>
			<DIV class="new_header">
				<%@ include file="inc-header-no-currency.jsp" %>
			</DIV> 				
		</TD>
	</TR>
	<TR>
<TD align="center">
	<table width="350" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#FFFFF">
		<tr>
		<td>
			<DIV CLASS="banner_manage_flight" style="margin-top: -20px; width: 200px;" >
				<img src="graphics/new/gh_demo_banner_fold_blue.png" style="float: left; margin-left: -4px;"> 
				<img src="graphics/new/banner_point_blue.png" style="float: right; margin-right: -28px;">
				<h4 style="font-weight: bold; text-align: center; margin-top: 3px; ">Find Booking Information</h4>
			</DIV>
			<BR><BR>
		</TD>
		</tr>
		<tr>
		<form name="form1" method="post" action="amend-bookings.jsp">
			<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
				<tr align="center">
				<td>										
					<% if (request.getParameter("msg") != null) { %>
						<div CLASS="specialoffersbox">
							<h2><b> <%=request.getParameter("msg")%></b></h2>
						</div>
					<% } %>
					<% if (request.getParameter("ref") != null) { %> 
					<input class="DateText" style=" width: 150px; border: 1px solid #003a8c;" name="ref" type="text" id="refId" VALUE="<%=request.getParameter("ref")%>" placeholder=" Booking ID" />
				</td>
					<% } else { %>
						<input class="DateText" style=" width: 150px; border: 1px solid #003a8c;" name="ref" type="text" id="refId" placeholder=" Booking ID" />
				</td>
				<% } %>
				</tr> 
				<tr>
				<td colspan="3" style="text-align: right">
					<input class="btn" type="submit" name="Find" value="FIND" style="float:right; margin-left: 20px; margin-top: 20px; margin-right: 20px;margin-bottom: 20px;"/></td>
				</tr>
			</table>
		</td>
	</form>
</tr>
</table>
		

			
	<form method="get" name="fin" action="logout.jsp">
		<input class="btn" type="submit" value="LOGOUT" style="float:right; margin-left: 20px; margin-top: 20px; margin-right: 20px;margin-bottom: 20px;"/>
	</form>
			
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