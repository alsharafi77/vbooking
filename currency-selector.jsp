<%@page import="com.vbooking.booking.currency.CurrencyUtil"%>
<%
	if (request.getParameter("currency") != null) {
		request.getSession().setAttribute("currency", request.getParameter("currency"));	
	}

	CurrencyUtil currencyUtil = new CurrencyUtil(getServletContext().getInitParameter("currencyWSURL"));
	String[][] currencies =  currencyUtil.currencies();
	String[] localCurrency = currencyUtil.localCurrency();
%>
<div class = "languagebar">
<select id='currencySelector' class = "topselect">
		<%
	for (int i=0; i < currencies.length; i++) {
		String[] currency = currencies[i];
		String strSelected = "";
	    //System.out.println("Currency Code:" + currency[0] + " symbol:" + currency[1] + " rate:" + currency[2]);
		if (currency[0].equalsIgnoreCase(localCurrency[0])) {
			strSelected = "selected";
		}
%>
		<option code='<%=currency[0] %>' symbol='<%=currency[1] %>'
			rate='<%=currency[2] %>' <%=strSelected %>><%=currency[0] %></option>
		<%		
	}
%>
</SELECT>

<!-- | -->

<!-- <a href="index.jsp">HELP</a> For now, just re-directs to the home page (should there really even be a help?) -->
<option></option></div>
 