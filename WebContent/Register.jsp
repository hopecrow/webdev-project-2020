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
String firstname, lastname, login, pass, gender, age, county, bio;

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
	if(request.getParameter("Registerbutton")!=null) {
	
	firstname = request.getParameter("firstnamefield"); 
	lastname = request.getParameter("lastnamefield"); 
	login = request.getParameter("usernamefield"); 
	pass = request.getParameter("passwordfield"); 
	gender = request.getParameter("gender");
	age = request.getParameter("age");
	county = request.getParameter("county");
	bio = request.getParameter("bio");
	
	pstmt = con.prepareStatement("INSERT INTO CCMembers(FIRSTNAME,LASTNAME,USERNAME,PASSWORD,GENDER,AGE,COUNTY,BIO) VALUES (?,?,?,?,?,?,?,?)");
	pstmt.setString(1,firstname);
	pstmt.setString(2,lastname);
	pstmt.setString(3,login);
	pstmt.setString(4,pass);
	pstmt.setString(5,gender);
	pstmt.setString(6,age);
	pstmt.setString(7,county);
	pstmt.setString(8,bio);
	pstmt.executeUpdate();

	request.setAttribute("registered","Registered Successfully! Please proceed to login");
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
		<title>Register</title>
		<link rel="stylesheet" type="text/css" href="CSS/Style.css" /> 
		<link rel="scortcut icon" type="image/png" sizes="16x16" href="Images/favicon-16x16.png">
  	</head>
	<body>
		<form method="POST" name="myform"> 
			<p style="color:green;text-align:center;"><% if(request.getAttribute("registered")!=null) { out.println(request.getAttribute("registered"));} %></p>
		    <table class="Login">
				<tr><td class="heading" colspan="2">Enter Registration Information:</td></tr> 
				<tr><td class="heading2">First Name:</td><td><input size="50" type="text" name="firstnamefield" value="" required/></td></tr> 
				<tr><td class="heading2">Last Name: </td><td><input size="50" type="text" name="lastnamefield" value="" required/></td></tr>
				<tr><td class="heading2">Username: </td><td><input size="50" type="text" name="usernamefield" value="" required/></td></tr>
				<tr><td class="heading2">Password: </td><td><input size="50" type="password" name="passwordfield" value="" required/></td></tr>
				<tr><td class="heading2">Gender: </td><td><input type="radio" name="gender" value="Male" required >Male<br><input type="radio" name="gender" value="Female">Female</td></tr>
				<tr><td class="heading2">Age: </td><td><input size="50" type="number" name="age" min="18" max="99" required></td></tr>
				<tr><td class="heading2">County: </td>
					<td><select style="width:200px" name="county">
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
				<tr><td class="heading2">Short Bio: </td><td><textarea id="subject" name="bio" rows="4" cols="50" required></textarea></td></tr>
			</table>
			<p style="text-align: center">
		 		<input class="button" type="submit" name="Registerbutton" value="Register" />
		 		<br/><br/>
				Already registered!! <a class="linked" href="index.jsp">Login Here</a>
			</p>
		</form>
	</body>
</html>