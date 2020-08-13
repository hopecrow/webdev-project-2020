<%@ page import="java.sql.*, oracle.jdbc.driver.*"%>  

<%
if(session.getAttribute("login")!=null) {
	response.sendRedirect("Home.jsp");
}
%>
    
<%
Connection con = null;
PreparedStatement pstmt=null;
ResultSet rs = null;
String JDBCUrl = "jdbc:oracle:thin:@ee417.c7clh2c6565n.eu-west-1.rds.amazonaws.com:1521:EE417";
String username = "ee_user";
String password = "ee_pass";
String dblogin, dbpass, dbfirst, dblast, dbgender, dbage, dbcounty, dbbio, login, pass; 

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
	if(request.getParameter("loginbutton")!=null) {	
		login = request.getParameter("usernamefield"); 
		pass = request.getParameter("passwordfield"); 
		
		pstmt = con.prepareStatement("SELECT * from CCMembers where USERNAME=? AND PASSWORD=?");
		pstmt.setString(1,login);
		pstmt.setString(2,pass);
		rs = pstmt.executeQuery();
	
		if (rs.next()) {
	        dblogin = rs.getString("USERNAME");
	        dbpass = rs.getString("PASSWORD");
	        dbfirst = rs.getString("FIRSTNAME");
	        dblast = rs.getString("LASTNAME");
	        dbgender = rs.getString("GENDER");
	        dbage = rs.getString("AGE");
	        dbcounty = rs.getString("COUNTY");
	        dbbio = rs.getString("BIO");
			
			if(login.equals(dblogin) && pass.equals(dbpass)) {
				session.setAttribute("login",dblogin);
				session.setAttribute("first",dbfirst);
				session.setAttribute("last",dblast);
				session.setAttribute("gender",dbgender);
				session.setAttribute("age",dbage);
				session.setAttribute("county",dbcounty);
				session.setAttribute("bio",dbbio);
				response.sendRedirect("Home.jsp");
			}
		}
		else {
			request.setAttribute("errorReturn","invalid email or password");
		}
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
		<title>Login</title>
		<link rel="stylesheet" type="text/css" href="CSS/Style.css" /> 
		<link rel="scortcut icon" type="image/png" sizes="16x16" href="Images/favicon-16x16.png">
  	</head>
	<body>
		<form method="POST" name="myform"> 
			<p style="color:red;text-align:center;"> <% if(request.getAttribute("errorReturn")!=null) {out.println(request.getAttribute("errorReturn"));} %> </p>
			<table class="Login">
				<tr><td class="heading" colspan="2">Enter login Details:</td></tr> 
				<tr><td class="heading2">Username:</td><td><input size="50" type="text" name="usernamefield" value="" required/></td></tr> 
				<tr><td class="heading2">Password:</td><td><input size="50" type="password" name="passwordfield" value="" required/></td></tr>
			</table>
			<p style="text-align: center">
				<input class="button" type="submit" name="loginbutton" value="Login" />
				<br/><br/>
				Not Registered!! <a class="linked" href="Register.jsp">Register Here</a><br>
				Go directly to Report!! <a class="linked" href="Report.html">Read Report</a><br><br><br>
				Name: Christian Hope Crow <br>
				Student Number: 15115160
			</p>
		</form>
	</body>
</html>