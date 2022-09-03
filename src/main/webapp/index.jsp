<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
		<title>首頁</title>
		
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
				integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
				crossorigin="anonymous"></script>
		
		<script type="text/javascript">
	var index=1;
	var timeoutID = window.setInterval(( () => nextHandler(nextHandler) ), 5000);
	$(document).ready(init);
	function init(){
		$("#next").click(nextHandler);
		$("#prev").click(prevHandler);
		$(".gifs4").append("<img src='images/6.jpg' />");
		for (var i=1; i<=6; i++){
			$(".gifs4").append("<img src='images/"+i+".jpg' />");
		}
		$(".gifs4").append("<img src='images/1.jpg' />");
		
		
	}
	
	
	function nextHandler(event){
		window.clearInterval(timeoutID);
		index++;
		$("#info").text(index);
		if(index == 7){
		
			$(".gifs4").animate({"left":-((index)*1000)+"px"},300,gif4Forward);
			index=1;
			timeoutID = window.setInterval(( () => nextHandler(nextHandler) ), 5000);
		}else{
			changeGif();
		}
	}

	function gif4Forward(){
		$(".gifs4").css({"left":"-1000px"});
	}
	
	function prevHandler(event){
		window.clearInterval(timeoutID);
		index--;
		$("#info").text(index);
		if(index == 0){
			
			$(".gifs4").animate({"left":-((index)*1000)+"px"},300,gif4Back);
			index=6;
			timeoutID = window.setInterval(( () => nextHandler(nextHandler) ), 5000);
		}else{
			changeGif();
		}
	}
	
	function gif4Back(){
		$(".gifs4").css({"left":"-6000px"});
	}

	function changeGif(){
		
	 timeoutID = window.setInterval(( () => nextHandler(nextHandler) ), 5000);
		$(".gifs4").animate({"left":-((index)*1000)+"px"},300);
	}
	
	
	
	
	</script>
			<style>
	.index_article{
		width: 70%;
		margin: auto;
			
	}
	
	
	#gifs4Outer{
		position:relative;
		width: 1000px;
		height: 440px;
		overflow:hidden;
		z-index:1;
	}
	.gifs4{
		position:relative;
		z-index:1;
		width:8000px;
		left:-1000px;
	}
	button{
		opacity:0.5;
		width:20px;
		height:100px;
		border:none;
		border-radius:10px;
	}
	#prev{
	position: absolute;	
	top:40%;
	z-index: 2;
	opacity:0.5;
	}
	#next{
		width:20px;
		height:100px;
	position: absolute;	
	right:0px;
	top:40%;
	z-index:2;
	}
	.index_carousel{
	width:80%;
		margin: auto;
	}
	
	.product_brand_list_parent {
	width: 80%;
	margin: auto;
/*	background: rgb(81,90,90,1);*/
	display: flex;
	flex-wrap:wrap;
	justify-content: flex-start;
	
}

.product_brand{

width:248px;
height: 72px;
/*background: rgb(178, 186, 187,1);*/
border:1px solid rgb(229, 232, 232 );


}
.product_brand_list_pic {
	width:248px;
	height:72px;
	
}

.product_brand_list_pic img{
width:248px;
	height:72px;
	object-fit:fill;
}
.product_list{

width:220px;
height: 358px;
/*background: rgb(178, 186, 187,1);*/
border:1px solid rgb(229, 232, 232 );


margin-top: 15px;
padding: 15px;
padding-bottom: 0px;

}
.product_list_parent {
	width: 80%;
	margin: auto;
	/*background: rgb(81,90,90,1);*/
	display: flex;
	flex-wrap:wrap;
	justify-content: flex-start;
	
}
.product_list_pic {
	width:220px;
	height:190px;
	
}
.product_list_pic img{
	width:220px;
	height:190px;
	object-fit:fill;
}
.product_list_title{
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
   -webkit-box-orient: vertical;
  -webkit-line-clamp: 4;
	height: 100px;
	color:black;
}
.product_list_price{

text-align:center;
font-size:20px;
height:30px;
color:rgb(204, 0, 51);
}
.product_list_order{
background: rgb(178, 186, 187,1);
border:1px solid rgb(229, 232, 232 );
bottom:0px;
text-align:center;
align-items:center;
color:white;
height:27px;
font-size:18px;


}.product_list:hover{

border:1px solid black;


}
	</style>
	
	</head>
	<body>

		<jsp:include page="/subview/header.jsp" >
			<jsp:param value="" name="subheader"/>
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>
			
		
		<article>
		<div class='index_article'>
		
		
			
	

	<div  class='index_carousel'>
	
		<div style='position: relative;z-index: 0 ;margin: auto'>
		
			<div id="gifs4Outer">
				<button id="prev">&lt;</button>
				<button id="next">&gt;</button>
				<div class="gifs4"></div>
				
			</div>
				
		</div>	
		
	</div>
	
		<div class='product_brand_list_parent'>
		
	
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Ducky'><div class='product_brand_list_pic'>
				<img src='<%=request.getContextPath()%>/images/Ducky.jpg'>
				</div>	</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Filco'><div class='product_brand_list_pic'>
				<img src='<%=request.getContextPath()%>/images/Filco.jpg'>
				</div>	</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Varmilo'><div class='product_brand_list_pic'>
				<img src='<%=request.getContextPath()%>/images/Varmilo.jpg'>
				</div>	</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Corsair'><div class='product_brand_list_pic'>
				<img src='<%=request.getContextPath()%>/images/Corsair.jpg'>
				</div>	</a>
				</div>
					
			</div>
				<%
	String category = request.getParameter("category");
	

	ProductService service = new ProductService();
	List<Product> list = null;

		list = service.getIndexRandomProduct();

	
	%>
		<div class='product_list_parent'>
		<%
				for(int i=0;i<list.size();i++) {
				Product p= list.get(i);				
			%>
	
		<div class='product_list'>
				<a href='product.jsp?productId=<%=p.getId()%>'><div class='product_list_pic'><img src='<%=p.getPhotoUrl()%>'></div>
				<div class='product_list_title'><%=p.getName() %></div>
				<div class='product_list_price'>優惠<%=p instanceof Outlet?((Outlet)p).getDiscountString():""%>$<%=p.getUnitPrice()%> 起</div>
				<a href='javascript:getProductJSP("<%= p.getId() %>")'><div class='product_list_order'><%=p.getStock()>0?"加入購物車":"缺貨中" %></div></a>
		</a>
			</div>
				<%} %>
					   <div style="position:relative; margin-top: 3px;">
<jsp:include page="Insert_IG.jsp"></jsp:include>
		</div> 	 
    	</div>
     
		</article>
		<%@ include file="/subview/footer.jsp" %>
	</body>
	<script type="text/javascript" src="left.js"></script>
</html>



		
		