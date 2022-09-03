<%@page import="java.time.LocalDate"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP DEMO</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<header>
 <h1 style="text-align:center">
  JSPDEMO
 </h1>
</header>
<article>
	<%
		LocalDate today=LocalDate.now();
		out.println(today);
		this.log(today.toString());
	%>
	
</article>
</body>
</html>