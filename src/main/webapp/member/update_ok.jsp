<%@page import="uuu.vgb.service.MailService"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@page import="uuu.vgb.entity.Customer"%>
<!DOCTYPE html>
<html>
	<head>
		<link href="<%=request.getContextPath() %>/style/vgb.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="refresh" content="3;url=<%=request.getContextPath()%>">
		<meta charset="UTF-8">
		<title>修改成功</title>
	</head>
	<style>
					.product_list_none{
margin:auto;
display: flex;
align-items: center;
justify-content: center; 
flex-direction: column; 
height:550px;
}
.product_list_parent {
	width: 70%;
	margin: auto;
	/*background: rgb(81,90,90,1);*/
	display: flex;
	flex-wrap:wrap;
	justify-content: flex-start;
	
}
	
	</style>
<body>
		<%
		Customer c=(Customer)session.getAttribute("member");
		
		%>
		<jsp:include page="/subview/header.jsp" >
			<jsp:param value="" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>
		<article>
			
		<div class='product_list_parent'>
				<div class='product_list_none'>
				<div>
				<label style='color:rgb(203, 67, 53);font-size: 30px;'><%=c!=null?c.getName():"XXX" %>修改會員資料成功</label>
				<label style='font-size: 30px; '>3秒後將自動跳轉<a href='<%=request.getContextPath()%>'style='font-size: 30px;'>首頁</a></label>
				</div>
			
			</div>
		</article>
		<%@ include file="/subview/footer.jsp" %>
</body>
</html>