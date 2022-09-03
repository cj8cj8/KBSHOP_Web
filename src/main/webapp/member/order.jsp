<%@page import="uuu.vgb.entity.OrderItem"%>
<%@page import="uuu.vgb.entity.OrderStatusLog"%>
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
 .shoppingcart {
	
	
	display:flex;
	
	justify-content: center; 
	width:100VW;
	
}

.cartmenuSetting{
display: flex;
flex-direction: column;

justify-content: center;
align-items: center;  
width:80%;

}
.cartmenuSetting_bottom{
display: flex;
flex-direction: column;

justify-content: center;
align-items: center;  
width:80%;

}
.cartmenuSettingtest::-webkit-scrollbar {
/*隱藏滾輪*/

}
.cart_item_title_detail a{
color:black;
}
.cartmenuSettingtest{
display: flex;
flex-direction: column;

justify-content: flex-start;
align-items: center;  
width:100%;
overflow-x:hidden;
overflow-y: overlay;
height: 300px;
border:1px solid black ;
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

flex-grow: 0;
border:1px solid black ;
border-bottom:none;
display: flex;
justify-content: space-around;
align-items:center;
padding:0px;
background: rgb(169, 169, 169,1);
}
.cart_item_title_detail{
width:100%;
text-align: center;
height:80px;
flex-grow: 0;
border:1px solid black ;
display: flex;
justify-content: space-around;
align-items:center;
padding:0px;
background: white;

}
.cart_item_parent{
width:100%;
text-align: center;
	
	font-size:30px;
	padding:0px;
	background: rgb(169, 169, 169,1);
}


