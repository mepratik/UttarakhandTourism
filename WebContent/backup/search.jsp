<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="neorest.*,org.neo4j.jdbc.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/uktourism1.0/uktourism.css">
<title>Uttrakhand Tourism</title>
<style type="text/css">
</style>
</head>
<body>
<div id="wrapper">

<div id="header">
<h1 align="center">Uttrakhand Tourism<br> Green State</h1></div><hr>
<div id="content"  >
<div id="search"><form method="get" action="search.jsp">

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
<input type="submit" value="search"/>

</form>
<div id="result" style="float:left; margin-left:80px;">
<%
int s_type;
String query=request.getParameter("query");
//out.println(query);
String search_type=request.getParameter("search_type");

	neorest ne = new neorest();
	Neo4jConnection con = ne.getconnection();
Neo4jStatement st = new Neo4jStatement(con);
ResultSet rs;
String qry;


if(!search_type.equals("City"))
{
	
 			if(search_type.equals("Hotel")) //setting s_type 
 				s_type=1;
 			else 
 				s_type=2;
 	if(s_type==1)
 	{   
 		//qry="start n=node:node_auto_index(Name='"+query+"') return n.Name,n.Address,n.Rating,n.Phone_Number,n.email,n.Minimum_Charge,n.Maximum_Charge";
 		qry="start n=node(*) where n.Name='"+query+"' return n.Name,n.Address,n.Rating,n.Phone_Number,n.email,n.Minimum_Charge,n.Maximum_Charge";
 		rs=st.executeQuery(qry);
 		out.println("Search Result for : <big>"+query+"</big><br><hr>" );

 	     while(rs.next())
 	    out.println("<hr><h4>"+rs.getString("n.Name")+"</h4><br><p>Rating:"+rs.getString("n.Rating")+" Star<br/>Address:"+rs.getString("n.Address")+"<br>Phone Number:"+rs.getString("n.Phone_Number")+"<br>Email:"+rs.getString("n.email")+"<br>Minimum Charge:"+rs.getString("n.Minimum_Charge")+"<br>Maximum Charge:"+rs.getString("n.Maximum_Charge")+"</p>");
 	}
 	else
 	{
 		//qry="start n=node:node_auto_index(Name='"+query+"') return n.Name,n.Address";
 		out.println("Search Result for : <big>"+query+"</big><br><hr>" );

 		qry="start n=node(*) where n.Name='"+query+"' return n.Name,n.Address";
 		rs=st.executeQuery(qry);
 		 
 		 while(rs.next())
 		 out.println("<h4>"+rs.getString("n.Name")+"</h4><br><p>Address:"+rs.getString("n.Address")+"</p>");

 	}
 	
 	
 	qry="start n=node(*) match n<-[:has"+search_type+"]-city where n.Name='"+query+"' return city.Name,city.Node_Type";  	//getting in which city
	//out.println(qry);
	rs=st.executeQuery(qry);
	out.println("City:");
	while(rs.next())
		out.println("<a href=\"/uktourism1.0/search.jsp?query="+rs.getString("city.Name")+"&search_type="+rs.getString("city.Node_Type")+"\">"+rs.getString("city.Name")+"</a>");
}// if not city
else
{
	out.println("Search Result for : <big>"+query+"</big><br>" );

	qry="start n=node(*) match n-->x where n.Name='"+query+"' return x.Name,x.Node_Type";
	rs=st.executeQuery(qry);
	while(rs.next())
	out.println("<hr><br><p>"+rs.getString("x.Node_Type")+"<br><a href=\"/uktourism1.0/search.jsp?query="+rs.getString("x.Name")+"&search_type="+rs.getString("x.Node_Type")+"\">"+rs.getString("x.Name")+"</a></p><br>");
				
}//if city

%>



</div>
</div>
</div>
</div>

</div>

</body>
</html>