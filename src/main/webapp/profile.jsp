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


	$.ajax({
	    url: "book",
	    data: {time: "future"},
	    dataType: 'JSON',
	    method: "GET",
	    fail: function(){
	        alert("Failed to recieve a response");
	},
	    success: function(data){ 
    		console.log(data);
    			$("#table2").empty();
    			if (Object.keys(data).length !== 0){
    			for (const [key, value] of Object.entries(data)) {
    			    
    			    var data_arr = value.split(", ");
    			    var hotel_id = data_arr[0];
    			    var room_number = data_arr[1];
    			    var city = null;
    			    var floor = data_arr[3];
    			    var checkout = data_arr[10];
    			    var checkin = data_arr[11];
    			    var image = null;
    			    if (hotel_id=="1"){
    			    	city = "Nursultan";
    			    	image = "room_nur.jpg"
    			    }else{
    			    	city = "Almaty";
    			    	image = "room_alm.jpg"
    			    }
    			    console.log(key, " ", city);
    			    
    			    $("#table2").append("<tr>"
	    			    	+"<td class=\"roomimg\"><img src=\""+image+"\" alt=\"\" height=200 width=300></td>"
	    			    	+"<td class=\"roomdesc\">City: "+city+"<br>"
	    			    	+"Room number: "+room_number+"<br>"
	    			    	+"Floor: "+floor+"<br>"
	    			    	+"Type: "+data_arr[6]+"<br>"
	    			    	+"Area: "+data_arr[7]+" &#13217"+"<br>"
	    			    	+"</td>"
	    			    	+"<td>Check-in: "+checkin+"<br>"
	    			    	+"Check-out: "+checkout+"</td>"
	    			    +"</tr>");
    			    
    			} 	
    			}else{
    				$("#table2").after("<p>No bookings</p>")
    			}
    		
	    }
    });
	
	$.ajax({
	    url: "book",
	    data: {time: "history"},
	    dataType: 'JSON',
	    method: "GET",
	    fail: function(){
	        alert("Failed to recieve a response");
	},
	    success: function(data){ 
    		console.log(data);
    			$("#table1").empty();
    			console.log(data);
    			if (Object.keys(data).length !== 0){
    			for (const [key, value] of Object.entries(data)) {
    			    
    			    var data_arr = value.split(", ");
    			    var hotel_id = data_arr[0];
    			    var room_number = data_arr[1];
    			    var city = null;
    			    var floor = data_arr[3];
    			    var checkout = data_arr[10];
    			    var checkin = data_arr[11];
    			    var image = null;
    			    if (hotel_id=="1"){
    			    	city = "Nursultan";
    			    	image = "room_nur.jpg"
    			    }else{
    			    	city = "Almaty";
    			    	image = "room_alm.jpg"
    			    }
    			    console.log(key, " ", city);
    			    
    			    $("#table1").append("<tr>"
	    			    	+"<td class=\"roomimg\"><img src=\""+image+"\" alt=\"\" height=200 width=300></td>"
	    			    	+"<td class=\"roomdesc\">City: "+city+"<br>"
	    			    	+"Room number: "+room_number+"<br>"
	    			    	+"Floor: "+floor+"<br>"
	    			    	+"Type: "+data_arr[6]+"<br>"
	    			    	+"Area: "+data_arr[7]+" &#13217"+"<br>"
	    			    	+"</td>"
	    			    	+"<td>Check-in: "+checkin+"<br>"
	    			    	+"Check-out: "+checkout+"</td>"
	    			    +"</tr>");
    			    
    			} 	
    			}else{
    				$("#table1").after("<p>No bookings</p>")
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
<br><br><br><br><br><br><br><br>

<h3>My Booking History</h3>
<table id="table1">
	<tr>
    	<th></th>
    	<th></th>
    	<th></th>
    </tr>
</table>

<h3>My Future Bookings</h3>
<table id="table2">
	<tr>
    	<th></th>
    	<th></th>
    	<th></th>
    </tr>
</table>



</body>
</html>