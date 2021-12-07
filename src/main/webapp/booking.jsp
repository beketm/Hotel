<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script type="text/javascript">
function restrict_date(){
    var dtToday = new Date();
    
    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();
    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();
    
    var maxDate = year + '-' + month + '-' + day;

    $('#checkin').attr('min', maxDate);
    
    $('#checkin').focusout(function(){
    	var dtToday = new Date();
		if ($('#checkin').val()){
			dtToday = new Date($('#checkin').val());
			}
	    
	    var month = dtToday.getMonth() + 1;
	    var day = dtToday.getDate()+1;
	    var year = dtToday.getFullYear();
	    if(month < 10)
	        month = '0' + month.toString();
	    if(day < 10)
	        day = '0' + day.toString();
	    
	    var maxDate = year + '-' + month + '-' + day;

	    $('#checkout').attr('min', maxDate);
		})
}


$(document).ready(function() { 
	console.log("HIIIII");
	restrict_date();

	
	
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
	
    $(".searchbtn").click(function(){
    	if ($("*[required]").filter(function () {
    	    return $.trim($(this).val()).length == 0
    	}).length != 0){
    		alert("Some fields are empty!");
    	}else {
    		
    		var data = $("#form").serialize()+"&checkin="+$("#checkin").val().toString()+"&checkout="+$("#checkout").val().toString();
			var past_data = null;
    		$.ajax({
    		    url: "book",
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
    	    			    var floor = data_arr[3];
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
	    	    			    	+"<td class=\"roomdesc\">City: "+city+"<br>"
	    	    			    	+"Room number: "+room_number+"<br>"
	    	    			    	+"Floor: "+floor+"<br>"
	    	    			    	+"Type: "+data_arr[6]+"<br>"
	    	    			    	+"Area: "+data_arr[7]+" &#13217"+"<br>"
	    	    			    	+"</td>"
	    	    			    	+"<td><button hotel_id=\""+hotel_id+"\" room_number=\""+room_number+"\" type=\"submit\" class=\"bookroom\">Book this room</button></td>"
	    	    			    +"</tr>");
    	    			    
    	    			}
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
	    			        		if (data.result){
										
	    			        			$.ajax({
	    			        				url: "makebooking",
	    			        				data:  (email + "&" + hotel_id + "&" + room_number + "&" + checkin + "&" + checkout),
	    			        				dataType: "JSON",
	    			        				type: "POST",
	    			        				fail: function(){
	    		    			    	        alert("Failed to recieve a response");
	    		    			    	},
	    		    			    		success: function(data){
	    		    			    			console.log(data);
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
    		
    	past_data = $("#form").serialize()+"&checkin="+$("#checkin").val().toString()+"&checkout="+$("#checkout").val().toString();

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
    

    <select id="city" name="city" placeholder="City" required>
    <option value="" disabled selected>Select City</option>
	  <option value="nursultan">Nursultan</option>
	  <option value="almaty">Almaty</option>
  </select>
    

    <input placeholder="Select Check-in" class="checkin" type="text" onfocus="(this.type='date')" id="checkin" required>
    

    <input placeholder="Select Check-out" class="checkout" type="text" onfocus="(this.type='date')" id="checkout" required>
    

    <select id="room_type" name="room_type" required>
    <option value="" disabled selected>Select Room Type</option>
	  <option value="single">Single</option>
	  <option value="double">Double</option>
  	</select>
  	

    <select id="number_people" name="number_people" required>
	  <option value="" disabled selected>Select Number of People</option>
	  <option value="1">1</option>
	  <option value="2">2</option>
	  <option value="3">3</option>
	  <option value="4">4</option>
	  <option value="5">5</option>
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
<%if (session.getAttribute("email") == null){
	out.println("  <div class=\"container signin\"><p>Already have an account? <a href=\"login.jsp\">Log in</a>.</p></div>");
} %>

</body>
</html>