<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="neorest.*,org.neo4j.jdbc.*,java.sql.*" %>
    
    
    <script>
    
    /* EFFECTS FOR CLICKING ON A NODE FOR DISPLAYING DETAILS DIV */
    
    /* SHOWING DETAILS DIV */
    
    $('.result').click(function() {
    	$(this).css("margin-right","0px");
    	$('#'+this.id+'_details').css("margin-right","20px");
		$('#'+this.id+'_details').show('slide', 700);
	});
    
    /* HIDING DETAILS DIV */
    $('.resultdetails').click(function() {
    	$(this).hide('slide', 700,function () {
    		var id=this.id.split('_');
    		$('#'+id[0]).css("margin-right","20px");
    	});
    });
    
    
    /* USING AJAX FOR FETCHING DETAILS FOR A NODE ON CLICKING ON VIEW MORE */
    
   $('.viewmore').click(function() {
    	var info=this.id.split('_');
    	$.get("/uktourism1.0/returnDetails.jsp?id="+info[0]+"&type="+info[1],function(data)
    			{
    				$('#searchresult').slideUp("slow", function() {
    					$('#searchresult').html(data);
    					$('#searchresult').slideDown("slow");
    				});
    			});
    });
    
    </script>
    
<%
			String query=request.getParameter("query");

			neorest ne = new neorest();
			Neo4jConnection con = ne.getconnection();
			Neo4jStatement st = new Neo4jStatement(con);
			ResultSet rs;
			String city=new String("");
			String qry;
			String refArr=new String("");   //refArr is used so that each node appears not more than once in the result
			String cur_node=new String("");
			int index=-1;
			String[] word=query.split("\\s");
			
			/* LOOP FOR STEMMING EACH WORD IN THE QUERY */
				for(int i=0;i<word.length;i++)
				{
						/* NOT DOING SO FOR PREPOSITIONS */
					
			   		 if(word[i].equalsIgnoreCase("in")||word[i].equalsIgnoreCase("at")||word[i].equalsIgnoreCase("on")||word[i].equalsIgnoreCase("to")||word[i].equalsIgnoreCase("the"))
					   continue;
					
		   	   		 if(word[i].endsWith("ies") && word[i].length()>3)
					 {
						word[i]=word[i].substring(0, word[i].lastIndexOf("ies"));
				     }
		   	   		if(word[i].endsWith("'s") && word[i].length()>2)
					 {
						word[i]=word[i].substring(0, word[i].lastIndexOf("'s"));
				     }
	        		else if(word[i].endsWith("s") && word[i].length()>1)
					{
						word[i]=word[i].substring(0, word[i].lastIndexOf("s"));
					}
					else if(word[i].endsWith("ing") && word[i].length()>3)
					{
						word[i]=word[i].substring(0, word[i].lastIndexOf("ing"));
					}
			   		 else if(word[i].endsWith("ed") && word[i].length()>2)
					{
						word[i]=word[i].substring(0, word[i].lastIndexOf("ed"));
					} 
	        	
		   	   		
					
					if(word.length>1)       //IF QUERY HAS ONLY 1 WORD, TREATS CITY AS A NODE ONLY
					{	
						//OTHERWISE LOOK FOR CITY SO AS TO RETURN THOSE NODES WHICH ARE IN THE CITY SPECIFIED IN THE QUERY
						qry="start n=node(*) where n.Name=~ '(?i)"+word[i]+"' AND n.Node_Type='City' return n.Name";
						rs=st.executeQuery(qry);
						while(rs.next())
						{	
							city=rs.getString("n.Name");   //CITY WILL CONTAIN NAME OF THE CITY SPECIFIED IN THE QUERY
							index=i;           //INDEX WILL CONTAIN THE INDEX OF THE WORD IN QUERY WHICH IS THE CITY
						}
					}
				}
				out.println("Search Results for <big>"+query+"</big>: <hr>");
	       
			/* PERFORMING SEARCH TAKING EACH WORD AS KEYWORD */
			for(int i=0;i<word.length;i++)
	        {	
				/* NOT DOING SO FOR PREPOSITIONS */
				
				if(i==index)       // NOT PERFORMING SEARCH WHEN THE KEYWORD IS CITY ITSELF
					continue;
			    if(word[i].equalsIgnoreCase("in")||word[i].equalsIgnoreCase("at")||word[i].equalsIgnoreCase("on")||word[i].equalsIgnoreCase("to")||word[i].equalsIgnoreCase("the"))
				   continue;
				if(city.equals(""))    //IF NO CITY IS SPECIFIED IN THE QUERY
	             qry="start n=node(*) where n.Name=~ '(?i).*"+word[i]+".*' OR n.Node_Type=~ '(?i).*"+word[i]+".*' return DISTINCT n.Ref_Id, n.Name, n.Node_Type ORDER BY n.Node_Type";
				else
		         qry="start n=node(*) match x-->n where ((x.Node_Type='City' AND x.Name='"+city+"') AND (n.Name=~ '(?i).*"+word[i]+".*' OR n.Node_Type=~ '(?i).*"+word[i]+".*')) return DISTINCT n.Ref_Id, n.Name, n.Node_Type ORDER BY n.Node_Type";
		        
		       // out.println(qry);
		        rs=st.executeQuery(qry);
	            while(rs.next() && !refArr.contains(rs.getString("n.Ref_Id")))
	            {
	            	refArr=refArr+","+rs.getString("n.Ref_Id");
	            	if(!cur_node.equals(rs.getString("n.Node_Type")))   //IF CURRENT NODE TYPE IS NOT EQUAL TO THE NODE TYPE OF PREVIOUSLY PRINTED NODE
	            	{
	            		cur_node=rs.getString("n.Node_Type");      //SET CURRENT NODE TO THIS NODE TYPE
	            		out.println("<h4 class=\"componentheading\">"+rs.getString("n.Node_Type")+"</h4>");  //PRINT HEADING FOR THIS NODE TYPE
	            	}
	            	out.println("<span class=\"result\" id=\""+rs.getString("n.Ref_Id")+"\"><img style=\"height:150px;width:180px;\" src=\"/uktourism1.0/images/"+rs.getString("n.Node_Type").replace(" ","")+"_"+rs.getString("n.Ref_Id")+".jpg\" /><br>"+rs.getString("n.Name")+"</span>");
	            	out.println("<span class=\"resultdetails\" id=\""+rs.getString("n.Ref_Id")+"_details\" style=\"width:200px;height:150px;\">Name : "+rs.getString("n.Name")+"<br>Type : "+rs.getString("n.Node_Type"));
	            	out.println("<br><span class=\"viewmore\" id=\""+rs.getString("n.Ref_Id")+"_"+rs.getString("n.Node_Type")+"\"><u>View More</u></span></span>");
	            }
	            
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
					qry="start n=node:node_auto_index(Name='"+query+"') match n<-[:has"+node_type+"]-x return n.Name, n.Rating, n.Maximum_Charge, n.Minimum_Charge, n.email, n.Phone_Number, n.Address, x.Name;";
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