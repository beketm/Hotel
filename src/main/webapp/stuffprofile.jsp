<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import ="hotel.com.LoginDao" import="java.util.*,java.lang.*" %>
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
    			$("#links").append("<a href=\"stufflogin.jsp\" >Login</a>");
    			$("#links").append("<a href=\"stuffsignup.jsp\" >Sign up</a>");
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
			console.log("11");
    		$.ajax({
    		    url: "book1",
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
    	    		console.log("22");
    	    		var position = '${position}';
    	    		console.log(position);
    	    		if (true){
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

    	    			    if (city.toLowerCase() != $("#city").val()){
    	    			    	continue;
    	    			    }
    	    			    
    	    			    $("table").append("<tr>"
	    	    			    	+"<td class=\"roomimg\"><img src=\""+image+"\" alt=\"\" height=200 width=300></td>"
	    	    			    	+"<td class=\"roomdesc\">City: "+city+"<br>"
	    	    			    	+"Name: "+data_arr[14]+"<br>"
	    	    			    	+"Last name: "+ data_arr[15] +"<br>"
	    	    			    	+"Room number: "+room_number+"<br>"
	    	    			    	+"Floor: "+floor+"<br>"
	    	    			    	+"Type: "+data_arr[23]+"<br>"
	    	    			    	+"Area: "+data_arr[24]+" &#13217"+"<br>"
	    	    			    	+"Price: "+calculate_price(data_arr[10],data_arr[11],data_arr[2])+" &#36 "+"<br>"
	    	    			    	+"</td>"
	    	    			    	+"<td><button hotel_id=\""+hotel_id+"\" room_number=\""+room_number+"\" type=\"submit\" class=\"bookroom\">Delete this booking</button></td>"
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
	    			    	    url: "stufflogin",
	    			    	    dataType: 'JSON',
	    			    	    type: 'GET',
	    			    	    fail: function(){
	    			    	        alert("Failed to recieve a response");
	    			    	},
	    			    	    success: function(data){ 
	    			        		console.log(data);
	    			        		if (data.result){
										
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
	    		    			    				
	    		    			    			$("button[hotel_id='"+hotel_id+"'][room_number='"+room_number+"']").parents("tr").remove();
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
	<a href="stufflogin.jsp" >Staff</a>
</div>

<%! LoginDao dao = new LoginDao();%>
<% 	List<String> data = dao.get_stuff(session.getAttribute("email").toString());
	String position = data.get(2);
%>

<h1><i> Nguyen's Palace</i> Hotel!</h1>
<h1> Welcome back, <%= data.get(0)%>!</h1>

<div class="portfolio">
	<img class="face" src="face.png" style="width: 25%; height: 25%; float: left; margin-left: 10%;">
	
	<p style="text-align: left; margin-left: 40%;">Name: <%= data.get(0)+" "+data.get(1) %></p>
	<p style="text-align: left; margin-left: 40%;">Position: <%= position.substring(0, 1).toUpperCase() + position.substring(1) %></p>
	<p style="text-align: left; margin-left: 40%;">Hotel: <%= (data.get(3)=="2") ? "Almaty" : "Nursultan"%></p>
</div>

<p><%= session.getAttribute("position") %></p>

<form  id="form">
  <div class="container">
    <h1>Find the best hotel rooms</h1>
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

</body>
</html>