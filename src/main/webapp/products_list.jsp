
<%@page import="java.util.Collection"%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
article{
height: 80vh;
}
.product_list_parent {
min-height: 780px;
	width: 70%;
	margin: auto;
	/*background: rgb(81,90,90,1);*/
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.product_list {
	width: 220px;
	height: 358px;
	/*background: rgb(178, 186, 187,1);*/
	border: 1px solid rgb(229, 232, 232);
	margin-left: 3px;
	margin-top: 15px;
	padding: 15px;
	padding-bottom: 0px;
}

.product_list:hover {
	border: 1px solid black;
}

.product_list_pic {
	width: 220px;
	height: 190px;
}

.product_list_pic img {
	width: 220px;
	height: 190px;
	object-fit: fill;
}

.product_list_title {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 4;
	height: 100px;
	color: black;
}

.product_list_none {
	margin: auto;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	height: 550px;
}

.product_list_none label {
	font-size: 40px;
}

.product_list_price {
	text-align: center;
	font-size: 20px;
	height: 30px;
	color: rgb(204, 0, 51);
}

.product_list_order {
	background: rgb(178, 186, 187, 1);
	border: 1px solid rgb(229, 232, 232);
	bottom: 0px;
	text-align: center;
	align-items: center;
	color: white;
	height: 27px;
	font-size: 18px;
}
.product_list_order_nostock {
	background: rgb(139, 0, 0,1);
	border: 1px solid rgb(229, 232, 232);
	bottom: 0px;
	text-align: center;
	align-items: center;
	color: white;
	height: 27px;
	font-size: 18px;
}

</style>

<script src="https://code.jquery.com/jquery-3.0.0.js"
	integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo="
	crossorigin="anonymous"></script>

<script src='<%=request.getContextPath()%>/fancybox3/jquery.fancybox.js'></script>
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
	String keyword = request.getParameter("keyword");
	String brand = request.getParameter("brand");

	String category = request.getParameter("category");
	String date = request.getParameter("date");
	String pageNum = request.getParameter("page");
	ProductService service = new ProductService();
	List<Product> list = null;

	int pageSize = 20;//一頁產品數量
	int pages = 1;//當前頁數

	int minSize = 0;//當頁產品最小編號
	int maxSize = 20;//當頁產品最大編號

	int maxPage = 0;//最大頁數
	if (pageNum != null) {
		pages = Integer.parseInt(pageNum);
	}
	if (pageNum == null) {//判斷
		request.removeAttribute("product");
		if (category != null) {
			list = service.getProductByCategory(category);
			session.setAttribute("product", list);
		} else if (date != null) {
			list = service.getProductByDate(date);

			session.setAttribute("product", list);
		} else if (keyword != null && keyword.length() > 0) {
			list = service.getProductByName(keyword);

			session.setAttribute("product", list);
		}else if (brand != null) {
			list = service.getProductByBrand(brand);

			session.setAttribute("product", list);
		}else {
			list = service.getALLProduct();
			session.setAttribute("product", list);
		}
		if (list.size() % pageSize != 0 && list.size() > pageSize) {//計算頁數
			maxPage = (list.size() / pageSize) + 2;
			System.out.print("總頁數:" + maxPage + "\n" + "當前頁數:" + pages + "\n");
		}

		if (list.size() % pageSize != 0 && list.size()< pageSize) {//計算頁數
			int size = list.size();
			pages = pages - 1;
			
			size = size % pageSize;
			maxSize =minSize+size;
		}
	} else {
		list = null;
		list = (List) session.getAttribute("product");

		if (list.size() % pageSize != 0 && list.size() > pageSize) {//計算頁數
			maxPage = (list.size() / pageSize) + 2;
		}
		if (list.size() % pageSize != 0 && list.size() > pageSize) {//計算是否大於20筆資料
			if (pages == maxPage-1) {//最後一頁
			int size = list.size();
			pages = pages - 1;
			minSize = (pages * pageSize);
			size = size % pageSize;
			maxSize = minSize + size;
			System.out.print("minsize" + minSize);
			} else {
			pages = pages - 1;
			minSize = (pages * pageSize);
			maxSize = minSize + pageSize;
				}

		} else {//不足20筆資料	
			
			int size = list.size();
			pages = pages - 1;
			minSize = (pages * pageSize);
			size = size % pageSize;
			maxSize =1;
		}
		
	}
	
	%>
	<article>
		<%
		if (list == null || list.size() == 0) {
		%>
		<div class='product_list_parent'>
			<div class='product_list_none'>
				<div>
					<label>您輸入的關鍵字為:</label> <label style='color: rgb(203, 67, 53);'><%=keyword%></label>
				</div>
				<div>
					<label>查無相關產品，請重新搜尋</label>
				</div>
			</div>

			<%
			} else {
			%>
			<%
			if (keyword != null) {
			%>
			<div style='margin: auto; width: 80%;'>
				<label>您輸入的關鍵字:</label> <label style='color: rgb(203, 67, 53);'><%=keyword%></label>
			</div>
			<%
			}
			%>

			<div class='product_list_parent'>

				<%
				for (int i = minSize; i < maxSize; i++) {
					Product p = list.get(i);
				%>
				<div class='product_list'>
					<a href='product.jsp?productId=<%=p.getId()%>'><div
							class='product_list_pic'>
							<img src='<%=p.getPhotoUrl()%>'>
						</div>
						<div class='product_list_title'><%=p.getName()%></div>
						<div class='product_list_price'>
							優惠<%=p instanceof Outlet ? ((Outlet) p).getDiscountString() : ""%>$<%=p.getUnitPrice()%>
							起
						</div> <a href='javascript:getProductJSP("<%=p.getId()%>")'>
						<%if(p.getStock() > 0){ %>
						<div class='product_list_order'>加入購物車</div>
						<%}else{ %>
						<div class='product_list_order_nostock'>缺貨中</div>
						<%} %>	
						</a>		
					</a>
				</div>
				<%
				}
				%>



			</div>

			<div
				style='display: flex; align-items: center; justify-content: center; margin-top: 10px; '>

				<%
				for (int i = 1; i < maxPage; i++) {
				%>
				<a href='?page=<%=i%>'><div
						style="margin-left: 5px; border: 1px solid rgb(229, 232, 232); width: 20px; text-align: center; font: 18px;"><%=i%></div></a>

				<%
				}
				%>
			</div>
			<%
			}
			%>
		<div>
		<%@ include file="/subview/footer.jsp"%>
		</div>
	</article>
	


</body>
<script type="text/javascript" src="left.js"></script>
</html>