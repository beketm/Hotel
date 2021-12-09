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
    		if (true){
    			$("#links").append("<a href=\"profile.jsp\" >My Profile</a>");
    			$("#links").append("<a href=\"logout\" >Log out</a>");

    		}else{
    			$("#links").append("<a href=\"login.jsp\" >Login</a>");
    			$("#links").append("<a href=\"signup.jsp\" >Sign up</a>");
    		}
	    }
    });
	$(".searchbtn").click(function(){
    	if ($("*[required]").filter(function () {
    	    return $.trim($(this).val()).length == 0
    	}).length != 0){
    		alert("Some fields are empty!");
    	}else {
    		
    		var data = $("#form").serialize();
			var past_data = null;
    		$.ajax({
    		    url: "searchStuff",
    		    data: data,
    		    dataType: 'JSON',
    		    method: "POST",
    		    contentType: false,
    		    processData: false,
    		    fail: function(){
    		        alert("Failed to recieve a response");
    		},
    		    success: function(data){ 
    	    		console.log(data);
    	    		if (past_data!=data){
    	    			
    	    			$("table").empty();
    	    			for (const [key, value] of Object.entries(data)) {
    	    				console.log("12345");
    	    			    var data_arr = value.split(", ");

    	    			    
    	    			    $("table").append("<tr>"
    	    			    		+"<td>"
	    	    			    	+"Name: "+data_arr[0]+"<br>"
	    	    			    	+"Last name: "+ data_arr[1] +"<br>"
	    	    			    	+"Last name: "+ data_arr[2] +"<br>"
	    	    			    	+"</td>"
	    	    			    	+"<td><button type=\"submit\" class=\"bookroom\">Pay salary</button></td>"
	    	    			    +"</tr>");
    	    			    
    	    			}
	    			    $(".bookroom").click(function(){
	    			    	$.ajax({
	    			    	    url: "login",
	    			    	    dataType: 'JSON',
	    			    	    type: 'GET',
	    			    	    fail: function(){
	    			    	        alert("Failed to recieve a response");
	    			    	},
	    			    	    success: function(data){ 
	    			        		console.log(data);
	    			        		if (true){
	    			        			
	    			        			
										alert("Successfull salary payment!");
										$('button.bookroom[type="submit"]').attr('disabled' , true);
										
										$(".bookroom").html("Paid")
										
										//$(this).attr('disabled' , true);
										//$(this).html("Paid");
	    			        		}else{
										alert("You need to login first! Redirecting you to login page");
										window.location.href = 'login.jsp';
	    			        		}
	    			    	    }
	    			        }); 
	    		

	    			    });
	    	    		
    	    		}
    		    }
    	    });

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
	<a href="staff_home.jsp" >Staff</a>
</div>

<%! LoginDao dao = new LoginDao();%>
<% 	
List<String> data = dao.get_guest("aibat.09@gmail.com");
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
<br><br><br><br><br><br><br><br>
<button class="searchbtn">Search</button>

<table>
	<tr>
    	<th></th>
    	<th></th>
    	<th></th>
    </tr>
</table>
</body>
</html>