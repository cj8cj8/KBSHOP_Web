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
	
	/*background: pink;*/
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
overflow-x:hidden;
overflow-y: overlay;
height: 300px;
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
	function disableShippingType(){
		var shippingString = $("select[name='paymentType'] option:selected").attr('data-shipping');
		//console.log("SHIPP"+shippingString);
		if(shippingString){
			var shippingArray=shippingString.split(",");
			//console.log("disableShippingType() say: This is: "+shippingArray);
			var prevData = $("select[name='shippingType']").val();
			$("select[name='shippingType']").val('');
			$("select[name='shippingType'] option:NOT([value=''])").prop('disabled', true);
			for(i=0;i<shippingArray.length;i++){
				$("select[name='shippingType'] option[value='"+shippingArray[i]+"']").prop('disabled', false);
				console.log(prevData, shippingArray[i]);						
				if(prevData==shippingArray[i]){
					$("select[name='shippingType']").val(prevData);
				}
			}
		}
		calculateTotalAmount();
	}
	
	function calculateTotalAmount(){
		var paymentFee = 0;
		var shippingFee = 0;
		var totalAmount = Number($("#totalAmountSpan").html());

	
		if($("select[name='paymentType']").val() != ""){
			paymentFee = Number($("select[name='paymentType'] option:selected").attr("data-fee"));
		}
		if($("select[name='shippingType']").val() != ""){
			shippingFee = Number($("select[name='shippingType'] option:selected").attr("data-fee"));
		}
		console.log(paymentFee, shippingFee, totalAmount);
		
		$("#totalAmountWithFeeSpan").html(totalAmount+paymentFee+shippingFee);
	}
	function init(){
	
		$("select[name='paymentType']").on("change", disableShippingType);
		$("select[name='shippingType']").on("change", changeAddressInput);
		
	}
	$(init);
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

	function changeAddressInput(){
				calculateTotalAmount();
				
				var shippingOption = $("select[name='shippingType']").val(); //取得shippingType的value
				console.log('changeAddressInput():'+shippingOption);
				$("#chooseStore").hide();				
				$("input[name='shippingAddress']").attr('autocomplete', 'off');
				$("input[name='shippingAddress']").prop('readonly', false);
				$("input[name='shippingAddress']").css('width', '');
				$("input[name='shippingAddress']").removeAttr('list');
				$("input[name='shippingAddress']").val('');
				if(shippingOption=='<%=ShippingType.SHOP.name()%>'){					
					$("input[name='shippingAddress']").attr('list', 'shoplist');					
				}else if(shippingOption=='<%=ShippingType.STORE.name()%>'){					
					$("input[name='shippingAddress']").prop('readonly', true);
					$("#chooseStore").show();
					
				}else{					
					$("input[name='shippingAddress']").attr('autocomplete', 'on');	
				}
			}

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
			<jsp:param value="" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>

