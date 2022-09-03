<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/style/vgb.css" rel="stylesheet">
<style type="text/css">
#table99 td{border: 1px gray solid}
#table99{border-collapse: collapse;}
</style>
</head>
<body>

<table id="table99">
<caption>99乘法表</caption>
	<%for(int i=1;i<10;i++){ %>
	
	
	<tr>
	<%for(int j=1;j<10;j++){ %>
		<td><%= i%>*<%= j%>=<%= i* j %></td>
		
		<%}%>
	</tr>
		
	<%}%>
	
</table>
<%
	for(int i=1;i<10;i++){
		
		for(int j=1 ;j<10;j++ ){
			out.println(i+"*"+j+"="+i*j+"<br>");
		}
		
	}
%>
<input type=>
</body>
</html>