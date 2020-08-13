<%@ page import="java.sql.*, oracle.jdbc.driver.*"%>  

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Recieved Dates</title>
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
	PreparedStatement pstmt2=null;
	PreparedStatement pstmt3=null;
	PreparedStatement pstmt4=null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	String JDBCUrl = "jdbc:oracle:thin:@ee417.c7clh2c6565n.eu-west-1.rds.amazonaws.com:1521:EE417";
	String username = "ee_user";
	String password = "ee_pass";
	String user, asker, id;
	String location, date, time, status;
	String firstname = null;
	String lastname = null;
	
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
		int i = 0;
		user = String.valueOf(session.getAttribute("login"));
		status = "Pending";
		
		pstmt = con.prepareStatement("SELECT * from CCDates WHERE ASKEE=? AND STATUS=?");
		pstmt.setString(1,user);
		pstmt.setString(2,status);
		rs = pstmt.executeQuery();
		
		out.println("<h1>Pending Dates:</h1>");
		
		while (rs.next()) {
			
			location = rs.getString("LOCATION");
			asker = rs.getString("ASKER");
			date = rs.getString("DAY") + "/" + rs.getString("MONTH") + "/" + rs.getString("YEAR");
			time = rs.getString("HOUR") + ":" + rs.getString("MIN") + rs.getString("AMPM");
			status = rs.getString("STATUS");
			id = rs.getString("ID");
			
			pstmt2 = con.prepareStatement("SELECT x.FIRSTNAME, x.LASTNAME FROM CCMembers x, CCDates y WHERE x.USERNAME=y.ASKER and y.ASKER=?");
			pstmt2.setString(1, asker);
			rs2 = pstmt2.executeQuery();
			
			while (rs2.next()) {
				firstname = rs2.getString("FIRSTNAME");
				lastname = rs2.getString("LASTNAME");
			} 
			
			if (i == 0) {
		        out.println(
		        		"<form method='POST' name='myform'> " 
		        		+ "<table class='Login'><tr><td class='heading' colspan='2'>" + firstname + " " + lastname +"</td></tr>"
		        		+ "<tr><td class='heading2'>User:</td><td>" + asker + "</td></tr>"
		        		+ "<tr><td class='heading2'>Location:</td><td>" + location + "</td></tr>"
		        		+ "<tr><td class='heading2'>Date:</td><td>" + date + "</td></tr>"
		        		+ "<tr><td class='heading2'>Time:</td><td>" + time + "</td></tr>" 
		        		+ "<tr><td class='heading2'>Status:</td><td>" + status + "</td></tr>"
		        		+ "</table>"
		        		+ "<p style='text-align: center'><input class='button' type='submit' name='acceptbutton' value='Accept Date'/>     <input class='button' type='submit' name='rejectbutton' value='Reject Date'/></p></form>"
		        );
		        
				if(request.getParameter("acceptbutton")!=null) {
					status = "Accepted";
					
					pstmt3 = con.prepareStatement("UPDATE CCDates SET STATUS=? WHERE ID=?");
					pstmt3.setString(1,status);
					pstmt3.setString(2,id);
					pstmt3.executeQuery();
					response.sendRedirect("ReceivedDate.jsp");
				}
				if(request.getParameter("rejectbutton")!=null) {
					status = "Rejected";
					
					pstmt4 = con.prepareStatement("UPDATE CCDates SET STATUS=? WHERE ID=?");
					pstmt4.setString(1,status);
					pstmt4.setString(2,id);
					pstmt4.executeQuery();
					response.sendRedirect("ReceivedDate.jsp");
				}
			}
			else {
		        out.println(
						"<table class='Login'><tr><td class='heading' colspan='2'>" + firstname + " " + lastname +"</td></tr>"
		        		+ "<tr><td class='heading2'>User:</td><td>" + asker + "</td></tr>"
		        		+ "<tr><td class='heading2'>Location:</td><td>" + location + "</td></tr>"
		        		+ "<tr><td class='heading2'>Date:</td><td>" + date + "</td></tr>"
		        		+ "<tr><td class='heading2'>Time:</td><td>" + time + "</td></tr>" 
		        		+ "<tr><td class='heading2'>Status:</td><td>" + status + "</td></tr>"
		        		+ "</table>"
		        );
			}
			
			
			i++;
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
	    if (rs2 != null) rs2.close();
	    if (pstmt != null) pstmt.close();
	    if (pstmt2 != null) pstmt2.close();
	    if (pstmt3 != null) pstmt3.close();
	    if (pstmt4 != null) pstmt4.close();
	    if (con != null) con.close();
	}
	catch (Exception ex) {
	    System.out.println("An error occurred while closing down connection/statement"); 
	    }
	}
	%>
	
	
	
	
	
	
	
	<%
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
		user = String.valueOf(session.getAttribute("login"));
		status = "Pending";
		
		pstmt = con.prepareStatement("SELECT * from CCDates WHERE ASKEE=? AND STATUS!=?");
		pstmt.setString(1,user);
		pstmt.setString(2,status);
		rs = pstmt.executeQuery();
		
		out.println("<h1>Approved and Rejected Dates:</h1>");
		
		while (rs.next()) {
			
			location = rs.getString("LOCATION");
			asker = rs.getString("ASKER");
			date = rs.getString("DAY") + "/" + rs.getString("MONTH") + "/" + rs.getString("YEAR");
			time = rs.getString("HOUR") + ":" + rs.getString("MIN") + rs.getString("AMPM");
			status = rs.getString("STATUS");
			
			pstmt2 = con.prepareStatement("SELECT x.FIRSTNAME, x.LASTNAME FROM CCMembers x, CCDates y WHERE x.USERNAME=y.ASKER and y.ASKER=?");
			pstmt2.setString(1, asker);
			rs2 = pstmt2.executeQuery();
			
			while (rs2.next()) {
				
				firstname = rs2.getString("FIRSTNAME");
				lastname = rs2.getString("LASTNAME");

			} 
	        out.println(
	        		"<table class='Login'><tr><td class='heading' colspan='2'>" + firstname + " " + lastname +"</td></tr>"
	        		+ "<tr><td class='heading2'>User:</td><td>" + asker + "</td></tr>"
	        		+ "<tr><td class='heading2'>Location:</td><td>" + location + "</td></tr>"
	        		+ "<tr><td class='heading2'>Date:</td><td>" + date + "</td></tr>"
	        		+ "<tr><td class='heading2'>Time:</td><td>" + time + "</td></tr>" 
	        		+ "<tr><td class='heading2'>Status:</td><td>" + status + "</td></tr>"
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
	    if (rs2 != null) rs2.close();
	    if (pstmt != null) pstmt.close();
	    if (pstmt2 != null) pstmt2.close();
	    if (con != null) con.close();
	}
	catch (Exception ex) {
	    System.out.println("An error occurred while closing down connection/statement"); 
	    }
	}
	%>
</body>
</html>