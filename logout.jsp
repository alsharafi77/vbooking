<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page import="com.vbooking.logon.*"%>
<%@page errorPage="error.jsp" %>
<%
String _pageTitle = "Vacation Booking online flight booking"; 
%>
<%@ include file="inc-page-init.jsp" %>
<%@ include file="inc-header.jsp" %>

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
	port.logoff("greenhat", sessionID);
	session.removeAttribute("sessionID");
	response.sendRedirect("index.jsp");
%>

<HR>
<SPAN CLASS="smallprint">
<%@ include file="inc-build-copyright.jsp" %>
</SPAN>

<%@ include file="inc-footer.jsp" %>