<article>
			<%-- ${sessionScope.cart} --%>
			<%

			ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			if(cart==null || cart.isEmpty()){
				Customer member=(Customer)session.getAttribute("member");
				
			%>
			
			<h3>購物車是空的!</h3>
			<%}else{%>
			<form method='POST' action='checkout.do' id='cartForm'>
	 			<div class="shoppingcart_menu">

			<div class="shoppingcart">
				<div class="cartmenuSetting">
				<div class="cart_item_parent" >
				購買明細
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
							<%=item.getUnitPrice() %>
						</div>
						
						<div class='order_discount'>
							<%=item.getDiscountSring() %>
						</div>
						<div class='order_quantity'>						
						
						<div class="quantity">
    				
   					<%=cart.getQuantity(item) %> 				
  					  </div>					
						</div>
						<div class='order_totalprice'>
							<%=cart.TOTAL_PRICE_FORMAT.format(cart.getAmount(item)) %>
						</div>
						<div class='order_opt'>
							
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
	<aside>
	
		<div class="shoppingcart_menu">

			<div class="shoppingcart">
	<div class="cartmenuSetting">
		<div class="cart_bottom_amount">
					
					
					
						<div class='order_item'>
							共 <%=cart.size() %> 項 <%=cart.getTotalQunatity() %> 件
						</div>
							<div class='order_item'>
							&nbsp;
						</div>
						
						<div class='order_totalprice' >
							總金額:$<span id='totalAmountSpan'><%= cart.TOTAL_PRICE_FORMAT.format(cart.getTotalAmount()) %></span>元
						</div>
						<div class='order_totalprice'>
							&nbsp;
						</div>
							
						
					
					</div>
					<div class="cart_bottom_order_parent">
					
					<div  class='cart_bottom_order'>
					
							</select>
							<select name='paymentType' class='order_opt_pay_btn'><!-- onchange='disableShippingType()' -->
										<option value=''>請選擇...</option>
										<% for(PaymentType pType:PaymentType.values()) {%>
										<option value='<%=pType.name() %>' data-fee='<%= pType.getFee()%>'
											data-shipping='<%=pType.getShippingTypes()%>'><%=pType%></option>
										<% } %>
									</select>  
						</div>
					
						<div class='cart_bottom_order'>
					
							
								<select name='shippingType'class='order_opt_pay_btn' required><!--  onchange='changeAddressInput()' -->
										<option value=''>請選擇...</option>
										<% for(ShippingType shType:ShippingType.values()) {%>
										<option value='<%=shType.name() %>' data-fee='<%= shType.getFee()%>'><%=shType%></option>
										<% } %>
										
									</select> 
						</div>
						
						<div>
						</div>
						
						
						
						<div class='cart_bottom_order'>
						<%--含運費--%> 總金額為:$<span id='totalAmountWithFeeSpan' style='color:rgb(220, 20, 60);'> <%= cart.TOTAL_PRICE_FORMAT.format(cart.getTotalAmount()) %></span>元
			
						</div>
						
					</div>
					
					
					
					
					
					
					<div class="cart_bottom_order_test">
				
					
						
						<p>
						<label class='test'>收件人:</label>
							<input type="text" name='recipientName' value='' placeholder="請輸入訂購人姓名" >
							<input type="checkbox" value='同訂購人' onchange="copyMember()" style='width:80px;vertical-align:middle;'>同訂購人
						
						</p>
						<p>
				
						<label class='test'>電話:</label>
						<input type="tel" name='recipientPhone' value='' placeholder="請輸入電話">
						</p>
						<p>
				
						<label class='test'>信箱:</label>
						<input type="email" name='recipientEmail' value='' placeholder="請輸入信箱"style='width:220px'>
						</p>
						<p>
				
						<label class='test'>地址:</label>
						<input type="text" name='shippingAddress' value='' placeholder="請輸入地址"style='width:220px'>
					
						<input type="button" style='display:none' id='chooseStore'value='選擇超商' onclick="goEZShip()" style='width:80px; vertical-align:middle;'>
						</p>
						
						
					
						
					</div>
					
					
					<div class="cart_bottom">
					
					
					
						<div class='order_item'>
						
						</div>
				
						<div class='order_opt_pay'>
							<input class='order_opt_pay_btn' type="submit" value="買單">
						</div>
					</div>
				</div>
			</div>
		</div>
	</aside>
            
	</form>
	<%} %>

		<script>                         

			  function goEZShip() {//前往EZShip選擇門市
	            /* if (confirm("Go EZ前，你的網址已經改用ip Address了嗎?")) {			
	                  alert("出發");			
	             } else {			
	                  alert("快改網址!");			
	                  return;			
	             }*/
			
				$("input[name='recipientName']").val($("input[name='recipientName']").val().trim());			
				$("input[name='recipientEmail']").val($("input[name='recipientEmail']").val().trim());			
				$("input[name='recipientPhone']").val($("input[name='recipientPhone']").val().trim());			
				$("input[name='shippingAddress']").val($("input[name='shippingAddress']").val().trim());			
			
				var protocol = "<%= request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/")) %>";		
				var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";			
				var url = "https://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ezship_callback.jsp";                 
			
				$("#rtURL").val(url);
			
							
				$("#webPara").val($("#cartForm").serialize());
			
			//	alert('現在網址不得為locolhost: '+url); //測試用，測試完畢後請將此行comment			
		//		alert($("#webPara").val()) //測試用，測試完畢後請將此行comment			 
			
				$("#ezForm").submit();			
			  }
			
			</script>	
	<form id="ezForm" method="POST" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web_2014.jsp" >

<input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->

<input type="hidden" name="processID" value="VGB202107050000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->

<input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->

<input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->

<input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->

<input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->

</form>   
	<script type="text/javascript" src="<%= request.getContextPath() %>/left.js"></script>

</body>
	
</html>