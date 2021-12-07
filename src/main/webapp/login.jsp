<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript">

$(document).ready(function() { 
	console.log("HIIIII");
	
	$.ajax({
	    url: "login",
	    dataType: 'JSON',
	    type: 'GET',
	    fail: function(){
	        alert("Failed to recieve a response");
	},
	    success: function(data){ 
    		console.log(data);
    		if (data.result){
    			$("#links").append("<a href=\"profile.jsp\" >My Profile</a>");
    			$("#links").append("<a href=\"logout\" >Log out</a>");
    			

    		}else{
    			$("#links").append("<a href=\"login.jsp\" >Login</a>");
    			$("#links").append("<a href=\"signup.jsp\" >Sign up</a>");

    		}
	    }
    });
    
});  		
 
    		
</script>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/Hotel/main.css" type="text/css">
</head>
<body>
<div id="links">
	<a href="rooms.html">Booking</a>
	<a href="home.jsp" >Information</a> 
	<a href="rooms.html" >Staff</a>
</div>



<h1><i> Nguyen's Palace</i> Hotel!</h1>
<img src="hotel.jpg" alt="Flowers in Chania" class="main">


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
  
<div class="container signin">
    <p>No account?<br>You can <a href="signup.jsp">Sign up</a> right now!</p>
</div>

</body>
</html>