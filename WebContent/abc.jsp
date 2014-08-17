<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="neorest.*,org.neo4j.jdbc.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
//String s=request.getParameter("a");
//out.println(s);

neorest ne = new neorest();
Neo4jConnection con = ne.getconnection();
Neo4jStatement st = new Neo4jStatement(con);
ResultSet rs;
String qry;
out.println("<h1> hello</h1>");
qry = "start n=node(0) return n.Name,n.Place";
System.out.println(qry);
rs=st.executeQuery(qry);
while(rs.next()){
	out.println(rs.getString("n.Place")+"  <--- "+rs.getString("n.Name"));
	}

out.println("<h1> hello</h1>");

%>
</body>
</html>