<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import ="hotel.com.LoginDao" import="java.util.*,java.lang.*" %>
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
	<a href="booking.jsp">Booking</a>
	<a href="home.jsp" >Information</a> 
	<a href="rooms.html" >Staff</a>
</div>

<%! LoginDao dao = new LoginDao();%>
<% 	List<String> data = dao.get_guest(session.getAttribute("email").toString());
%>

<h1><i> Nguyen's Palace</i> Hotel!</h1>
<h1> Welcome back, <%= data.get(0)%>!</h1>

<div class="portfolio">
	<img class="face" src="face.png" style="width: 25%; height: 25%; float: left; margin-left: 10%;">
	
	<p style="text-align: left; margin-left: 40%;">Name: <%= data.get(0)+" "+data.get(1) %></p>
	<p style="text-align: left; margin-left: 40%;">Passport Number: <%= data.get(2)%></p>
	<p style="text-align: left; margin-left: 40%;">Address: <%= data.get(3)%></p>
	<p style="text-align: left; margin-left: 40%;">Phone Number: <%= data.get(4)%></p>
</div>



</body>
</html>