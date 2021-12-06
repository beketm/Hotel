<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
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



<h1><i> Nguyen's Palace</i> Hotel</h1>
<img src="hotel.jpg" alt="Flowers in Chania">

<p class="desc"><i>Nguyen's Palace</i> hotel is located on the territory of Expo-2017 in Astana and offers guests a restaurant, a rooftop bar with a view of the city.<br><br>All air-conditioned rooms feature a flat-screen TV, a minibar and a seating area. Some rooms have a separate seating area and access to the executive lounge, where complimentary drinks and snacks are offered to guests throughout the day. The private bathroom has a shower, hairdryer and slippers. Free toiletries are provided.<br><br>The <i>Nguyen's Palace</i> offers 24-hour room service. Other facilities include a business center and a 24-hour fitness room. The on-site health spa offers massages, beauty treatments, saunas and a Turkish bath.<br><br>Baiterek Monument is 2.7 km from <i>Nguyen's Palace</i> and Nazarbayev University is just 500 m away. The nearest airport is Astana International Airport, located 5.6 km from the <i>Nguyen's Palace</i>.<br><br>Couples especially like this place - they rated it at 9.2 when traveling as a couple.<br><br>We speak your language!<br><br>
Start by <a href="login.jsp">Logging in</a></p>


	<p><%if (session.getAttribute("uname")!= null && session.getAttribute("uname").toString().equals("wrong")){
		out.println("Either username or password is wrong. Try again!");
	}%></p>


</body>
</html>