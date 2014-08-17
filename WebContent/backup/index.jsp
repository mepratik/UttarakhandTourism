<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="neorest.*,org.neo4j.jdbc.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/uktourism1.0/uktourism.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Uttrakhand Tourism</title>
<style type="text/css">
</style>
</head>
<body>
<div id="wrapper">
<div id="header">
<h1 align="center">Uttrakhand Tourism<br> Green State</h1></div><hr>
<div id="content"  ><div id="search"><form method="get" action="search.jsp">

Enter search:<input type="text" name="query"/><br>
Search for:
<select name="search_type">
<option value="City">City</option>
<option value="Temple">Temple</option>
<option value="Hotel">Hotel</option>
<option value="Shopping Place">Shopping Place</option>
<option value="Museum">Museum</option>
</select>
<br/>
<input type="submit" value="Search"/>

</form>
<div id="result" style="float:left; margin-left:80px;">
<%
//String s=request.getParameter("a");
//out.println(s);

	neorest ne = new neorest();
	Neo4jConnection con = ne.getconnection();
Neo4jStatement st = new Neo4jStatement(con);
ResultSet rs;
String qry;
qry="start n=node(*) match n-[:hasDestination]->city where n.Name='Uttrakhand' return city.Name,city.Temperature";
rs=st.executeQuery(qry);
out.println("<h4>Places To Visit</h4><hr><br>");
while(rs.next())
{ 	out.println("Destination:"+"<a href=\"/uktourism1.0/search.jsp?query="+rs.getString("city.Name")+"&search_type=City\">"+rs.getString("city.Name")+"</a><br>Temperature:"+rs.getString("city.Temperature")+" degree celcius<br>");

out.println("<hr><br>");
	}

%>
</div>
</div>
</div>
</div>

</body>
</html>