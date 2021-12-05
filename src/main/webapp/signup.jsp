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
    
    check_password();
    
    $(".registerbtn").click(function(){
    	if ($("input").filter(function () {
    	    return $.trim($(this).val()).length == 0
    	}).length != 0){
    		alert("Some fields are empty!");
    	}else if ($("#note").text()==""){
    		
    		$.post("signup", $( "#form" ).serialize(),function(data){
    			console.log(data);

    			if (data=="1"){
    				alert("You succesfully signed up!");
    				window.location.href = 'login.jsp';
    			}else{
    				alert("This email is already used!");
    			}
    		}, "text")
    			.done(function() {
    		    alert( "second success" );
    		  })
    		  .fail(function() {
    		    alert( "error" );
    		  })
    		  .always(function() {
    		    alert( "finished" );
    		  });

    	}
    })
    
});

</script>
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

<form id="form">
  <div class="container">
    <h1>Register</h1>
    <p>Please fill in this form to create an account.</p>
    <hr>
    
	<label for="fname"><b>First Name</b></label>
    <input type="text" placeholder="Enter First Name" name="fname" id="fname" required><br>
    
    <label for="lname"><b>Last Name</b></label>
    <input type="text" placeholder="Enter Last Name" name="lname" id="lname" required><br>
    
    <label for="passport_number"><b>National Passport Number</b></label>
    <input type="text" placeholder="Enter National Passport Number" name="passport_number" id="passport_number" required><br>
    
    <label for="address"><b>Address</b></label>
    <input type="text" placeholder="Enter Address" name="address" id="address" required><br>
    
    <label for="home_phone_number"><b>Home Phone number</b></label>
    <input type="text" placeholder="Enter Home Phone number" name="home_phone_number" id="home_phone_number" required><br>
    
    <label for="mobile_phone_number"><b>Mobile Phone number</b></label>
    <input type="text" placeholder="Enter Mobile Phone number" name="mobile_phone_number" id="mobile_phone_number" required><br>
    
    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Enter Email" name="email" id="email" required><br>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" id="psw" required><br>

    <label for="psw-repeat"><b>Repeat Password</b></label>
    <input type="password" placeholder="Repeat Password" name="psw-repeat" id="psw-repeat" required><br>
    
    <p id="note"></p>
    <hr>

    <button type="submit" class="registerbtn">Sign up</button>
  </div>

  <div class="container signin">
    <p>Already have an account? <a href="login.jsp">Log in</a>.</p>
  </div>
</form>


</body>
</html>