.cart_item{
width:100%;
margin:0px;
flex-grow: 0;
border:1px solid black ;
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
border:1px solid black ;
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
border:1px solid black ;
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

height: 70px;
display: flex;
align-items:center;
justify-content: space-around;
padding:0px;
	
}
.cart_bottom_order_test{

width:100%;
margin:auto;

flex-grow: 0;


display: flex;
flex-direction:column;
justify-content:center;
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
width:200px;
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
.order_shippingtype{
width: 80px;
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

align-items: center;
}
.cart_bottom_order_test input{
	width: 180px;
	height: 24px;
	font-size:16px;
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

	

function copyMember(){
	
	$("input[name='recipientName']").val('${sessionScope.member.name}');
	$("input[name='recipientEmail']").val('${sessionScope.member.email}');
	$("input[name='recipientPhone']").val('${sessionScope.member.phone}');
	if($("select[name='shippingType']").val()=="HOME"){
		$("input[name='shippingAddress']").val('${sessionScope.member.address}');
	}
}
	function repopulateForm(){
		
		<% if("POST".equals(request.getMethod() )) {%>
		$("select[name='paymentType']").val('${param.paymentType}');
		$("select[name='shippingType']").val('${param.shippingType}');
		$("input[name='recipientName']").val('${param.recipientName}');
		$("input[name='recipientEmail']").val('${param.recipientEmail}');
		$("input[name='recipientPhone']").val('${param.recipientPhone}');
		$("input[name='shippingAddress']").val('${param.shippingAddress}');
		<%}%>
	
	}
	
	$(repopulateForm);
      
		</script>
	<body>

		
	<jsp:include page="/subview/header.jsp" >
			<jsp:param value="結帳" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>

<article>
			<%-- ${sessionScope.cart} --%>
			
			<%			
			String orderId = request.getParameter("orderId");
			Customer member= (Customer)session.getAttribute("member");
			OrderService  oService = new OrderService();
			Order order = null;
			List<OrderStatusLog> statusLogList = null;
			if(member!=null && orderId!=null){
				order = oService.getOrderDetail(member.getId(),orderId);
				if(order!=null){
	                  statusLogList = oService.getOrderStatusLog(orderId);
                }
			}
		%>		
			<%if( order==null) { %>
				<p>查無此訂單</p>
			<%}else{ %>
			
	 			<div class="shoppingcart_menu">

			<div class="shoppingcart">
				<div class="cartmenuSetting">
				<div class="cart_item_parent" >
				購買明細
				</div>		
					<div class="cart_item_title">
				
						<div class='order_cur'>
							訂單編號			
						</div>
						
						<div class='order_title_name'>
						訂購時間
						</div>
						<div class='order_type'>
							付款方式
						</div>
						
						<div class='order_unitprice'>
							訂單狀況
						</div>
						<div class='order_shippingtype'>
							取貨方式
						</div>
						<div class='order_quantity'>
							數量
						</div>
						<div class='order_totalprice'>
							總金額(含物流費):
						</div>
					
					</div>
					<div class="cart_item_title_detail">
				
						<div class='order_cur'>
							<%= order.getId()%>		
						</div>
						
						<div class='order_title_name'>
						<%= order.getCreatedDate()%><%= order.getCreatedTime()%>
						</div>
						<div class='order_type'>
							<%=order.getPaymentType().getDescription() %> <%= order.getPaymentFee()>0?order.getPaymentFee():""%>
						<% if(order.getPaymentType()==PaymentType.ATM && order.getStatus()==0) {%>
            		<a id='transferedButton' href="atm_transfered.jsp?orderId=<%= order.getId() %>">通知已轉帳</a>
         				<%}else if(order.getPaymentType()==PaymentType.ATM && order.getStatus()>=1){%>
            		(<%= order.getPaymentNote() %>)
         				<%} %>
						</div>
						
						<div class='order_unitprice'>
							 <%= order.getStatusDescription() %>
							
						</div>
						<div class='order_shippingtype'>
							
								<%=order.getShippingType().getDescription() %> <%= order.getShippingFee()>0?order.getShippingFee():""%>
						</div>
						<div class='order_quantity'>
						共<%= order.size() %>項, <%= order.getTotalQuantity() %>件
						</div>
						<div class='order_totalprice'>
							<%=order.getTotalAmountWithFee() %>
						</div>
					
					</div>
					
					<div class="cart_item_title">
					
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
						
						<div class='order_quantity'>
							數量
						</div>
						<div class='order_totalprice'>
							小計
						</div>
						
					</div>
			<div class='cartmenuSettingtest'>
		
			<% for(OrderItem item:order.getOrderItemSet()) {%>		
					<div class="cart_item">
						
					
						<div class='order_cur'>
							<%=item.getProductId() %>					
						</div>
						<div class='order_img'>
						<img class='order_img' src='<%=item.getPhotoUrl()%>'>
						</div>
						<div class='order_name'>
						<%= item.getProduct().getName() %>	
						</div>
						<div class='order_type'>
						<% if(item.getTypeId()!=null&&item.getTypeId()>0){%>
						<%=item.getTypeName() %>
						<%}else{ %>
							<%=item.getSizeName() %>
						<%} %>
						</div>
						
						<div class='order_unitprice'>
							<%= item.getPrice() %>
						</div>
						
						
						<div class='order_quantity'>						
						
						<div class="quantity">
    				
   						<%= item.getQuantity()%>				
  					  </div>					
						</div>
						<div class='order_totalprice'>
							<%= item.getPrice() * item.getQuantity() %>
						</div>
						
					</div>
					
					<%} %>
			</div>
				
			</div>
			</div>
		
		</div>

			<div class="shoppingcart_menu">

			<div class="shoppingcart">
				<div class="cartmenuSetting_bottom">

					<div class="cart_bottom_order_parent">
								
					<div class="cart_bottom_order_test">
				
					
						
						<p>
						<label class='test'>收件人:</label>
							<input type="text" name='recipientName' readonly value='<%= order.getRecipientName()%>' placeholder="請輸入訂購人姓名"style=" pointer-events: none;" >
							
						
						</p>
						<p>
				
						<label class='test'>電話:</label>
						<input type="tel" name='recipientPhone' readonly value='<%= order.getRecipientEmail()%>' placeholder="請輸入電話" style=" pointer-events: none;">
						</p>
						<p>
				
						<label class='test'>信箱:</label>
						<input type="email" name='recipientEmail' readonly value='<%= order.getRecipientPhone()%>' placeholder="請輸入信箱"style='width:220px; pointer-events: none;' >
						</p>
						<p>
				
						<label class='test'>地址:</label>
						<input type="text" name='shippingAddress' readonly value='<%= order.getShippingAddres()%>' placeholder="請輸入地址"style='width:220px; pointer-events: none;'>
					
						
						</p>
						
						
					<%@ include file="/subview/footer.jsp"%>
						
					</div>
					
				
				</div>
					
		
			
			</div>
			
		</div>
		
		</div>
	
		
	
	<%} %>
	
	</article>
	
	
					
	
            
	

	
	<script type="text/javascript" src="<%= request.getContextPath() %>/left.js"></script>

</body>
	
</html>