<%@page import="java.io.Console"%>
<%@page import="uuu.vgb.entity.ProductSize"%>
<%@page import="uuu.vgb.entity.ProductType"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>

<style>
.product_ITEM_parent {
	width: 60%;
	margin: 0px;
	/*background: rgb(81,90,90,1);*/
	display: flex;

	flex-direction:column;


	
}

.product_item_parent{
margin: 20px auto;

display: flex;


}
.product_item_pic{
/* background: pink;*/

 width: 400px;
 height: 460px;
}
.product_item_pic img{

margin: 45px;

width:300px;
height:300px;
object-fit:fill;
}

.product_item_name{
/*background: white;*/
margin: 20px 10px 0px 10px;
font-size:20px; 


}
.product_item_price_parent{
background: white;
 
height: 220px;

}
p{

margin: 0px 0px 5px 0px; 


}
.tesrtst{
display:flex;
flex-direction:column;
align-items:center;
justify-content:center;

width:860px;	
padding:10px;
margin: 20px auto;
background: orange;

}
.tesrtst h2{
text-align: center;
}

.product_item_text{
text-align:right;
margin-left: 5px;
display: inline-block;
width:60px;
font-size: 16px;

}
.product_item_price{
margin-left: 10px;
font-size: 24px;

}
.product_item_right{
/*	background: rgb(240, 255, 255);*/
	 width: 300px;
 height: 460px;
}

.imgtype{
width: 60px;
height:60px;
}
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

				
				
				<script>
				function changeImage(theIcon){
					console.log(photo.src);
					console.log(theIcon.dataset.photo);
					var stock = theIcon.dataset.stock;
					photo.src=theIcon.dataset.photo;//改圖片
					//listPriceSpan.innerHTML=theIcon.dataset.listprice;
					priceSpan.innerHTML="$"+theIcon.dataset.price;
				//	stockSpan.innerHTML=theIcon.title + " " +theIcon.dataset.stock;//改庫存
					quantity.max=theIcon.dataset.stock;//改數量input的max
					$("#quantity").val("0");
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
						quantity.max=stock;
						$("#quantity").val("0");
						//	$("#listPriceSpan").html(price);
						$("#priceSpan").html("$"+price);
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

	
		
	

<%
	String productId=request.getParameter("productId");//request.getParameter("productId");
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

				<div class='product_ITEM_parent'>
			
					<div class='product_item_parent'>
					<div class='product_item_pic'>
					<img id='photo'	src='<%=p.getPhotoUrl()%>'>
					</div>
	
					<div class='product_item_right'>
						<div class='product_item_name'><%=p.getName()%></div>
						<div class='product_item_price_parent'>
						
						<%if(p instanceof Outlet){ %>
						<p><label class='product_item_text'>定價:</label><label  id='listPriceSpan'class='product_item_price'>$<%= ((Outlet)p).getListPrice() %></label></p>
						<p>	<label class='product_item_text'>折扣:</label><label class='product_item_price'><%= ((Outlet)p).getDiscountString() %></label></p>
						<%} %>
						<p>	<label class='product_item_text'>優惠價:</label><label class='product_item_price' id='priceSpan'>$<%=p.getUnitPrice()%></label></p>
							<form id='addCartForm' method="POST" action="AddCart.do" onsubmit='return addCart()'>			
					<input type="hidden" name='productId' value='${ param.productId}'>
					<%if(p.istype()){ %>
					
						<p><label  class='product_item_text'>軸體:</label></p>
						<p>
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
					data-price='<%=type.getUnitPrice()%>'>
					</label>
				
					
					<%} %></p>
						<%}if(p.isSize()){%>
						
						<%
					Map<Integer,ProductSize>map=p.getSizeMap();
					Set<Integer>sizeNameSet=map.keySet();
					
					%>
						<div>
						<p><label  class='product_item_text'>尺寸:</label>
						  <select id='select_product_size'name='productSize' onchange='changeSize()'style='height: 35px; margin-left:10px'required >
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
	                     
	                    </p><%} %>
	                    <p><label class='product_item_text' >數量:</label> 
						
						<input type='number' id='quantity' name='quantity'required min='0' max='<%=p.getStock()%>' style='height: 26px; margin-left:10px '></p>
						<p>	<input  id='submitbtn' class='button'type="submit" value="請選擇商品" style="width:177px;height:30px; font-size: 18px;margin-left: 40px;">
						</div>
						</div>
					
						</div>
					
			
				
				</div>
					</form>
				</div>
				
				<%} %>
	</article>
	</body>
	