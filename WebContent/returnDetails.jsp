<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="neorest.*,org.neo4j.jdbc.*,java.sql.*" %>
    

    
<%
			String id=request.getParameter("id");
			String type=request.getParameter("type");

			neorest ne = new neorest();
			Neo4jConnection con = ne.getconnection();
			Neo4jStatement st = new Neo4jStatement(con);
			ResultSet rs;
			String qry;
			
			out.println("More Details : <hr>");
			
			try{
				if(type.equalsIgnoreCase("Hotel"))
				{
					qry="start n=node(*) match n<-[:has"+type+"]-x where n.Ref_Id='"+id+"' return n.Name, n.Rating, n.Maximum_Charge, n.Minimum_Charge, n.email, n.Phone_Number, n.Address, x.Name;";
					rs=st.executeQuery(qry);
					rs.next();
					out.println("Name : "+rs.getString("n.Name")+"<br>");
					out.println("Address : "+rs.getString("n.Address")+"<br>");
					out.println("Is in : "+rs.getString("x.Name")+"<br>");
					out.println("Rating : "+rs.getString("n.Rating")+"<br>");
					out.println("Maximum Charge : "+rs.getString("n.Maximum_Charge")+"<br>");
					out.println("Minimum Charge : "+rs.getString("n.Minimum_Charge")+"<br>");
					out.println("Email : "+rs.getString("n.Email")+"<br>");
					out.println("Phone Number : "+rs.getString("n.Phone_Number")+"<br>");
				}
				else
				{
					qry="start n=node(*) match n<-[:has"+type+"]-x where n.Ref_Id='"+id+"' return n.Name, n.Address, x.Name;";
					rs=st.executeQuery(qry);
					rs.next();
					out.println("Name : "+rs.getString("n.Name")+"<br>");
					out.println("Address : "+rs.getString("n.Address")+"<br>");
					out.println("Is in : "+rs.getString("x.Name")+"<br>");
				}
			}
			catch(Exception error)
			{
				
			}
			
			
			/*
			if(!search.equals("spots"))
			{
				String [] search_type=request.getParameterValues("search_type");
				for(String param:search_type)
				{
					if(search_type!=null)
					{
						if(!query.equals(""))
						{
							out.println("<h4 class=\"componentheading\">"+param+"s in "+query+"</h4>" );
		 					qry="start n=node:node_auto_index(Name='"+query+"') match n-[:has"+param+"]->x return x.Name,x.Ref_Id;";
						}
						else
		 				{
							out.println("<h4 class=\"componentheading\">Recommended "+param+"s</h4>" );
			 				qry="start n=node(*) match n-[:has"+param+"]->x where n.Node_Type='City' return x.Name,x.Ref_Id;";
		 				}
		 				rs=st.executeQuery(qry);
		 				while(rs.next())
		 				{
		 					out.println("<a href=\"/uktourism1.0/search.jsp?query="+rs.getString("x.Name")+"&search_type=spots\"><span class=\"result\"><img style=\"height:150px;width:180px;\" src=\"/uktourism1.0/images/"+param+"_"+rs.getString("x.Ref_Id")+".jpg\"><br>"+rs.getString("x.Name")+"</span></a>");
		 				}
					}
				}
			}
			else
			{
				qry="start n=node:node_auto_index(Name='"+query+"') return n.Node_Type";
				rs=st.executeQuery(qry);
				rs.next();
				String node_type=rs.getString("n.Node_Type").replace(" ", "");
				out.println("<h4 class=\"componentheading\">About "+query+"</h4>" );
				if(node_type.equals("Hotel"))
				{
					qry="start n=node:node_auto_index(Name='"+query+"') match n<-[:has"+node_type+"]-x ";
					rs=st.executeQuery(qry);
					while(rs.next())
						out.println("Name : "+rs.getString("n.Name")+"<br>Address : "+rs.getString("n.Address")+"<br>Rating : "+rs.getString("n.Rating")+"<br>Maximum Charge : "+rs.getString("n.Maximum_Charge")+"<br>Minimum Charge : "+rs.getString("n.Minimum_Charge")+"<br>Email : "+rs.getString("n.email")+"<br>Phone Number : "+rs.getString("n.Phone_Number")+"<br>Is in : <a href=\"/uktourism1.0/search.jsp?query="+rs.getString("x.Name")+"&search_type=RecreationalPlace&search_type=Temple&search_type=Hotel&search_type=ShoppingPlace&search_type=Museum\">"+rs.getString("x.Name")+"</a>");
			
				}
				else
				{
					qry="start n=node:node_auto_index(Name='"+query+"') match n<-[:has"+node_type+"]-x return n.Name, n.Address, x.Name;";
					rs=st.executeQuery(qry);
					while(rs.next())
						out.println("Name : "+rs.getString("n.Name")+"<br>Address : "+rs.getString("n.Address")+"<br>Is in : <a href=\"/uktourism1.0/search.jsp?query="+rs.getString("x.Name")+"&search_type=RecreationalPlace&search_type=Temple&search_type=Hotel&search_type=ShoppingPlace&search_type=Museum\">"+rs.getString("x.Name")+"</a>");
				}
			}*/
			
%>