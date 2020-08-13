<%@ page import="java.sql.*, oracle.jdbc.driver.*"%>  
    
<%
Connection con = null;
PreparedStatement pstmt=null;
ResultSet rs = null;
String JDBCUrl = "jdbc:oracle:thin:@ee417.c7clh2c6565n.eu-west-1.rds.amazonaws.com:1521:EE417";
String username = "ee_user";
String password = "ee_pass";
String user, askee, location, day, month, year, hour, min, ampm, status;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    con = DriverManager.getConnection(JDBCUrl, username, password);
}
catch (Exception e) {
    System.out.println("\nAn error has occurred during the connection phase!  This is most likely due to your CLASSPATH being set wrong and the"
            + " Oracle classes unable to be found.  Otherwise the database itself may be down.  Try telneting to port 1521 and see if it is up!");
    e.printStackTrace();
    System.exit(0);
}   


try {
	if(request.getParameter("datebutton")!=null) {
	
	user = String.valueOf(session.getAttribute("login"));
	askee = request.getParameter("usernamedate"); 
	location = request.getParameter("locationdate"); 
	day = request.getParameter("day"); 
	month = request.getParameter("month"); 
	year = request.getParameter("year");
	hour = request.getParameter("hour");
	min = request.getParameter("min");
	ampm = request.getParameter("AmPm");
	status = "Pending";
	
	
	pstmt = con.prepareStatement("INSERT INTO CCDates(ASKER,ASKEE,LOCATION,DAY,MONTH,YEAR,HOUR,MIN,AMPM,STATUS) VALUES (?,?,?,?,?,?,?,?,?,?)");
	pstmt.setString(1,user);
	pstmt.setString(2,askee);
	pstmt.setString(3,location);
	pstmt.setString(4,day);
	pstmt.setString(5,month);
	pstmt.setString(6,year);
	pstmt.setString(7,hour);
	pstmt.setString(8,min);
	pstmt.setString(9,ampm);
	pstmt.setString(10,status);
	pstmt.executeUpdate();

	request.setAttribute("datemade","Date Successfully Sent! Please use the Sent Dates page to check the status of your date application.");
	}
}
	catch (SQLException e) {
	System.out.println("\nAn error has occurred during the Statement/ResultSet phase.  Please check the syntax and study the Exception details!");
	    while (e != null) {
	    System.out.println(e.getMessage());
	        e = e.getNextException();
	}
	    System.exit(0);
}


finally {
try {    
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (con != null) con.close();
}
catch (Exception ex) {
    System.out.println("An error occurred while closing down connection/statement"); 
    }
}
%>

<!DOCTYPE html>
<html>
  	<head>
  		<meta charset="UTF-8">
		<title>Make Date</title>
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

	<form method="POST" name="myform"> 
		<p style="color:green;text-align:center;"><% if(request.getAttribute("datemade")!=null) { out.println(request.getAttribute("datemade"));} %></p>
	    <table class="Login">
			<tr><td class="heading" colspan="2">Date Maker</td></tr> 
			<tr><td class="heading2">I would like to ask (Username) on a date:</td><td><input size="50" type="text" name="usernamedate" value="" required/></td></tr> 
			<tr><td class="heading2">Proposed Location:</td><td><input size="50" type="text" name="locationdate" value="" required/></td></tr> 
			<tr><td class="heading2">Day/Month/Year:</td>
				<td><input style="width:30px" type="number" name="day" min="1" max="31" required>
					/ <input style="width:30px" type="number" name="month" min="1" max="12" required>
					/ <input style="width:60px" type="number" name="year" min="2020" max="2120" required></td></tr> 
			<tr><td class="heading2">Time:</td>
				<td><input style="width:30px" type="number" name="hour" min="1" max="12" required>
					: <input style="width:30px" type="number" name="min" min="0" max="59" required>
					<select style="width:50px" name="AmPm">
					    <option value="Am">Am</option>
					    <option value="Pm">Pm</option>
					</select></td></tr> 
		</table>
		<p style="text-align: center">
			<input class="button" type="submit" name="datebutton" value="Send Date"/>
		</p>
	</form>
</body>
</html>