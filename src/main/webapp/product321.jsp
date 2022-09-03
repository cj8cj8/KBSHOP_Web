<%@page import="java.io.Console"%>
<%@page import="uuu.vgb.entity.ProductSize"%>
<%@page import="uuu.vgb.entity.ProductType"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
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

.productDiv>img {
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
.imgtype{
width: 60px;
height:60px;
}
/* HIDE RADIO */
[type=radio] { 
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;
}

/* IMAGE STYLES */
[type=radio] + img {
  cursor: pointer;
}

/* CHECKED STYLES */
[type=radio]:checked + img {
  outline: 2px solid #f00;
}
</style>
	<script src="https://code.jquery.com/jquery-3.0.0.js" 
				integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
				crossorigin="anonymous"></script>
				
				
				<script>
				function changeImage(theIcon){
					console.log(photo.src);
					console.log(theIcon.dataset.photo);
					var stock = theIcon.dataset.stock;
					photo.src=theIcon.dataset.photo;//改圖片
					//listPriceSpan.innerHTML=theIcon.dataset.listprice;
					priceSpan.innerHTML=theIcon.dataset.price;
					stockSpan.innerHTML=theIcon.title + " " +theIcon.dataset.stock;//改庫存
					quantity.max=theIcon.dataset.stock;//改數量input的max
				console.log(stock);
					if(stock>0){
						$("#submitbtn").val("加入購物車");
						$(".testqUantity").css("display","block");
					}else{
						$("#submitbtn").val("商品目前無庫存");
						$(".testqUantity").css("display","none");
					}
					
				}
			/*	function changeSizeInfo(index){
					var stock=select_product_size.options[index].getAttribute("data-stock");
					var title=select_product_size.options[index].getAttribute("title");
					var price=select_product_size.options[index].getAttribute("data-price");
					
				
					priceDiv.innerHTML= "售價:"+price ;
					stockSpan.innerHTML=title + "還剩 "+stock+" 件" ;//改庫存
					quantity.max=stock;//改數量input的max
					getSizeData(title);
				}*/
				function getSizeData(typename){
					var productId = $("input[name='productId']").val();
				
					$.ajax({
						url: 'product.jsp?productId=' + productId 
									+ "&type="+typename,
						method:'GET'				
					}).done();
				}
				
				function getSizeDataDoneHandler(result){
					console.log(result);
					quantity.max=theIcon.dataset.stock;
					console.log(quantity.max=theIcon.dataset.stock);
					$("select[name='teststock']").innerHTML(result);
				}
				function addCart(){
		//			alert('submit');
		//		console.log("action"+$("#addCartForm").attr("action"));
		//		console.log("method"+$("#addCartForm").attr("method"));
		//		console.log("serialize"+$("#addCartForm").serialize());
					
					
					$.ajax({
						url:$("#addCartForm").attr("action")+"?ajax=",
						method:$("#addCartForm").attr("method"),
						data:$("#addCartForm").serialize()
					}).done(addCartDoneHandler)
					return false; //取消同步的submit請求
				}
				
				function addCartDoneHandler(result){
					console.log(result);
					alert("加入購物車成功，共" +result.totalQty+"件");
					$(".totalQtySpan").html(result.totalQty)
					//$("html").html(result);
				}
				function changeSize(){
				//	alert($("select[name='productSize'] option:selected").val());
					var stock = $("select[name='productSize'] option:selected").attr("data-stock");
				//	var listPrice = $("select[name='productSize'] option:selected").attr("data-listPrice");
				  var price = $("select[name='productSize'] option:selected").attr("data-price");
					var title = $("select[name='productSize'] option:selected").attr("title");
					console.log(stock, price,title);
				//	$("#listPriceSpan").html(price);
				
				
					$("input[type='number']").prop('max',10);
					$("#priceSpan").html(price);
					$("#stockSpan").html(title+":" + stock+"個)");
					if(stock>0){
						$("#submitbtn").val("加入購物車");
						$(".testqUantity").css("display","block");
					}else{
						$("#submitbtn").val("商品目前無庫存");
						$(".testqUantity").css("display","none");
					}
					
				}
			
				</script>
</head>
<body>

	
		
	<jsp:include page="/subview/header.jsp">
		<jsp:param value="產品介紹" name="subheader"/>
		</jsp:include>
<%@ include file="/subview/leftmenu.jsp" %>
	<jsp:include page="/subview/nav.jsp" />
<%
	String productId="7";//request.getParameter("productId");
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
			<img id='photo'
				src='<%=p.getPhotoUrl()%>'>
				<h3><%=p.getName()%></h3>
				
				
				<%if(p instanceof Outlet){ %>
				
				<div>定價：<span id='listPriceSpan'><%= ((Outlet)p).getListPrice() %></span>元</div>
			
				<div>折扣: <%= ((Outlet)p).getDiscountString() %> </div>
				<%} %>
				
				<div>優惠價: <span id='priceSpan'><%=p.getUnitPrice()%></span>元</div>

				<%if(p.istype()){ %>
		
				<span id='stockSpan'></span></div><br>	
				<%} %>
				<%if(p.isSize()){ %>
				<div>尺寸:<span id='stockSpan'></span></div><br>	
				<%} %>
		<form id='addCartForm' method="POST" action="AddCart.do" onsubmit='return addCart()'>			
					<input type="hidden" name='productId' value='${ param.productId}'>
					
				<div>
			 	<%if(p.istype()){ %>
					<label>軸體:</label> 
					<%
					Map<Integer,ProductType>map=p.getTypeMap();
					Set<Integer> typeNameSet=map.keySet();
					
					for(Integer typeName:typeNameSet){
						ProductType type=map.get(typeName);
					
					%>
					<label>
					<input type='radio' name='kbtype' value='<%=typeName%>' required >
					<img  class='imgtype'  title='<%=type.getProductType()%>' onclick='changeImage(this)' data-stock='<%=type.getStock() %>'
					src="<%=request.getContextPath()%><%=type.getIconUrl() %>"
					data-photo='<%=p.getPhotoUrl()%>'
					data-listprice='<%=type.getListPrice() %>'
					data-price='<%=type.getUnitPrice()%>'
					>
					</label>
					<%} %>
				
					<%}if(p.isSize()){%>
					 <label>尺寸:</label>
					<%
					Map<Integer,ProductSize>map=p.getSizeMap();
					Set<Integer>sizeNameSet=map.keySet();
					
					%>
						
	                    <select id='select_product_size'name='productSize' onchange='changeSize()' >
	                        <option value='' selected  >請選擇...</option>
	                      <%  for(Integer sizeName:sizeNameSet){
	    						ProductSize size=map.get(sizeName);
	    					
	    					%>
	                        <option value='<%=sizeName%>' 
	                        data-stock='<%=size.getStock() %>' 
	                        title='<%=size.getProductsize()%>'
	                        data-price='<%=size.getUnitPrice()%>'
	                        data-listprice='<%=size.getListPrice() %>'
	                       
	                        
	                        >
	                        <%=size.getProductsize() %></option>
	                        
	                       <%} %>
	                    </select> 
	                    
					<%} %>
				</div>
					
					<div class='testqUantity'>
						<label>數量:</1abe1> 
						
						<input type='number' id='quantity' name='quantity'
							required min='1' max='<%=p.getStock()%>'>
						
						
						
					</div>
					<div id='teststock'>
					
					<input id='submitbtn' type='submit' value='加人購物車'>
					
					
					
					</div>
					
				</form>
				<hr>
				<div calss='productDesc'>
					<%=p.getDescription() %>

				</div>
				<%} %>
	</article>
	<%@ include file="/subview/footer.jsp"%>
<script>
/*var selectElem = document.getElementById('select_product_size');


//當有新的option被選中時
selectElem.addEventListener('change', function() {
  var index = selectElem.selectedIndex;
  if(index>0){
 changeSizeInfo(index);
 
  }
})*/
</script>
</body>
<script type="text/javascript" src="left.js"></script>

</html>