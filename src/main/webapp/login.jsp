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
<img src="hotel.jpg" alt="Flowers in Chania">


	<form action="login" method="post" class="center">
		<label for="email"><b>Email</b></label>
		<input type="text" name="email"><br>
		
		<label for="password"><b>Password</b></label>
		<input type="password" name="password"><br>
		<button type="submit" >Log in</button>
	</form>

	<p><%if (session.getAttribute("email")!= null && session.getAttribute("email").toString().equals("wrong")){
		out.println("Either username or password is wrong. Try again!");
	}%></p>

<h2>No account?<br>You can <a href="signup.jsp">Sign up</a> right now!!!</h2>

</body>
</html>