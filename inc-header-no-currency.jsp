<!-- Vacation Booking Demo - © 2001-2015 IBM Corporation. -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=_pageTitle%></title>
<link rel="stylesheet" type="text/css" href="style.css">
<meta HTTP-EQUIV="content-type" CONTENT="text/html; charset=UTF-8">
<link rel="shortcut icon" href="graphics/new/gh_demo_vbooking_icon.ico"/>
</head>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	//If callDoLoad request attribute is set, then we stuff in a onLoad javascript call in the BODY tag
	String doLoadcall = "";
	Boolean callDoLoad_B = (Boolean) request.getAttribute("callDoLoad");
	if (callDoLoad_B!=null && callDoLoad_B.booleanValue()) {
		doLoadcall = " onLoad='javascript:doLoad();'";
	}
%>

<BODY <%=doLoadcall%>>
	<DIV>
		<A class='usesCurrencyCode' HREF="index.jsp"
			TITLE="Back to the flight booking homepage"><IMG
			STYLE="float: left; margin-right: 9px;"
			SRC="graphics/new/gh_demo_vb_banner.png" ALT="logo" BORDER="0" /></A>
	</DIV>

	<!-- <div style="float: right; margin-top: -3px; margin-right: -333px;"> -->
	<%-- 	<%@ include file="currency-selector.jsp" %> --%>
	<!-- </div> -->
	<DIV ClASS="content">