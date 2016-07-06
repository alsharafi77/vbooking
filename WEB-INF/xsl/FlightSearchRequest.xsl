<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
   <ns0:flightSearchRequest xmlns:ns0="http://reservations.vbooking.com/schemas/FlightSearchRequest">
     <ns0:flightDate> <xsl:value-of select="//flightSearchRequest/flightDate" /> </ns0:flightDate>
     <ns0:flyingFrom> <xsl:value-of select="//flightSearchRequest/flyingFrom" /> </ns0:flyingFrom>
     <ns0:flyingTo>   <xsl:value-of select="//flightSearchRequest/flyingTo" />   </ns0:flyingTo>
   </ns0:flightSearchRequest>
</xsl:template>

</xsl:stylesheet>
