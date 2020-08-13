<!DOCTYPE html>
<html>
  	<head>
  		<meta charset="UTF-8">
		<title>Search</title>
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

		<form method="POST" action ="SearchResults.jsp" name="myform"> 
			<p style="color:red;text-align:center;"> <% if(request.getAttribute("errorReturn")!=null) {out.println(request.getAttribute("errorReturn"));} %> </p>
			<table class="Login">
				<tr><td class="heading" colspan="2">Search Menu</td></tr> 
				<tr><td class="heading2">I am seeking</td><td><input type="radio" name="gender" value="Male">Men<br><input type="radio" name="gender" value="Female">Women</td></tr>
				<tr><td class="heading2">Ages (Minimum Age to Maximum Age)</td><td><input type="number" name="agemin" min="18" max="99"> to <input type="number" name="agemax" min="18" max="99"></td></tr>
				<tr><td class="heading2">In County</td>
				<td><select name="county">
						    <option value="Antrim">Antrim</option>
						    <option value="Armagh">Armagh</option>
						    <option value="Carlow">Carlow</option>
						    <option value="Cavan">Cavan</option>
						    <option value="Clare">Clare</option>
						    <option value="Cork">Cork</option>
						    <option value="Derry">Derry</option>
						    <option value="Donegal">Donegal</option>
						    <option value="Down">Down</option>
						    <option value="Dublin">Dublin</option>
						    <option value="Fermanagh">Fermanagh</option>
						    <option value="Galway">Galway</option>
						    <option value="Kerry">Kerry</option>
						    <option value="Kildare">Kildare</option>
						    <option value="Kilkenny">Kilkenny</option>
						    <option value="Laois">Laois</option>
						    <option value="Leitrim">Leitrim</option>
						    <option value="Limerick">Limerick</option>
						    <option value="Longford">Longford</option>
						    <option value="Louth">Louth</option>
						    <option value="Mayo">Mayo</option>
						    <option value="Meath">Meath</option>
						    <option value="Monaghan">Monaghan</option>
						    <option value="Offaly">Offaly</option>
						    <option value="Roscommon">Roscommon</option>
						    <option value="Sligo">Sligo</option>
						    <option value="Tipperary">Tipperary</option>
						    <option value="Tyrone">Tyrone</option>
						    <option value="Waterford">Waterford</option>
						    <option value="Westmeath">Westmeath</option>
						    <option value="Wexford">Wexford</option>
						    <option value="Wicklow">Wicklow</option>
						</select></td></tr>
			</table>
			<p style="text-align: center">
				<input class="button" type="submit" name="searchbutton" value="Search"/>
			</p>
		</form>
	</body>
</html>