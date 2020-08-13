<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Home</title>
		<link rel="stylesheet" type="text/css" href="CSS/Style.css" /> 
		<link rel="scortcut icon" type="image/png" sizes="16x16" href="Images/favicon-16x16.png">
	</head>
	<body>
		<% if(session.getAttribute("login")==null || session.getAttribute("login")==" ") { response.sendRedirect("index.jsp"); } %>
	
	<!-- Navigation	-->
	<div class="navbar">
		<a href="Home.jsp">Home</a>
		<a href="Search.jsp"">Search</a> 
		<a href="MakeDate.jsp"">Plan Date</a> 
		<a href="SentDate.jsp"">Sent Dates</a>
		<a href="ReceivedDate.jsp"">Received Dates</a>
		<a href="Profile.jsp">Profile</a> 
		<a href="Report.html">Report</a> 
		<a href="logout.jsp">Logout</a>
	</div>
		
		<!-- header and paragraph -->
		<h1>Welcome to Dating for Dummies</h1>
		<p style="text-align: center">
			This is a website will help you find meet your next potentional date or even your future partner.
		</p>
		
		<!-- Welcome Image -->
		<img id="homeImage" src="Images/Maze.jpg">
		
		<!-- Footer -->
		<p style="text-align: center;font-size: 10pt;">
			This web resource was created by Christian Hope Crow.
		</p>
	</body>
</html>

<!-- 
Pink: #F1A1DE
Dark Pink: #A15A96
Light Grey: #3A3A3A
Dark Grey/Black: #171717
--> 
