<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Profile</title>
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
	
	<h1> Welcome, <%=session.getAttribute("first")%> <%=session.getAttribute("last")%> </h1>
	Username: <%=session.getAttribute("login")%>  <br>
	Gender: <%=session.getAttribute("gender")%> <br>
	Age: <%=session.getAttribute("age")%> <br>
	County: <%=session.getAttribute("county")%> <br>
	Bio: <%=session.getAttribute("bio")%>
</body>
</html>