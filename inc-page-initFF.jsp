<%-- Vacation Booking demo --%>
<%@page errorPage="errorFF.jsp" %>
<%@page import="java.util.*,
                org.jdom.*,
                org.jdom.output.XMLOutputter,
                org.jdom.output.Format,
                java.io.IOException,com.vbooking.util.*"%>
<%--
  Initialisation to be included at the top of every page
--%>
<%!

Exception initialisationException = null;
XSLTransformer xslTransformer = null;
XMLOutputter xmlOutputter = null;
String hotelWSURL = null;
String hotelWSwsdlURL = null;
String currencyWSURL = null;
String currencyWSwsdlURL = null;

public void jspInit() {

		
	ServletContext servletConfig = getServletContext();
	
	//Load some config parameters from web.xml
	String jmsUserName               = servletConfig.getInitParameter("jmsUserName");
	String jmsPassword               = servletConfig.getInitParameter("jmsPassword");
	hotelWSURL                		 = servletConfig.getInitParameter("hotelsWSURL");
	hotelWSwsdlURL                	 = servletConfig.getInitParameter("hotelsWSwsdlURL");
	currencyWSURL					 = servletConfig.getInitParameter("currencyWSURL");
	currencyWSwsdlURL					 = servletConfig.getInitParameter("currencyWSwsdlURL");
	
	if (jmsUserName==null)               throw new RuntimeException("Parameter jmsUserName is null. Should be defined in WEB-INF/web.xml");
	if (jmsPassword==null)               throw new RuntimeException("Parameter jmsPassword is null. Should be defined in WEB-INF/web.xml");
	if (hotelWSURL==null)                throw new RuntimeException("Parameter hotelsWSURL is null. Should be defined in WEB-INF/web.xml");
	if (hotelWSwsdlURL==null)            throw new RuntimeException("Parameter hotelsWSwsdlURL is null. Should be defined in WEB-INF/web.xml");
	if (currencyWSURL==null)                throw new RuntimeException("Parameter hotelsWSURL is null. Should be defined in WEB-INF/web.xml");
	if (hotelWSwsdlURL==null)            throw new RuntimeException("Parameter hotelsWSwsdlURL is null. Should be defined in WEB-INF/web.xml");
	
	try {
		JMSManager.getInstance().init(jmsUserName,
						              jmsPassword); 
		
	} catch (JMSManagerException jme) {
	    jme.printStackTrace();
	    initialisationException = new Exception(jme);
	}
	String xsltPath = getServletContext().getRealPath("/WEB-INF/xsl/");
	xslTransformer = new XSLTransformer(xsltPath);

	xmlOutputter = new XMLOutputter(Format.getPrettyFormat());

}

//end of declaration block
 
%>
<%
if (initialisationException!=null) jspInit(); //Error happened before. Try initialising again.
%>