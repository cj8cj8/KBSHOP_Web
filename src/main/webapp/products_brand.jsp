
<%@page import="javax.swing.plaf.synth.SynthSliderUI"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=request.getContextPath()%>/style/vgb.css"
	rel="stylesheet">
<link rel='stylesheet' type='text/css'
	href='<%=request.getContextPath()%>/fancybox3/jquery.fancybox.css'>
	
<title>產品清單</title>

<style>



.product_list_parent {
	width: 70%;
	margin: auto;
/*	background: rgb(81,90,90,1);*/
	display: flex;
	flex-wrap:wrap;
	justify-content: flex-start;
	
	
}
 article{
 height: 80vh;
 }

.product_brand{

width:260px;
height: 120px;
/*background: rgb(178, 186, 187,1);*/
border:1px solid rgb(229, 232, 232 );

margin-left: 3px;
margin-top: 15px;
padding: 15px;
padding-bottom: 15px;

}
.product_brand:hover{

border:1px solid black;


}
.product_list_pic {
	width:255px;
	height:90px;
	
}

.product_list_pic img{
width:255px;
	height:90px;
	object-fit:fill;
}
.product_list_title{
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
   -webkit-box-orient: vertical;
  -webkit-line-clamp: 4;
	height: 100px;
}
.product_list_none{
margin:auto;
display: flex;
align-items: center;
justify-content: center; 
flex-direction: column; 
height:550px;
}
.product_list_none label{
font-size: 40px;
}
.product_list_brand{

text-align:center;
font-size:20px;
height:30px;
color:rgb(204, 0, 51);
}
.product_list_brand a{


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


}


</style>

<script src="https://code.jquery.com/jquery-3.0.0.js"
	integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo="
	crossorigin="anonymous"></script>

<script
	src='<%=request.getContextPath()%>/fancybox3/jquery.fancybox.js'></script>
<script>
	function getProductJSP(productId) {
		var urlPath = 'product_ajax.jsp?productId=' + productId;
		//做法1:同步請求
		//var url='product.jsp?productId='+productId;
		//javascript:getProductJSP(p.getId())
		//	alert(url);
		//location.href=urlPath;
		//做法2:非同步請求:

		$.ajax({
			url : urlPath,
			method : 'GET'
		}).done(getProductJSPDoneHandler);
	}

	function getProductJSPDoneHandler(response) {
		console.log(response);
		//TODO
		$('#product_fancybox').html(response);
		$.fancybox.open({
			src : '#product_fancybox',
			type : 'inline',
			opts : {
				afterShow : function(instance, current) {
					console.info('done!');
				}
			}
		});
	}
</script>
</head>
<body>
	<div id='product_fancybox'
		style='width: 800px; display: none; height: 600px;'></div>
	<jsp:include page="/subview/header.jsp">
		<jsp:param value="" name="subheader" />
	</jsp:include>
	<%@ include file="/subview/leftmenu.jsp"%>

	<%
	String category = request.getParameter("category");
	String keyword = request.getParameter("keyword");
	String date =request.getParameter("date");
	
	String brand =request.getParameter("brand");
	
	ProductService service = new ProductService();
	List<Product> list = null;

	if (category != null) {
		list = service.getProductByCategory(category);
	} else if (keyword != null && keyword.length() > 0) {
		list = service.getProductByCategory(keyword);
	}else {
		list = service.getALLProduct();

	}
	if (date != null) {
		list = service.getProductByDate(date);		
	}
	if(brand != null){
		list = service.getProductByBrand(brand);	
		
	}
	
	%>
	<article>
		
	

		<div class='product_list_parent'>
		
	
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=CHERRY'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625035790722505813.png'></div>
							
				<div class='product_list_brand'>CHERRY櫻桃</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Ducky'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1637737547512038659.jpg'></div>
				<div class='product_list_brand'>Ducky創傑</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Filco'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625035973705374028.png'></div>
				<div class='product_list_brand'>Filco</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=iRocks'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625036088750613872.png'></div>
				<div class='product_list_brand'>i Rocks 艾芮克</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Leopold'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625036181740243135.png'></div>
				<div class='product_list_brand'>Leopold</div>		
				</a>
				
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Zenzo'><div class='product_list_pic'><img src='https://zenzo.tw/wp-content/uploads/2017/08/logo.png'></div>
				<div class='product_list_brand'>禪做Zenzo</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Mistel'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1640164621730440358.jpg'></div>
				<div class='product_list_brand'>Mistel密斯特</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=ikbc'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625036092007488699.png'></div>
				<div class='product_list_brand'>ikbc</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=ROYALKLUDGE'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625036381302641259.png'></div>
				<div class='product_list_brand'>ROYAL KLUDGE</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Vamilo'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625036488307906366.png'></div>
				<div class='product_list_brand'>Varmilo 阿米洛</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=CoolerMaster'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1625035795404290171.png'></div>
				<div class='product_list_brand'>CoolerMaster 酷碼</div>		
				</a>
				</div>
				<div class='product_brand'>
				<a href='<%=request.getContextPath()%>/products_list.jsp?brand=Vortex'><div class='product_list_pic'><img src='https://www.inpad.com.tw/data/goods/brand/cover/1646888173779100117.jpg'></div>
				<div class='product_list_brand'>Vortex</div>		
				</a>
				</div>
			
			
		</div>
		
		
	</article>
	<%@ include file="/subview/footer.jsp"%>
</body>
<script type="text/javascript" src="left.js"></script>
</html>