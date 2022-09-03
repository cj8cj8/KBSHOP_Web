<%@page import="uuu.vgb.entity.CartItem"%>
<%@page import="uuu.vgb.entity.ShoppingCart"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>	
	
	<head>
		<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<title>購物車</title>
	</head>
	<style>
	article{

}
.shoppingcart_menu {
	display: block;
	flex-direction: column; /*column row*/
	
	
	
}
 .shoppingcart {
	
	/*background: pink;*/
	display:flex;
	justify-content: center; 
	width:100VW;
	
}
.product_list_parent {
	width: 70%;
	margin: auto;
	/*background: rgb(81,90,90,1);*/
	display: flex;
	flex-wrap:wrap;
	justify-content: flex-start;
	
}

.product_list_none{
margin:auto;
display: flex;
align-items: center;
justify-content: center; 
flex-direction: column; 
height:550px;
}
.cartmenuSetting{
display: flex;
flex-direction: column;
background:gray;
justify-content: center;
align-items: center;  
width:80%;

}
.cartmenuSettingtest::-webkit-scrollbar {
/*隱藏滾輪*/

}

.cartmenuSettingtest{
display: flex;
flex-direction: column;
background:gray;
justify-content: flex-start;
align-items: center;  
width:100%;
overflow-x:hidden;
overflow-y: overlay;
height: 500px;
border:1px solid rgb(248, 248, 248) ;
}

.cart_item_title{
width:100%;
text-align: center;
margin-top:40px;
flex-grow: 0;
border:1px solid rgb(248, 248, 248) ;
display: flex;
justify-content: space-around;
align-items:center;
padding:0px;
background: rgb(169, 169, 169,1);
}

.cart_item_parent{
width:100%;
text-align: center;
	margin-top:30px;
	font-size:30px;
	padding:0px;
}


.cart_item{
width:100%;
margin:0px;
flex-grow: 0;
border:1px solid rgb(248, 248, 248) ;
height: 100px;
display: flex;
align-items:center;
justify-content: space-around;
padding:0px;
	
}

.cart_bottom{
width:100%;
margin:0px;
flex-grow: 0;
border:1px solid rgb(248, 248, 248) ;
height: 100px;
display: flex;
align-items:center;
justify-content: space-around;
padding:0px;
	
}
.cart_bottom div{
align-items: center;
text-align: center;

}
.cart_item:hover{
background: rgb(176, 196, 222,1);
}
.cart_item div{
align-items: center;
text-align: center;

}
.order_all{
width:60px;
}

.order_cur{
width:40px;
}
.order_cur_checkbox{
width:50px;


}
.order_img{
width:60px;
height: 60px;
vertical-align: middle;
}
.order_name{
width:150px;
height: 100px;
 display: flex;
  justify-content: center;
  align-items: center; 

}
.order_title_name{
width:150px;

}
.order_type{
width:100px;
}

.order_quantity{
width:90px;
}

.order_unitprice{
width:70px;
}
.order_discount{
width: 40px;
}
.order_totalprice{
width:120px;
}
.order_item{

}
.order_item_totalQty{
width:100px;
}
.order_opt{
width:70px;
}
.order_opt_pay_btn {
width: 210px;
height: 40px;
}
.order_opt_edit_btn {
width: 210px;
height: 40px;
}
.order_opt_pay{
width:250px;
}
aside{
position: fixed;
bottom:0px;
}
.s {
    text-decoration: line-through;
}

</style>
	<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>	
	<script>
	$(function(){
		var t = $("#quantity");
		$("#add").click(function(){
			t.val(parseInt(t.val())+1);
			$("#min").removeAttr("disabled");                 //當按加1時，解除$("#min")不可讀狀態
			setTotal();
		})
		$("#min").click(function(){
	               if (parseInt(t.val())>1) {                     //判斷數量值大於1時才可以減少
	                t.val(parseInt(t.val())-1)
	                }else{
	                $("#min").attr("disabled","disabled")        //當$("#min")為1時，$("#min")不可讀狀態
	               }
			setTotal();
		})
		
	})
      
		</script>
	<body>

		
	<jsp:include page="/subview/header.jsp" >
			<jsp:param value="" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>

