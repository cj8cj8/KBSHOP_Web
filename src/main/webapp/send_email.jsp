<%@page import="uuu.vgb.service.MailService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/subview/header.jsp" >
			<jsp:param value="Home" name="subheader"/>
		</jsp:include>
		
		
		<%
			String email = request.getParameter("email");
			if(email!=null){
				MailService.sendHelloMailWithLogo(email);
			}
		
		%>		
		<article>
			<form >
				<input name='email' placeholder="enter email please...">
				<input type="submit" > 
			</form>
		</article>
		<%@ include file="/subview/footer.jsp" %>
</body>
</html>



		
		