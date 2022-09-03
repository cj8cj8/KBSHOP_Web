<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<link href="<%=request.getContextPath()%>/style/vgb.css" rel="stylesheet">
<title>找不到頁面</title>
</head>
<body>

	<jsp:include page="/subview/header.jsp" >
			<jsp:param value="系統發生錯誤" name="subheader"/>
		</jsp:include> 
				
		
		<jsp:include page="/subview/nav.jsp"/>
		
		<article>
		<%if(response.getStatus()==405){ %>
			<h1><%=response.getStatus() %></h1>
			<h2>非法操作</h2>
			<h2><%=request.getAttribute("javax.servlet.error.message") %></h2>			
			<h2><%=request.getMethod() %></h2>
			<%}else{ %>
			<h1><%=response.getStatus() %></h1>
			<h2>找不到頁面</h2>
			<h2><%=request.getAttribute("javax.servlet.error.message") %></h2>
			
			<h2><%=request.getAttribute("javax.servlet.error.status_code") %></h2>
			<%} %>
		</article>
		<%@ include file="/subview/footer.jsp" %>	
</body>
</html>