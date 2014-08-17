<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="neorest.*,org.neo4j.jdbc.*,java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<link rel="stylesheet" type="text/css" href="/uktourism1.0/css/uktourism.css">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="/uktourism1.0/js/jquery-1.8.0.js"></script>
		<script type="text/javascript" src="/uktourism1.0/js/jquery-ui-1.9.2.custom.js"></script>
	
	<title>
		Uttrakhand Tourism
	</title>
	
	
<script language="javascript">

/*JQUERY FOR EFFECTS AND ANIMATIONS*/


$(document).ready(function() {

	/* AJAX LOADING */
	
	$('#inputsearch').bind('keyup keydown change focusout',function() {
		$('#searchresult').html("<center><img src=\"/uktourism1.0/images/loading.gif\" /></center>");
		$.get("/uktourism1.0/returnSearch.jsp?query="+$('#inputsearch').val(), function(data) {
				$('#searchresult').html(data);
			});
		});	
		
		$('#inputsearch').bind('keyup keydown change focusout',function() {
		$.ajax({ url:"/uktourism1.0/returnSearch.jsp?query="+$('#inputsearch').val(),
		cache:false}).beforeSend(function() {
		$('#searchresult').html("<center><img src=\"/uktourism1.0/images/loading.gif\" /></center>");
		}).complete(function(data){
		$('#searchresult').html(data);
		});
		});
		
	/* SLIDING OF LOGIN BOX */
	
	$('#login').click(function() {
		$('#loginbox').slideDown('slow',function() {
			$('#logincontent').fadeIn('slow');
		 });
	});

	$('#about').mouseover(function() {
		$('#logincontent').fadeOut('slow', function() {
    	  $('#loginbox').slideUp('slow');
		});
	});
	
	$('#header').mouseover(function() {
		$('#logincontent').fadeOut('slow', function() {
    	  $('#loginbox').slideUp('slow');
		});
	});
	
	/* AUTOCOMPLETE */
	//$('#inputsearch').autocomplete({ source: [ "Dehradun", "Haridwar", "Hotel Doon Castle", "Robbers Cave", "Sahastradhara", "Tapkeshwar Temple", "Chandi Devi" ] 
	//});
});


</script>

</head>
<body>

<div id="nav">
<div style="width:1190px;margin:auto;">
	<div id="menu">
		<b>
		<a href="/uktourism1.0/index.jsp"><span id="home" class="menuitem">Home</span></a>
		<a href="/uktourism1.0/index.jsp"><span id="map" class="menuitem">Map</span></a>
		<span id="contact" class="menuitem">Contact</span>
		<span id="about" class="menuitem">About</span>
		<span id="login" class="menuitem">Login</span>
		</b>
	</div>
</div>
</div>

<div id="loginbox">
 <div id="logincontent">
 <form name="loginform" method="POST" action="login.jsp">
 Username : <input type="text" name="username"><p/>
 Password : <input type="password" name="password"><p/>
 <input type="checkbox"/> Remember Me<br>
 <input type="submit" name="submit" value="Login"><p/>
 <small><u>New User? <a href="register.jsp">Register Here</a><br>
 Forgot Password? <a href="passreset.jsp">Reset Here</a><br></u></small>
 </form>
 </div>
</div>

<div id="wrapper">
	<div id="header">
	<h1 class="componentheading">UTTARAKHAND TOURISM</h1>
	</div>
	<hr>
	<div id="content">
		<div id="search">
			<form onSubmit="return false;">
			<b><big>Search : </big></b> <input id="inputsearch" type="text" name="query"/>&nbsp;
			<br/>
			List Only :
				<input type="checkbox" id="search_type" name="search_type" value="RecreationalPlace">Tourist Spots &nbsp;
				<input type="checkbox" id="search_type" name="search_type" value="Temple">Temples &nbsp;
				<input type="checkbox" id="search_type" name="search_type" value="Hotel">Hotels &nbsp;
				<input type="checkbox" id="search_type" name="search_type" value="ShoppingPlace">Shopping Places &nbsp;
				<input type="checkbox" id="search_type" name="search_type" value="Museum">Museums &nbsp; 
			</form>
		</div>
		<div id="searchresult">
		</div>
		</div>
	</div>
<div id="footer">
Copyright Protected &copy; 2012 http://www.uktourism.com | All Rights Reserved
</div>
</body>
</html>