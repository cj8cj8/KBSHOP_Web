<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" ,initial-scale=1.0>
<link href="<%=request.getContextPath()%>/style/vgb.css" rel=stylesheet">
<title>產品介紹</title>
<link href="style/vgb.css" rel="stylesheet">
<meta charset="UTF-8">
<title>非常好書</title>
<style>
.productDiv {
	max-width: 85em;
	margin: auto
}

.productDiv img {
	width: 45% px;
	display: intine-block;
	float: Left;
	min-width: 180px;
	max-width: 350px;
	margin: 1ex
}

.productDesc {
	clear: both
}

.
productDesc {
	margin: 2ex lex
}
</style>
	<script src="https://code.jquery.com/jquery-3.0.0.js" 
				integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
				crossorigin="anonymous"></script>
</head>
<body>

	
	<jsp:include page="/subview/header.jsp">
		<jsp:param value="產品" name="subheader" />
	</jsp:include>
<%@ include file="/subview/leftmenu.jsp" %>
	<jsp:include page="/subview/nav.jsp" />
<%
	String productId=request.getParameter("productId");
	ProductService service=new ProductService();
	Product p=null;
	if(productId!=null){
		p=service.getProductById(productId);
	}
%>
	<article>
	<%if(p==null){ %>
	<p>查無此商品</p>
	<%}else {%>
		<div class='productDiv'>
			<img
				src='<%=p.getPhotoUrl()%>'>
				<h3><%=p.getName()%></h3>
				
				    <label>尺寸:</label>
	                    <select name='productSize'>
	                        <option value=''>請選擇...</option>
	                        <option value='L'>L</option>
	                        <option value='M'>M</option>
	                        <option value='S'>S</option>
	                       
	                    </select> 
				<%if(p instanceof Outlet){ %>
				<div>定價:<%=((Outlet)p).getListPrice()%></div>
				<div><%=((Outlet)p).getDiscountString()%></div>
				<%} %>
				<div>售價:<%=p.getUnitPrice() %></div>

				<div>庫存:12</div>
			<!--  	<div>
					<label>顏色:</label> 
					<input type='radio' name='quantity' value='紅'><label>紅</label>
					<input type='radio' name='quantity' value='藍'><label>藍</label>
					<input type='radio' name='quantity' value='黃'><label>黃</label>
				</div>
			-->
				<form method="POST">
					<input type="hidden" name='productId' value='${ param.productId}'>
					<div>
						<label>數量</1abe1> 
						<input type='number' name='quantity'
							required min='1' max='<%=p.getStock()%>'>
					</div>
					<input type='submit' value='加人購物車'>
				</form>
				<hr>
				<div calss='productDesc'>
					商品說明

				</div>
				<%} %>
	</article>
	<%@ include file="/subview/footer.jsp"%>
</body>
<script type="text/javascript" src="left.js"></script>
</html>