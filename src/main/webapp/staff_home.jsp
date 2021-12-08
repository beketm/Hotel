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
    			$("#links").append("<a href=\"staf_login.jsp\" >Login</a>");
    			$("#links").append("<a href=\"staff_signup.jsp\" >Sign up</a>");
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
	<a href="booking.jsp">Booking</a>
	<a href="home.jsp" >Information</a> 
	<a href="staff_home.jsp" >Staff</a>
</div>




<h1><i> Nguyen's Palace</i> Hotel!</h1>
<h1>A Great Place to Work for All</h1>

<img src="hotel_staff.jpg" alt="Flowers in Chania" class="main">

<p class="desc"> Our passion for hospitality is the common thread that has tied our diverse team together around the world for more than 10 years.<br>
 In our rapidly expanding markets across Central Asia we are committed to creating a great work environment with meaningful opportunities for growth and benefits that help our Team Members all thrive at <i>Nguyen's Palace</i>.  
<br>Start by <a href="stufflogin.jsp">Logging in</a></p>


</body>
</html>