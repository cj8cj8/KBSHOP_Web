<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link href="<%=request.getContextPath()%>/style/vgb.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="refresh" content="3;url=<%=request.getContextPath()%>">
		<meta charset="UTF-8">
		<title>登入成功</title>
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
	<script>

	var s = 3;
	function reciprocal(){
	    document.getElementById("timer").innerHTML=s;
	    setTimeout(reciprocal,1000);
	    s -= 1;
	}
	
	</script>
<body onload="reciprocal()">
		<jsp:include page="/subview/header.jsp" >
			<jsp:param value="" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>
		<%
		Customer c=(Customer)session.getAttribute("member");
	
		%>
		<article>
			
		
			
			
			<div class='product_list_parent'>
				<div class='product_list_none'>
				<div>
				<label style='color:rgb(203, 67, 53);font-size: 30px;'><%=c!=null?c.getName():"XXX" %>登入成功</label>
				<label style='font-size: 30px; '><span id="timer">3</span>秒後將自動跳轉<a href='<%=request.getContextPath()%>'style='font-size: 30px;'>首頁</a></label>
				</div>
			
			</div>
		</div>
		</article>
		<footer>
			<hr>			
			<div >KBSHOP &copy; 2022/07~</div>
		</footer>
</body>
</html>