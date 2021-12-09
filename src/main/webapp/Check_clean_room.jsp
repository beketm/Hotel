<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function() { 

	
	
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
    }
	);
	
	
	
    $(".searchbtn").click(function(){
    	
    	if ($("*[required]").filter(function () {
    	    return $.trim($(this).val()).length == 0
    	}).length != 0){
    		alert("Some fields are empty!");
    	}else {
    		
    		var data = $("#form").serialize();
			var past_data = null;
    		$.ajax({
    		    url: "clean",
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

    	    			    var data_arr = value.split(", ");
    	    			    var hotel_id = data_arr[0];
    	    			    var room_number = data_arr[1];
    	    			    var city = null;
    	    			    var image = null;
    	    			    if (hotel_id=="1"){
    	    			    	city = "Nursultan";
    	    			    	image = "room_nur.jpg"
    	    			    }else{
    	    			    	city = "Almaty";
    	    			    	image = "room_alm.jpg"
    	    			    }
    	    			    console.log(key, " ", city);
    	    			    $("table").append("<tr>"
    	    			    		+"<td class=\"roomimg\"><img src=\""+image+"\" alt=\"\" height=200 width=300></td>"
	    	    			    	+"<td>"
	    	    			    	+"City: "+city+"<br>"
	    	    			    	+"Room: "+data_arr[1]+"<br>"
	    	    			    	+"</td>"
	    	    			    	+"<td>"
	    	    			    	+"<input type=\"checkbox\">"
	    	    			    	+"</td>"
	    	    			    +"</tr>");
    	    			    
    	    			}
    	    			$("#submit_button_area").append("<button type=\"submit\" class=\"submitbtn\">Submit</button>");
    	    			$(".submitbtn").click(function(){
    	    		    	alert("Successful submit!");
    	    		    }

    	    			);
	    			    $(".bookroom").click(function(){
	    			    	var hotel_id = $(this).attr("hotel_id");
	    			    	var room_number = $(this).attr("room_number");
	    			    	var email = '${email}';
	    			    	var checkin = $("#form #checkin").val();
	    			    	var checkout = $("#form #checkout").val();
	    			    	var number_people = $("#form #number_people").val();
	    			    	
	    			    	console.log($(this).attr("hotel_id"));
	    			    	console.log($(this).attr("room_number"));
	    			    	
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
										
	    			        			$.ajax({
	    			        				url: "delete",
	    			        				data:  ("&"+hotel_id + "&" + room_number+ "&"),
	    			        				dataType: "JSON",
	    			        				type: "POST",
	    			        				fail: function(){
	    		    			    	        alert("Failed to recieve a response");
	    		    			    	},
	    		    			    		success: function(data){
	    		    			    			console.log(data);
	    		    			    			
	    		    			    			if (data.result){
	    		    			    				
	    		    			    			$("button[hotel_id='"+hotel_id+"'][room_number='"+room_number+"']").parents("tr").remove()
	    		    			    			alert("You succesfully deleted booking!");
	    		    			    			}else{
	    		    			    				alert("You already canceled this booking!");
	    		    			    			}
	    		    			    		}
	    			        			})
										

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
    		
    	past_data = $("#form").serialize();

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
    <h1>Select rooms</h1>
    <hr>
    

    <select id="city" name="city" placeholder="City" required>
    <option value="" disabled selected>Select City</option>
	  <option value="nursultan">Nursultan</option>
	  <option value="almaty">Almaty</option>
  </select>
    
  	

    
    <p id="note"></p>
    <hr>

    <button type="submit" class="searchbtn">Search</button>
  </div>


</form>
<table>
	<tr>
    	<th></th>
    	<th></th>
    	<th></th>
    </tr>
</table>
<br>
<br>
<div id="submit_button_area"></div>

</body>
</html>