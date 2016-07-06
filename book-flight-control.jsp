<%-- Vacation Booking demo - © 2001,2015 IBM Corporation. --%>
<%@page errorPage="error.jsp" %>
<%@page import="java.util.*,
				java.io.PrintWriter,
				java.io.StringWriter,
                org.jdom.*,
                org.jdom.output.XMLOutputter,
                org.jdom.output.Format,
                java.io.IOException"%>
<%@page import="com.vbooking.booking.hotel.Hotel"%>
<%@page import="com.vbooking.booking.hotel.Booking"%>
<%@page import="com.vbooking.booking.hotel.Person"%>
<%@page import="com.vbooking.booking.hotel.Payment"%>
<%@page import="com.vbooking.booking.hotel.CardTypeDef"%>
<%@page import="com.vbooking.booking.hotel.FindHotels"%>
<%@page import="com.vbooking.booking.web.AirportCodeMapper"%>				
<%@ include file="inc-page-init.jsp" %>
<%
String msg = (String)request.getAttribute("msg");


String flightNumberParam    = request.getParameter("flightnumber");     
String weekNumberParam      = request.getParameter("weeknumber");    
String flyingFromParam      = request.getParameter("flyingfrom");    
String flyingToParam        = request.getParameter("flyingto");    
String departsParam         = request.getParameter("departs");  //(format: 2006/12/10 05:20)
String arrivesParam         = request.getParameter("arrives");    
String priceParam           = request.getParameter("price");    //integer number of pounds

String from  = request.getParameter("from");
String to = request.getParameter("to");
String city = request.getParameter("city");

String passengerFirstNameParam  = request.getParameter("passengerfirstname");
String passengerMiddleNameParam = request.getParameter("passengermiddlename");
String passengerLastNameParam   = request.getParameter("passengerlastname");
String passengerGenderParam     = request.getParameter("passengergender");

String cardTypeParam        = request.getParameter("cardtype");
String securityCodeParam    = request.getParameter("securityCode");
String cardHoldersNameParam = request.getParameter("cardholdersname");
String cardNumberParam      = request.getParameter("cardnumber");
String addressLine1Param    = request.getParameter("addressline1");
String addressLine2Param    = request.getParameter("addressline2");
String postcodeParam        = request.getParameter("postcode");

//Do some validation
String paramError = null;
if (flightNumberParam==null         || flightNumberParam.equals(""))       paramError = "Missing 'flightnumber' parameter";
if (weekNumberParam==null           || weekNumberParam.equals(""))         paramError = "Missing 'weeknumber' parameter";
if (flyingFromParam==null           || flyingFromParam.equals(""))         paramError = "Missing 'flyingfrom' parameter";
if (flyingToParam==null             || flyingToParam.equals(""))           paramError = "Missing 'flyingto' parameter";
if (departsParam==null              || departsParam.equals(""))            paramError = "Missing 'departs' parameter";
if (arrivesParam==null              || arrivesParam.equals(""))            paramError = "Missing 'arrives' parameter";
if (priceParam==null                || priceParam.equals(""))              paramError = "Missing 'price' parameter";

if (from == null) from = "";
if (to == null) to = "";
if (city == null) city = "";

if (passengerFirstNameParam==null   || passengerFirstNameParam.equals("")) paramError = "Missing 'passengerfirstname' parameter";
if (passengerMiddleNameParam==null) passengerMiddleNameParam="";
if (passengerLastNameParam==null    || passengerLastNameParam.equals(""))  paramError = "Missing 'passengerlastname' parameter";
if (passengerGenderParam==null      || passengerGenderParam.equals(""))    paramError = "Missing 'passengergender' parameter";