<article>
			<%-- ${sessionScope.cart} --%>
			<%

			ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			if(cart==null || cart.isEmpty()){
					
				
			%>
				<div class='product_list_parent'>
				<div class='product_list_none'>
				<a href='<%=request.getContextPath() %>/member/order_history.jsp'><div>
			
				<h2>查詢歷史訂單</h2>
				</div></a>
				<h2>目前購物車是空的</h2>
				<img style='width: 250px;height: 250px;' src='<%=request.getContextPath() %>/images/cartNONE_icon.png'>
				<div>
			
				</div>
			</div>
			</div>
			<%}else{
				
			%>
				${sessionScope.stockError}			
			<% session.removeAttribute("stockError"); %>
			<form method="POST" action="updateCart.do">
	 			<div class="shoppingcart_menu">

			<div class="shoppingcart">
				<div class="cartmenuSetting">
				<div class="cart_item_parent" >
				購物車明細
				</div>		
					<div class="cart_item_title">
					<div class='order_cur_checkbox'>
							<input type="checkbox" value="全選">			
						</div>
						<div class='order_cur'>
							產品編號				
						</div>
						<div class='order_img'>
						
						</div>
						<div class='order_title_name'>
						商品名稱
						</div>
						<div class='order_type'>
							型號
						</div>
						
						<div class='order_unitprice'>
							價格
						</div>
						<div class='order_discount'>
							優惠
						</div>
						<div class='order_quantity'>
							數量
						</div>
						<div class='order_totalprice'>
							小計
						</div>
						<div class='order_opt'>
							操作
						</div>
					</div>
			<div class='cartmenuSettingtest'>
			<%for(CartItem item:cart.getCartItemSet()){ %>
					<div class="cart_item">
						<div class='order_cur_checkbox'>
							<input type="checkbox" value="1">	
									
						</div>
					
						<div class='order_cur'>
						
							<%=item.getProductId() %>					
						</div>
						<div class='order_img'>
						<img class='order_img' src='<%=item.getPhotoUrl()%>'>
						</div>
						<div class='order_name'>
						<%=item.getProductName() %>
						</div>
						<div class='order_type'>
						<% if(item.getSize()!=null){%>
						<%=item.getSizeName() %>
						<%}else{ %>
							<%=item.getTypeName() %>
						<%} %>
						
						</div>
						
						<div class='order_unitprice'>
					<% if(item.getDiscount()>10){%>
						<span style='text-decoration: line-through;'><%=item.getListPrice()%></span>
							<%=item.getUnitPrice()%>
							
					<%}else{ %>
							<%=item.getUnitPrice()%>
							
							<% }%>
						</div>
					
						<div class='order_discount'>
							<%=item.getDiscountSring() %>
						</div>
						<div class='order_quantity'>						
						
						<div class="quantity">
    				
   				 <input min="0" max="<%=item.getStock() %>" name="quantity<%=item.hashCode()%>" value="<%=cart.getQuantity(item) %>" type="number"style="width:50px">
 				
  					  </div>					
						</div>
						<div class='order_totalprice'>
							<%=cart.TOTAL_PRICE_FORMAT.format(cart.getAmount(item)) %>
						</div>
						<div class='order_opt'>
							<%-- <input type="submit" value="刪除" name='delete<%=item.hashCode()%>'>--%>
							<input type="checkbox" value="刪除"name='delete<%=item.hashCode()%>'>
						</div>
					</div>
					
					<%} %>
			</div>
				
			</div>
			</div>
			
		</div>
		
	</article>
	<aside>
	
		<div class="shoppingcart_menu">

			<div class="shoppingcart">
	<div class="cartmenuSetting">
		<div class="cart_bottom">
						<div class='order_all'>
						<input type="checkbox" value="全選" style="padding:'0' ">全選
						</div>
					
					
						<div class='order_item'>
						<input class='order_opt_edit_btn' type="submit" value="修改購物車">
						</div>
						<div class='order_item_totalQty' name='totalQuantity'>
							共 <%=cart.size() %> 項 <%=cart.getTotalQunatity() %> 件
						</div>
						<div class='order_totalprice'>
							總金額:<%= cart.TOTAL_PRICE_FORMAT.format(cart.getTotalAmount()) %>元
						</div>
						<div class='order_opt_pay'>
						<!--  	<input class='order_opt_pay_btn' type="button" value="買單">-->
							<button class='order_opt_pay_btn' name='submit' value='checkout'>買單</button>
						</div>
					</div>
					</div>
					</div>
					</div>
	</aside>
	</form>
	<%} %>
	
	<script type="text/javascript" src="<%= request.getContextPath() %>/left.js"></script>
</body>
	
</html>