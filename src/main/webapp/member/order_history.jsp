<%@page import="uuu.vgb.entity.Order"%>
<%@page import="uuu.vgb.service.OrderService"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="uuu.vgb.entity.ShippingType"%>
<%@page import="uuu.vgb.entity.PaymentType"%>
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
		
		<title>結帳</title>
	</head>
	<style>
	article{

}
.shoppingcart_menu {
	display: block;
	flex-direction: column; /*column row*/
	
	
	
}
.shoppingcart_menu a{
color:blue;
}
 .shoppingcart {
	
/*	background: pink;*/
	display:flex;
	justify-content: center; 
	width:100VW;
	
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
min-height:70vh;
overflow-x:hidden;
overflow-y: overlay;

border:1px solid black;
}
.cartOrder{
display: flex;
flex-direction: column;
background:white;
justify-content: center;
align-items: center;  
width:80%;

}
.orderPurchaser{
display: flex;
flex-direction: column;
background:white;
justify-content: center;
align-items: center;  
width:100%;
}
.orderPurchaser_list{
display: flex;
flex-direction: column;
background:white;
justify-content: flex-start;
align-items: flex-start;  
width:100%;
}
.cart_item_title{
width:100%;
text-align: center;
margin-top:10px;
flex-grow: 0;
border:1px solid black;
display: flex;
justify-content: space-around;
align-items:center;
padding:0px;
background: rgb(169, 169, 169,1);
}

.cart_item_parent{
width:100%;
text-align: center;
	margin-top:10px;
	font-size:30px;
	padding:0px;
}


.cart_item{
width:100%;
margin:0px;
flex-grow: 0;
border:1px solid black;
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
border:1px solid black;
height: 100px;
display: flex;
align-items:center;
justify-content: space-around;
padding:0px;
	
}
.cart_bottom_amount{
background:white;
width:100%;
margin:0px;
flex-grow: 0;
border:1px solid black;
height: 50px;
display: flex;
align-items:center;
justify-content: flex-end;
padding:0px;
	
}
.cart_bottom_order_parent{

width:100%;
margin:0px;

flex-grow: 0;
border:1px solid black;
height: 70px;
display: flex;
align-items:center;
justify-content: space-around;
padding:0px;
	
}
.cart_bottom_order_test{

width:100%;
margin:0px;

flex-grow: 0;
border:1px solid black;

display: flex;
flex-direction:column;

padding:0px;
	
}
.cart_bottom_order{
display: flex;
align-items:center;
justify-content: center;
 width:250px;
 font-size:20px;
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
width:120px;
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
width:200px;
}
.order_item{

width:100px;
}.order_item div{



align-items: center;
text-align: center;}
.order_opt{
width:70px;
}
.order_opt_pay_btn {
width: 160px;
height: 40px;
}

.order_opt_pay{
width:250px;
}

.test{
margin-left: 70px;
 display: inline-block;
width:70px;
font-size: 20px;
}
.cart_bottom_order_test input{
	width: 180px;
	height: 24px;
	font-size:16px;
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
			<jsp:param value="結帳" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>

<article>
			<%-- ${sessionScope.cart} --%>
			
				<%			
			Customer member=(Customer)session.getAttribute("member");
			OrderService  oService = new OrderService();
			List<Order> list = null;
			if(member!=null){
				list = oService.getOrderHistory(member.getId());
			}
		%>	
			
			
			

			<%
			
			if(list==null || list.isEmpty()) {
			
			
			%>
				
					<div class='product_list_parent'>
				<div class='product_list_none'>
			
				<h2>目前無購買紀錄</h2>
				<img style='width: 250px;height: 250px;' src='<%=request.getContextPath() %>/images/cartNONE_icon.png'>
				<div>
			
				</div>
			</div>
			</div>
			<%}else{%>
			<form method='GET' action='order_history.jsp' id='cartForm'>
	 			<div class="shoppingcart_menu">

			<div class="shoppingcart">
				<div class="cartmenuSetting">
				<div class="cart_item_parent" >
				歷史訂單
				</div>		
					<div class="cart_item_title">
				
						<div class='order_cur'>
							訂單編號				
						</div>
						
						<div class='order_title_name'>
						訂購日期
						</div>
						<div class='order_type'>
							付款方式
						</div>
						<div class='order_type'>
							取貨方式
						</div>
						
						<div class='order_unitprice'>
							訂單金額
						</div>
					
						<div class='order_opt'>
							操作
						</div>
					</div>
			<div class='cartmenuSettingtest'>
			<%for(Order order:list){ %>
					<div class="cart_item">
						
					
						<div class='order_cur'>
						<%=order.getId() %>
						</div>
						
						<div class='order_name'>
						<%=order.getCreatedDate() %>
						<%=order.getCreatedTime() %>
						</div>
						<div class='order_type'>
						<%=order.getPaymentType().getDescription() %>
						
						</div>
						<div class='order_type'>
						
						<%=order.getShippingType().getDescription() %>
						</div>
						
						<div class='order_unitprice'>
							<%=order.getTotalAmountWithFee() %>
						</div>
						<div class='order_opt'>
						
						
							<a href='order.jsp?orderId=<%=order.getId() %>'>查看詳情</a>
						</div>
					</div>
					
					<%} %>
			</div>
				
			</div>
			</div>
			<div class="shoppingcart" >
			<div class='cartOrder'>
					<div class='orderPurchaser'>
					
		
					</div>
				</div>	
			</div>		
		</div>

		
		
	</article>
	
					
					
					
					
		

	</form>
	<%} %>
	<%@ include file="/subview/footer.jsp" %>
	
</body>
	<script type="text/javascript" src="<%= request.getContextPath() %>/left.js"></script>



                              <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
</html>