if (cardTypeParam==null             || cardTypeParam.equals(""))           paramError = "Missing 'cardtype' parameter";
if (securityCodeParam==null         || securityCodeParam.equals(""))       paramError = "Missing 'securityCode' parameter";
if (cardHoldersNameParam==null      || cardHoldersNameParam.equals(""))    paramError = "Missing 'cardholdersname' parameter";
if (cardNumberParam==null           || cardNumberParam.equals(""))         paramError = "Missing 'cardnumber' parameter";
if (addressLine1Param==null         || addressLine1Param.equals(""))       paramError = "Missing 'addressline1' parameter";
if (addressLine2Param==null) addressLine2Param="";                         
if (postcodeParam==null             || postcodeParam.equals(""))           paramError = "Missing 'postcode' parameter";

if (paramError!=null) {
    request.setAttribute("msg", paramError);
    RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
    dispatcher.forward(request, response);
    return;
}

List<Hotel> hotels = (List<Hotel>) session.getAttribute("hotels");
String selectedHotel = request.getParameter("selectedHotel");
Hotel hotelToBook = null;
if (hotels != null) {
    for(Hotel hotel : hotels)
    {
        if (hotel.getName().equals(selectedHotel)) {
	        hotelToBook = hotel;
			break;
	    }	
    }
}

if (hotelToBook != null) {
    String hotelFrom = request.getParameter("hotelFrom");   
    String hotelTo = request.getParameter("hotelTo");
    Person person = new Person(passengerFirstNameParam,passengerGenderParam,passengerLastNameParam,passengerMiddleNameParam);
    CardTypeDef cardType = CardTypeDef.fromString(cardTypeParam);
    Payment payment = new Payment(addressLine1Param,addressLine2Param,cardNumberParam,cardType,cardHoldersNameParam,postcodeParam,securityCodeParam);
	FindHotels finder = new FindHotels(hotelWSURL);		
	Booking hotelBookingResponse = finder.bookHotel(hotelToBook, hotelFrom, hotelTo, person, payment);
	System.out.println("HOTEL BOOKING: " + hotelBookingResponse.getMessage());
	session.setAttribute("hotelBookingResponse", hotelBookingResponse);
}


//Build JDOM document
System.out.println("Preparing bookFlightRequest");
Element bookFlightRequestElement = new Element("bookFlightRequest");

Element flightNumberElement = new Element("flightNumber");
flightNumberElement.setText(flightNumberParam);
bookFlightRequestElement.addContent(flightNumberElement);

Element weekNumberElement = new Element("weekNumber");
weekNumberElement.setText(weekNumberParam);
bookFlightRequestElement.addContent(weekNumberElement);

Element priceElement = new Element("price");
priceElement.setText(priceParam);
bookFlightRequestElement.addContent(priceElement);



Element passengerFirstNameElement = new Element("passengerFirstName");
passengerFirstNameElement.setText(passengerFirstNameParam);
bookFlightRequestElement.addContent(passengerFirstNameElement);

Element passengerMiddleNameElement = new Element("passengerMiddleName");
passengerMiddleNameElement.setText(passengerMiddleNameParam);
bookFlightRequestElement.addContent(passengerMiddleNameElement);

Element passengerLastNameElement = new Element("passengerLastName");
passengerLastNameElement.setText(passengerLastNameParam);
bookFlightRequestElement.addContent(passengerLastNameElement);

Element passengerGenderElement = new Element("passengerGender");
passengerGenderElement.setText(passengerGenderParam);
bookFlightRequestElement.addContent(passengerGenderElement);


Element cardTypeElement = new Element("cardType");
cardTypeElement.setText(cardTypeParam);
bookFlightRequestElement.addContent(cardTypeElement);

Element cardNumberElement = new Element("cardNumber");
cardNumberElement.setText(cardNumberParam);
bookFlightRequestElement.addContent(cardNumberElement);

Element securityCodeElement = new Element("cardSecurityCode");
securityCodeElement.setText(securityCodeParam);
bookFlightRequestElement.addContent(securityCodeElement);


Element cardHoldersNameElement = new Element("cardHoldersName");
cardHoldersNameElement.setText(cardHoldersNameParam);
bookFlightRequestElement.addContent(cardHoldersNameElement);

Element addressLine1Element = new Element("addressLine1");
addressLine1Element.setText(addressLine1Param);
bookFlightRequestElement.addContent(addressLine1Element);

