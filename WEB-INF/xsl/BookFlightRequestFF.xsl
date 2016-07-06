<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
   <ns0:bookFlightRequest xmlns:ns0="http://reservations.vbooking.com/schemas/BookFlightRequest">
     <ns0:flightNumber>        <xsl:value-of select="//bookFlightRequest/flightNumber" />        </ns0:flightNumber>
     <ns0:weekNumber>          <xsl:value-of select="//bookFlightRequest/weekNumber" />          </ns0:weekNumber>
     <ns0:price>               <xsl:value-of select="//bookFlightRequest/price" />               </ns0:price>
     <ns0:passengerFirstName>  <xsl:value-of select="//bookFlightRequest/passengerFirstName" />  </ns0:passengerFirstName>
     <ns0:passengerMiddleName> <xsl:value-of select="//bookFlightRequest/passengerMiddleName" /> </ns0:passengerMiddleName>
     <ns0:passengerLastName>   <xsl:value-of select="//bookFlightRequest/passengerLastName" />   </ns0:passengerLastName>
     <ns0:passengerGender>     <xsl:value-of select="//bookFlightRequest/passengerGender" />     </ns0:passengerGender>
     <ns0:frequentFlyer>       <xsl:value-of select="//bookFlightRequest/frequentFlyer" />     </ns0:frequentFlyer>
     
     <ns0:payment>
	     <payment:cardType xmlns:payment="http://reservations.vbooking.com/schemas/Payment">            <xsl:value-of select="//bookFlightRequest/cardType" />            </payment:cardType>
	     <payment:cardNumber xmlns:payment="http://reservations.vbooking.com/schemas/Payment">    	   <xsl:value-of select="//bookFlightRequest/cardNumber" />    		 </payment:cardNumber>
		 <payment:cardSecurityCode xmlns:payment="http://reservations.vbooking.com/schemas/Payment">    <xsl:value-of select="//bookFlightRequest/cardSecurityCode" />    </payment:cardSecurityCode>
	     <payment:cardHoldersName xmlns:payment="http://reservations.vbooking.com/schemas/Payment">     <xsl:value-of select="//bookFlightRequest/cardHoldersName" />     </payment:cardHoldersName>
	     <payment:addressLine1 xmlns:payment="http://reservations.vbooking.com/schemas/Payment">        <xsl:value-of select="//bookFlightRequest/addressLine1" />        </payment:addressLine1>
	     <payment:addressLine2 xmlns:payment="http://reservations.vbooking.com/schemas/Payment">        <xsl:value-of select="//bookFlightRequest/addressLine2" />        </payment:addressLine2>
	     <payment:postcode xmlns:payment="http://reservations.vbooking.com/schemas/Payment">            <xsl:value-of select="//bookFlightRequest/postcode" />            </payment:postcode>
	 </ns0:payment>
	     
   </ns0:bookFlightRequest>
</xsl:template>

</xsl:stylesheet>
