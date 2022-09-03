<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!-- nav.jsp start -->
<%Customer member=(Customer)session.getAttribute("member"); %>
<nav>

<!-- 			<a href="#">New In</a> | -->
<!-- 			<a href='#'>Book</a> | -->
<!-- 			<a href='#'>文具</a> | -->
			<%if(member==null){ %>
			<a href="<%=request.getContextPath()%>/products_list.jsp">書店</a> |
			<a href="<%=request.getContextPath()%>/login.jsp">登入</a> |
			<a href="<%=request.getContextPath()%>/register.jsp">註冊</a> |
			<%}else{ %>
			<a href="<%=request.getContextPath()%>/products_list.jsp">書店</a> |
			<a href="<%=request.getContextPath()%>/member/update.jsp">修改會員</a> |
			<a href='<%= request.getContextPath()%>/member/shoppingCart.jsp'>				
			</a>
			<span style="float:right">
			
			<%=member!=null?member.getName()+"你好|":"" %>
			<a href="logout.do">登出</a> |
			
			</span>
			<%} %>
			<hr>
		</nav>
<!-- nav.jsp end -->