function calculate_price(checkin, checkout, room_type){
    var price = 0;
    checkin = new Date(checkin);
    checkout = new Date(checkout);
    while(checkout>checkin){
       let d = checkin.getDay();
       if (d == 0){
           price = price + 300;
       }
       else if (d == 6){
           price = price + 200;
       }
       else{
           price = price + 100;
       }
       let a = checkin.getDate();
       a = a + 1;
       checkin.setDate(a);
   }
     if(room_type === "1"){
         return price;
       }
     else{
          return price*2;
       }
}

function output_cleark_html(){
	$("#position_output").append("" + 
			"<form  id=\"form\">" + 
			"  <div class=\"container\">" + 
			"    <br><br><br><br><br><br><br><br><h2>Upcoming bookings</h2>" + 
			"    <hr>" + 
			"        <select id=\"city\" name=\"city\" placeholder=\"City\" required>" + 
			"    <option value=\"\" disabled selected>Select City</option>" + 
			"	  <option value=\"nursultan\">Nursultan</option>" + 
			"	  <option value=\"almaty\">Almaty</option>" + 
			"  </select>" + 
			"      <p id=\"note\"></p>" + 
			"    <hr>" + 
			"        <button type=\"submit\" class=\"searchbtn\">Search</button>" + 
			"  </div>" + 
			"  </form>" + 
			"<table>" + 
			"	<tr>" + 
			"    	<th></th>" + 
			"    	<th></th>" + 
			"    	<th></th>" + 
			"    </tr>" + 
			"</table>" + 
			"");
		
			$("#form").submit(function(e){
	    return false;
	});
			
	    $(".searchbtn").click(function(){
    	if ($("*[required]").filter(function () {
    	    return $.trim($(this).val()).length == 0
    	}).length != 0){
    		alert("Some fields are empty!");
    	}else {
    		
//fetching booked rooms
    		var data = $("#form").serialize();

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
    	    		if (data){
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
	    	    			    	+"<td><button hotel_id=\""+hotel_id+"\" room_number=\""+room_number+"\" type=\"submit\" class=\"bookroom\">Cancel this booking</button></td>"
	    	    			    +"</tr>");
    	    			    
    	    			}
	    			    $(".bookroom").click(function(){
	    			    	var hotel_id = $(this).attr("hotel_id");
	    			    	var room_number = $(this).attr("room_number");

	    			    	
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
	    		    			    			alert("You succesfully canceled booking!");
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
}

function output_cleaner_html(){
	$("#position_output").append("" + 
"<form  id=\"form\">" + 
"  <div class=\"container\">" + 
"    <br><br><br><br><br><br><br><h1>Select rooms</h1>" + 
"    <hr>" + 
"    " + 
"" + 
"    <select id=\"city\" name=\"city\" placeholder=\"City\" required>" + 
"    <option value=\"\" disabled selected>Select City</option>" + 
"	  <option value=\"nursultan\">Nursultan</option>" + 
"	  <option value=\"almaty\">Almaty</option>" + 
"  </select>" + 
"    " + 
"  	" + 
"" + 
"    " + 
"    <p id=\"note\"></p>" + 
"    <hr>" + 
"" + 
"    <button type=\"submit\" class=\"searchbtn\">Search</button>" + 
"  </div>" + 
"" + 
"" + 
"</form>" + 
"<table>" + 
"	<tr>" + 
"    	<th></th>" + 
"    	<th></th>" + 
"    	<th></th>" + 
"    </tr>" + 
"</table>" + 
"<br>" + 
"<br>" + 
"<div id=\"submit_button_area\"></div>" + 
"");

$("#form").submit(function(e){
	    return false;
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
							if (city.toLowerCase() != $("#city").val()){
    	    			    	continue;
    	    			    }
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
						$("#submit_button_area").empty();
    	    			$("#submit_button_area").append("<button type=\"submit\" class=\"submitbtn\">Submit</button>");
    	    			$(".submitbtn").click(function(){
    	    		    	alert("Successful submit!");
    	    		    });
	    	    		
    	    		}
    		    }
    	    });
    		
    	past_data = $("#form").serialize();

    	}
    });
}

function output_manager_html(){
	$("#position_output").append("" + 
"<br><br><br><br><br><br><br><br>" + 
"<button class=\"searchbtn\">Search</button>" + 
"<table>" + 
"	<tr>" + 
"    	<th></th>" + 
"    	<th></th>" + 
"    	<th></th>" + 
"    </tr>" + 
"</table>" + 
"");

$("#form").submit(function(e){
	    return false;
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
						var i = 0;
    	    			for (const [key, value] of Object.entries(data)) {
    	    				console.log("12345");
    	    			    var data_arr = value.split(", ");

    	    			    
    	    			    $("table").append("<br><br><tr>"
    	    			    		+"<td>"
	    	    			    	+"Name: "+data_arr[0]+"<br>"
	    	    			    	+"Last name: "+ data_arr[1] +"<br>"
	    	    			    	+"Last name: "+ data_arr[2] +"<br>"
	    	    			    	+"</td>"
	    	    			    	+"<td><button id=\"button_"+i+"\" type=\"submit\" class=\"bookroom\">Pay salary</button></td>"
	    	    			    +"</tr>");
							i = i + 1;
    	    			    
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
										console.log($(this));
										$("#button_0").attr('disabled' , true);
										
										$("#button_0").html("Paid");
										
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
};

function print_html_based_on_position(){
	var position = $("#position").text();
	console.log(position);
	if (position=="clerk"){
		output_cleark_html();
	}else if(position=="cleaner"){
		output_cleaner_html();
	} else{
		output_manager_html();
	}
}

$(document).ready(function() { 
	console.log("HIIIII");
	print_html_based_on_position();
	
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
	
});