Element addressLine2Element = new Element("addressLine2");
addressLine2Element.setText(addressLine2Param);
bookFlightRequestElement.addContent(addressLine2Element);

Element postcodeElement = new Element("postcode");
postcodeElement.setText(postcodeParam);
bookFlightRequestElement.addContent(postcodeElement);


String requestXMLdata = xmlOutputter.outputString(bookFlightRequestElement);
String requestXMLforServer = xslTransformer.transform("BookFlightRequest.xsl", requestXMLdata);

System.out.println("bookFlightRequest XML:");
System.out.println(requestXMLforServer);

//Do the JMS request
String xmlResponse = "";
JMSManager theJMSmanager = JMSManager.getInstance();
synchronized (theJMSmanager) {
	try {
		String queueName = "vbooking.request.passenger.booking";
		if (theJMSmanager.getRequestQueueName()==null ||
		    !theJMSmanager.getRequestQueueName().equals(queueName)) {
			//Make sure the correct queue name is set in the JMSManager singleton
			theJMSmanager.initQueueSession(queueName);
		}
		
		xmlResponse = theJMSmanager.doJMSrequest(requestXMLforServer); //Fire JMS Request!
	} catch (NullPointerException e) {
		throw new Exception("An error occurred configuring JMS. This typically happens when the Websphere MQ service is not running, please check your Websphere MQ installation is configured correctly and running."); 
		
	} catch (JMSManagerException e) { // likely a time out
		String error_message = e.getMessage();
		if (error_message.equals("JMS initialisation error")) {
			throw new Exception(error_message + ". Typically occurs when Websphere MQ is not running or configured incorrectly. Please check Websphere MQ is running and the queues configured correctly.");
		} else if (error_message.equals("JMS timeout error")) {
			throw new Exception(error_message + ". Typically occurs when queue messages are not being processed. Please check the queue messages are being processed and WebSphere Application Server is configured correctly and running."); 
		} else {
			throw new Exception(error_message + ". Please check queue messages are being processed and the WebSphere Application Server is configured correctly and running."); 
		}		 
	} catch (Exception e) {
		StringWriter e_errors = new StringWriter();
		e.printStackTrace(new PrintWriter(e_errors));

		throw new Exception("An unexpected error occurred contacting the message queue, please check your Websphere MQ configuration.\n" 
			+ String.format("Excpetion: %s\n", e.getMessage()));
	}
    System.out.println(xmlResponse);
}
if (!xmlResponse.isEmpty()) {// there is a response
	//Process the response XML
	String xmlCleanedResponse = xslTransformer.transform("StripNamespaces.xsl", xmlResponse);
	 
	Document responseDocument = JDOMUtils.parseToJDOMdoc(xmlCleanedResponse);
	
	//Look at the response status
	String status = JDOMUtils.getDataField(responseDocument, "/bookFlightResponse/status", request, response).trim();
	        
	if (status.startsWith("SUCCESS")) {
	    String reservationNumber = JDOMUtils.getDataField(responseDocument, "/bookFlightResponse/newReservationNumber", request, response);
		
	    RequestDispatcher dispatcher = request.getRequestDispatcher("booking-made.jsp?reservationnumber=" + reservationNumber + "&destination=" + flyingToParam + "&from=" + from + "&to=" + to + "&city=" + city);
	    dispatcher.forward(request, response);
	    
	} else if (status.startsWith("ERROR")) {
	    String errorMessage = JDOMUtils.getDataField(responseDocument, "/bookFlightResponse/message", request, response);
	    throw new Exception(errorMessage);
	    
	} else if (status.startsWith("TEST")) {
	    %><link rel="stylesheet" type="text/css" href="style.css" ><h1>TEST RESPONSE</h1>
		  <PRE><%=org.apache.commons.lang.StringEscapeUtils.escapeHtml(xmlCleanedResponse)%></PRE><%
		  
	} else {
		throw new Exception("Invalid response status value '" + status + "'");
	}
}
%>