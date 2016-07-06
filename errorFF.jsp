<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@ page isErrorPage="true" %>
<%@ page import="java.lang.*, java.io.*" %>

<html>
<head>
   <TITLE>Error</TITLE>

   <link rel="stylesheet" type="text/css" href="style.css" />
   
   <!-- Show/Hide DHTML function -->
   <script language=JAVASCRIPT type="text/javascript">
   <!--
   var state = 'hidden';

   function showhide(layer_ref) {
      if (state == 'visible') {
         state = 'hidden';
      }
      else {
         state = 'visible';
      }
      if (document.all) { //IS IE 4 or 5 (or 6 beta)
         eval( "document.all." + layer_ref + ".style.visibility = state");
      }
      if (document.layers) { //IS NETSCAPE 4 or below
         document.layers[layer_ref].visibility = state;
      }
      if (document.getElementById && !document.all) {
         maxwell_smart = document.getElementById(layer_ref);
         maxwell_smart.style.visibility = state;
      }
   }
   //-->
   </script>

</HEAD>
<BODY>

   <% 
      Throwable exc = exception;
      if (exc==null) exc = (Exception) request.getAttribute("javax.servlet.jsp.jspException");
      if (exc==null) exc = (Exception) request.getAttribute("error.exception");
      
      String msg = (String)request.getAttribute("msg");
      String debugInfo = (String)request.getAttribute("debug-info");
      String details = (String)request.getAttribute("details");
      
      if (msg==null && exc!=null) {
	     if (exc instanceof NoClassDefFoundError) { 
	         msg = "Missing jar file";
	         details = "The server doesn't have the java class <TT>" + exc.getMessage() + "</TT> loaded.<BR>\n" +
	                   "This normally means there is a needed jar file missing from WEB-INF/lib";
	     } else {
	         msg=exc.getMessage();
         }
      }
      if (msg==null && exc!=null) msg=exc.toString();
      if (msg==null) msg = request.getAttribute("javax.servlet.error.status_code")  + " : " + request.getAttribute("javax.servlet.error.message");
      if (msg==null) msg = "<I>no error message available</I>";
      
      if (details==null) {
	      details = "";
      } else {
	      details = "<P>" + details + "</P>";
      }
   %>

   <Table class="block">
		<tr><td VALIGN=TOP style="height: 40px;">
			<DIV class="new_header"><A class='usesCurrencyCode' HREF="indexFF.jsp" TITLE="Back to the flight booking homepage"><IMG STYLE="float:left; margin-right:9px;" SRC="graphics/new/gh_demo_vb_banner.png" ALT="logo" BORDER="0" /></A></DIV>
		</td></tr>
			<tr ><td valign=top align="center">
				<IMG SRC="graphics/error.png" ALT="Error" WIDTH="41" HEIGHT="40">
				<h4 style="margin-left: 100px; margin-right: 100px;"><B> <%=msg%> </B></h4>
        		 <%=details%>
        		 
        		  <BR>
        		  <h4>Return to the previous page by clicking <a href="javascript:history.back()">here</a>.</h4>
					<h4>Return to the main page by clicking <a href="indexFF.jsp">here</a>.</h4>
   					<BR>

<% if (exc!=null) { %>
   <a href="javascript://" onclick="showhide('details');">Show/Hide details</A>

   <DIV ID="details" style="visibility:hidden; text-align: left; margin-left: 100px; margin-right: 100px;">

     <P><B>Additional details:</B></P>

     <DIV CLASS=ERROR-MESSAGE>
        The following exception was reported:<%=exc.getMessage()%><BR>    
     </DIV>

     <P>
     It occurred at the following place:
     </P>
     <PRE>
<%exc.printStackTrace(new PrintWriter(out)); %>
     </PRE>

<%    if (exc.getCause()!=null) { %>
	  
     <P>
     Caused by:
     </P>
     <PRE>
<%exc.getCause().printStackTrace(new PrintWriter(out)); %>
     </PRE>
     
<%    } 


   if (debugInfo!=null) {
      if (!debugInfo.startsWith("<HTML>")) debugInfo = "<PRE>" + debugInfo + "</PRE>";
%>
     <P>DebugInfo:</P>
     <%=debugInfo%>
<% } %>

   </DIV>
<%
   } //end if
%>
		
		</td></tr>
	</Table>
</BODY>
</HTML>
