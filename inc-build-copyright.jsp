
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<% 
Properties properties = new Properties();
String build;
try {
  properties.load(application.getResourceAsStream("/META-INF/build.properties"));
  build = properties.getProperty("build.id");
  if (build.equals("${env.BUILD_ID}"))
  	build = "Development";
} catch (IOException e) {
  e.printStackTrace();
  build = "Development";
}
 %> 
Vacation Booking 8.7.0 - Build <%= build %> <br>
&copy; Copyright IBM Corporation 2001, 2015. 
