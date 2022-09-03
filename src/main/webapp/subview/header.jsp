<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
	<!-- header.jsp start -->
	<%Customer member=(Customer)session.getAttribute("member"); %>
	<link rel='icon' type='image/x-icon'href='<%=request.getContextPath()%>/images/favicon.ico'>
<header>
		<div id="menu">

			<div class="menu1">
				<div id="dy_bar">
					<span style="display:inline-block;"><img style="height: 54px" src="<%=request.getContextPath()%>/images/shipp.jpg">​</span>
					<span style="display:inline-block;"><img style="height: 54px" src="<%=request.getContextPath()%>/images/police.jpg">​</span>
				<!--  	<span id="dy_bar_btn" ><a style="display:inline-block" href="<%=request.getContextPath()%>/products_list.jsp">立即購物</a></span>-->
				</div>

			</div>
			<div class="menu2">
				<div class="menuSetting">
					<ul id="item2_1">
					
						<li>
						台灣					
						</li>
						<li>					
						
						</li>
						
					</ul>
				 
					<ul id="item2_2">
					
						<li>						
						<!--  <span><a href="login.html">登入註冊/購物車<a></a></span>-->
					<form name='seach' style='float:right' method='GET' action='<%= request.getContextPath()%>/products_list.jsp'>
					
					<div style='margin-right:220px;'>
		
					<input id='site-search' type='search' name='keyword' value='${param.keyword}' placeholder="請輸入查詢條件...">
					 <input type="image"value='查詢' src="<%=request.getContextPath()%>/images/search.png" style='width:25px;height: 25px;'>
					
						</div>
						</li>
						
					</ul>
					
				</div>
			</div>
			<div class="menu3">
				<div class="menuSetting">		
					<ul id="item3_1">
					
						
						
					</ul>
					<ul id="item3_2">
					<li>
										
						<a href='<%=request.getContextPath()%>'><span>KBSHOP	<sub>${param.subheader==null?"":param.subheader}</sub>	</span></a>
						</li>
						<li>
					
						<a href="<%=request.getContextPath()%>/products_list.jsp">全部產品</a>
						</li>
						<li>
						
						<a href="<%=request.getContextPath()%>/products_list.jsp?date=1">最新產品</a> 	
						</li>
						<li >
							<a href="<%=request.getContextPath()%>/products_brand.jsp">品牌館	</a> 												
						</li>
						<li>
						<a href="<%=request.getContextPath()%>/products_list.jsp?category=鍵盤">鍵盤</a>	
						</li>
						<li>
						<a href="<%=request.getContextPath()%>/products_list.jsp?category=手托">手托</a>								
						</li>
						
						
					</ul>
					
					<ul id="item3_3">
										<%if(member==null){ %>
			<li >
				<label>
			<a href='<%=request.getContextPath() %>/member/shoppingCart.jsp'><img src="<%=request.getContextPath()%>/images/cart_shop_icon.png" style='width:28px;height: 28px;'></a>
				<span class='totalQtySpan'>${sessionScope.cart.totalQunatity}</span>
			</label>
			<label style='margin-left: 50px;'>
			<a href="<%=request.getContextPath()%>/login.jsp"><img src="<%=request.getContextPath()%>/images/user.png" style='width:24px;height: 24px;'></a> 
			</label>
			</li>
			<%}else{ %>
			<li style="width: 300px;">
			<label>
			<a href='<%=request.getContextPath() %>/member/shoppingCart.jsp'><img src="<%=request.getContextPath()%>/images/cart_shop_icon.png" style='width:28px;height: 28px;'></a>
				<span class='totalQtySpan'>${sessionScope.cart.totalQunatity}</span>
			</label>
			
			<label style='margin-left: 50px;'><a href="<%=request.getContextPath()%>/member/update.jsp"><img src="<%=request.getContextPath()%>/images/user.png" style='width:24px;height: 24px;'></a></label>
			<label style='margin-left: 50px;'><a href="logout.do">登出</a></label>
			
			</li>
			
			<%} %>
					
					</ul>
					<div id="item3_4">
					
				</div>
			</form>	
				
				</div>
			</div>
			<div id='headertest'>
					<div class="menu2_fixed">
				<div class="menuSetting">
					<ul id="item2_1">
					
						<li>
						台灣				
						</li>
						<li>					
						
						  
						</select>
						</li>
						
					</ul>
					
					<ul id="item2_2">
						<li>						
						<!--  <span><a href="login.html">登入註冊/購物車<a></a></span>-->
					<form name='seach' style='float:right' method='GET' action='<%= request.getContextPath()%>/products_list.jsp'>
					<div style='margin-right:220px;'><input id='site-search' type='search' name='keyword' value='${param.keyword}' placeholder="請輸入查詢條件...">
				<!-- <input type='submit'value='查詢'  style=" margin-right: 180px;"> -->
					<a href='javascript:seach.submit();'>
					<img  onclick='javascript:seach.submit();' src="<%=request.getContextPath()%>/images/search.png" style='width:25px;height: 25px;'>	
						</a>
						</div>
						</li>
						
					</ul>
					
				</div>
			</div>
			<div class="menu3_fixed">
				<div class="menuSetting">		
					
						
						<ul id="item3_2">
						<li>
										
						<a href='<%=request.getContextPath()%>'><span>KBSHOP	<sub>${param.subheader==null?"":param.subheader}</sub>	</span></a>
						</li>
						<li>
					
						<a href="<%=request.getContextPath()%>/products_list.jsp">全部產品</a>
						</li>
						<li>
						
						<a href="<%=request.getContextPath()%>/products_list.jsp?date=1">最新產品</a> 	
						</li>
						<li >
							<a href="<%=request.getContextPath()%>/products_brand.jsp">品牌館	</a> 												
						</li>
						<li>
						<a href="<%=request.getContextPath()%>/products_list.jsp?category=鍵盤">鍵盤</a>	
						</li>
						<li>
						<a href="<%=request.getContextPath()%>/products_list.jsp?category=手托">手托</a>								
						</li>
						
						
					</ul>
					<ul id="item3_3">
			<%if(member==null){ %>
			<li>
			<label>
			<a href='<%=request.getContextPath() %>/member/shoppingCart.jsp'><img src="<%=request.getContextPath()%>/images/cart_shop_icon.png" style='width:28px;height: 28px;'></a>
				<span class='totalQtySpan'>${sessionScope.cart.totalQunatity}</span>
			</label>
			<label style='margin-left: 50px;'>
			<a href="<%=request.getContextPath()%>/login.jsp"><img src="<%=request.getContextPath()%>/images/user.png" style='width:24px;height: 24px;'></a> 
			</label>
			</li>
			<%}else{ %>
			<li style="width: 300px;">
			<label>
			<a href='<%=request.getContextPath() %>/member/shoppingCart.jsp'><img src="<%=request.getContextPath()%>/images/cart_shop_icon.png" style='width:28px;height: 28px;'></a>
				<span class='totalQtySpan'>${sessionScope.cart.totalQunatity}</span>
			</label>
			
			<label style='margin-left: 50px;'><a href="<%=request.getContextPath()%>/member/update.jsp"><img src="<%=request.getContextPath()%>/images/user.png" style='width:24px;height: 24px;'></a></label>
			<label style='margin-left: 50px;'><a href="logout.do">登出</a></label>
			
			</li>
			
			<%} %>
					
					</ul>
				</div>
				</form>
						
				
					

				</div>
			</div>
			</div>
		</div>
	</header>
	<!-- header.jsp end -->	