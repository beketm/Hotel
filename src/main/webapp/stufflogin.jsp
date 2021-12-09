<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript">

$(document).ready(function() { 
	console.log("HIIIII");
	
	$.ajax({
	    url: "stufflogin",
	    dataType: 'JSON',
	    type: 'GET',
	    fail: function(){
	        alert("Failed to recieve a response");
	},
	    success: function(data){ 
    		console.log(data);
    		if (data.result){
    			$("#links").append("<a href=\"stuffprofile.jsp\" >My Profile</a>");
    			$("#links").append("<a href=\"logout\" >Log out</a>");
    			

    		}else{
//    			$("#links").append("<a href=\"stufflogin.jsp\" >Login</a>");
    			$("#links").append("<a href=\"stuffsignup.jsp\" >Sign Up As a Staff</a>");

    		}
	    }
    });
    
});  		
 
    		
</script>
<head>
<meta charset="ISO-8859-1">
<title>Stuff Page</title>
<link rel="stylesheet" href="/Hotel/main.css" type="text/css">
</head>
<body>
<div id="links">
	<a href="home.jsp" >Homepage</a> 
</div>



<h1><i> Welcome to Staff Portal!</i></h1>
<%-- <p><%= session.getAttribute("email")%></p>> --%>
<img src="hotel_staff.jpg" alt="Flowers in Chania" class="main">


	<form action="stufflogin" method="post" class="center">
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
    <p>No account?<br>You can <a href="stuffsignup.jsp">Sign up</a> right now!</p>
</div>

</body>
</html>