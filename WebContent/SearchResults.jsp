<%@ page import="java.sql.*, oracle.jdbc.driver.*"%>  

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Search Results</title>
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
	
	<%
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	String JDBCUrl = "jdbc:oracle:thin:@ee417.c7clh2c6565n.eu-west-1.rds.amazonaws.com:1521:EE417";
	String username = "ee_user";
	String password = "ee_pass";
	String rsfirst, rslast, rsgender, rsage, rscounty, rsbio, rsuser;
	String gender, county, agemin, agemax;
	
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
		gender = request.getParameter("gender"); 
		county = request.getParameter("county"); 
		agemin = request.getParameter("agemin"); 
		agemax = request.getParameter("agemax"); 
		
		pstmt = con.prepareStatement("SELECT * from CCMembers WHERE GENDER=? AND COUNTY=? AND (AGE BETWEEN ? AND ?)");
		pstmt.setString(1,gender);
		pstmt.setString(2,county);
		pstmt.setString(3,agemin);
		pstmt.setString(4,agemax);
		rs = pstmt.executeQuery();
	
		while (rs.next()) {
	        out.println( 
	        		"<table class='Login'><tr><td class='heading' colspan='2'>" + rs.getString("FIRSTNAME") + " " + rs.getString("LASTNAME") +"</td></tr>"
	        		+ "<tr><td class='heading2'>Username:</td><td>" + rs.getString("USERNAME") + "</td></tr>"
	        		+ "<tr><td class='heading2'>Gender:</td><td>" + rs.getString("GENDER") + "</td></tr>"
	        		+ "<tr><td class='heading2'>Age:</td><td>" + rs.getString("AGE") + "</td></tr>"
	        		+ "<tr><td class='heading2'>County:</td><td>" + rs.getString("COUNTY") + "</td></tr>" 
	        		+ "<tr><td class='heading2'>Bio:</td><td>" + rs.getString("BIO") + "</td></tr>"
	        		+ "</table>"
			);
	        
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
	
</body>
</html>