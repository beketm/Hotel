<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript">

function check_password(){
    $('#psw-repeat').focusout(function(){
        var pass = $('#psw').val();
        var pass2 = $('#psw-repeat').val();
		
        if(pass != pass2){
        	$("#note").text("Passwords do not match!");
        }else{
        	$("#note").text("");
        }

    });
    $('#email').focusout(function(){
        var email = $("#email").val()
        
        if (!email.match(
        	    /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        		  )){
        	$("#note").text("Email is invalid!");
        }else{
        	$("#note").text("");
        }
       
    });
	

}

$(document).ready(function() { 
	console.log("HIIIII");


	
	$("#form").submit(function(e){
	    return false;
	});
    
    
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



<h1><i> Nguyen's Palace</i> Hotel!</h1>
<img src="hotel.jpg" alt="Flowers in Chania" class="main">

<form  id="form">
  <div class="container">
    <h1>Find the best hotel rooms</h1>
    <hr>
    

    <select id="city" name="city" placeholder="City">
    <option value="" disabled selected>Select City</option>
	  <option value="nursultan">Nursultan</option>
	  <option value="almaty">Almaty</option>
  </select>
    

    <input placeholder="Select Check-in" class="checkin" type="text" onfocus="(this.type='date')" id="checkin">
    

    <input placeholder="Select Check-out" class="checkout" type="text" onfocus="(this.type='date')" id="checkout">
    

    <select id="room_type" name="room_type">
    <option value="" disabled selected>Select Room Type</option>
	  <option value="single">Single</option>
	  <option value="double">Double</option>
  	</select>
  	

    <select id="number_people" name="number_people">
	  <option value="" disabled selected>Select Number of People</option>
	  <option value="1">1</option>
	  <option value="2">2</option>
	  <option value="3">3</option>
	  <option value="4">4</option>
	  <option value="5">5</option>
  	</select>
    
    <p id="note"></p>
    <hr>

    <button type="submit" class="registerbtn">Search</button>
  </div>

  <div class="container signin">
    <p>Already have an account? <a href="login.jsp">Log in</a>.</p>
  </div>
</form>

</body>
</html>