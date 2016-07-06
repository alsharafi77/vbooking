<!-- message.jsp -->

<%--
  Parameters
     msg -- a message to display (this can also be passed as a URL parameter)
     include-top-menu -- "true" or "false" (null means true)     

     jsredirect -- a page to redirect to using javascript (null means no redirect)
     frame -- a javascript frame name to apply the redirect to (null means this panel)
 --%>

<%@ page errorPage="error.jsp" %>

<%

   String msg=request.getParameter("msg");
   if (msg==null) msg=(String)request.getAttribute("msg");
   if (msg==null) msg="null message";

   String includeTopMenu_String = request.getParameter("include-top-menu");
   if (includeTopMenu_String==null) includeTopMenu_String=(String)request.getAttribute("include-top-menu");
   if (includeTopMenu_String==null) includeTopMenu_String="true";
   boolean includeTopMenu = includeTopMenu_String.equalsIgnoreCase("true");

   String jsredirect = (String)request.getAttribute("jsredirect");

   String frame = (String)request.getAttribute("frame");
   if (frame==null) frame="document"; //default is to redirect the page we are on

   String onLoadJavaScript = "";
   if (jsredirect!=null) {
      onLoadJavaScript = "javascript:" + frame + ".location='" + jsredirect + "';";
   }

   String title = msg;
   if (title.length()>50) title = title.substring(0, 50) + "...";
   if (title.indexOf("\n")>0) title = title.substring(0, title.indexOf("\n"));
   if (title.indexOf("<")>0) title = title.substring(0, title.indexOf("<"));


   if (includeTopMenu) {
      String activeTab = "";
      //DISABLED since there is no top-menu.jsp (yet)
      %><%--@ include file="../include/top-menu.jsp" --%><%
   } else {
      %>

<!-- includeTopMenu==false -->
<HTML>
  <HEAD>
    <TITLE><%=title%></TITLE>
  </HEAD>
  <BODY onLoad="<%=onLoadJavaScript%>">

<% } %>

    <FORM NAME="MessageForm" STYLE="display:inline;">
    <P><%=msg%></P>
    </FORM>
  </BODY>
</HTML>
