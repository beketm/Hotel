<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript">

function check_password() {
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
        		  )) {
        	$("#note").text("Email is invalid!");
        } else if (email.split('@')[1] != "np.kz") {
       		$("#note").text("Email is invalid! Write your work email!");
        }
        else {
        	$("#note").text("");
        }
    });
}

$(document).ready(function() { 
	console.log("HIIIII");
	
 	$("#form").submit(function(e){
	    return false;
	}); 
    
    check_password();
    
    $(".registerbtn2").click(function(){
    	if ($("input").filter(function () {
    	    return $.trim($(this).val()).length == 0
    	}).length != 0){
    		alert("Some fields are empty!");
    	}else if ($("#note").text()==""){
    		
    		$.ajax({
    	        url: "stuffsignup",
    	        data: $( "#form" ).serialize(),
    	        dataType: 'JSON',
    	        type: 'POST',
    	        cache: false,
    	        timeout: 30000,
    	        fail: function(){
    	            alert("Failed to recieve a response");
    	        },
    	        success: function(data){ 
        			console.log(data);

        			if (data.result){
        				alert("You succesfully signed up!");
        				window.location.href = 'stufflogin.jsp';
        			}else{
        				alert("This email is already used!");
        				window.location.href = 'stuffsignup.jsp';
        			}
    	        }
    	    });
    		
    		

    	}
    });
    
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
    			$("#links").append("<a href=\"stufflogin.jsp\" >Login</a>");

    		}
	    }
    });
    
});

</script>
<head>
<meta charset="ISO-8859-1">
<title>Staff sign up</title>
<link rel="stylesheet" href="/Hotel/main.css" type="text/css">
</head>
<body>
<div id="links">
	<a href="home.jsp" >Homepage</a> 
</div>



<h1><i> Nguyen's Palace</i><br> Where dreams come true!</h1>
<img src="hotel.jpg" alt="Flowers in Chania" class="main">

<form  id="form">
  <div class="container">
    <h1>Register</h1>
    <p>Please fill in this form to create an account.</p>
    <hr>
    
	<label for="fname"><b>First Name</b></label>
    <input type="text" placeholder="Enter First Name" name="fname" id="fname" required><br>
    
    <label for="lname"><b>Last Name</b></label>
    <input type="text" placeholder="Enter Last Name" name="lname" id="lname" required><br>
    
    <label for="position"><b>Position</b></label>
    <select id="position" name="position" required>
	<option value="" disabled selected>Select Your Position</option>
	  <option value="manager">Manager</option>
	  <option value="clerk">Clerk</option>
	  <option value="cleaner">Cleaner</option>
	</select><br>
    
    <label for="hotel"><b>Hotel</b></label>
    <select id="hotel" name="hotel" required>
	<option value="" disabled selected>Select City</option>
	  <option value="nursultan">Nursultan</option>
	  <option value="almaty">Almaty</option>
	</select><br>
    
    <label for="email"><b>Work Email</b></label>
    <input type="text" placeholder="Enter Email" name="email" id="email" required><br>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" id="psw" required><br>

    <label for="psw-repeat"><b>Repeat Password</b></label>
    <input type="password" placeholder="Repeat Password" name="psw-repeat" id="psw-repeat" required><br>
    
    <p id="note"></p>
    <hr>

    <button type="submit" class="registerbtn2">Sign up</button>
  </div>

  <div class="container signin">
    <p>Already have an account? <a href="stufflogin.jsp">Log in</a>.</p>
  </div>
</form>

</body>
</html>