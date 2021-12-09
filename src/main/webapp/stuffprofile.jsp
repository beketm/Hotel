<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import ="hotel.com.LoginDao" import="java.util.*,java.lang.*" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script src="stuffprofile.js">
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

<p id="position" hidden><%= session.getAttribute("position") %></p>

<div id="position_output">
</div>



</body>
</html>