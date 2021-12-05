<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/Hotel/main.css" type="text/css">
</head>
<body>
<a href="rooms.html">Booking</a>
<a href="home.jsp" >Information</a> 
<a href="rooms.html" >Staff</a>
<a href="login.jsp" >Login</a> 
<a href="signup.jsp" >Sign up</a> 



<h1><i> Nguyen's Palace</i> Hotel!</h1>
<h1> Welcome back, <%= session.getAttribute("email")%>!</h1>
<img src="hotel.jpg" alt="Flowers in Chania">




<a href="signup.jsp"><center><input type="submit" value="Sign up"> </center></a>

</body>
</html>