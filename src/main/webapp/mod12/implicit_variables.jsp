
<%@page import="java.util.Date"%>
<%@page import="java.util.Random"%>
<%@page import="java.io.PrintWriter"%>
<%@page pageEncoding="UTF-8" buffer="8kb" autoFlush="true"%>
<%!
	private int i=100; //屬性
	
	public void jspInit(){
		this.log("Test");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width",initial-scale=1.0>
<link href="<%=request.getContextPath()%>/style/vgb.css" rel=stylesheet">
<title>implicit_variables</title>
</head>
<style>
 p {
 color:blue;
 }
 p label{
 color:black;
 }
</style>
<body>

	<header>
		<h2>隱含變數(Implicit_Variables)</h2>
	</header>
	<hr>


	<%
	int i=1;//區域變數 
	%>
	<p>i/this.i:<%= i/this.i%></p>
	
	<hr>
	<h3>request</h3>
	<p><label>contextPath(Context Root):</label><%=request.getContextPath() %></p>
	<p><label>requestURL:</label><%=request.getRequestURL() %></p>
	<p><label>Method:</label><%=request.getMethod() %></p>
	<p><label>Protocol:</label><%=request.getProtocol() %></p>
	
	<p><label>Server Name:</label><%=request.getLocalName() %></p>
	<p><label>Server ipAddress:</label><%=request.getLocalAddr() %></p>	
	<p><label>Server port:</label><%=request.getLocalPort() %></p>
	<%
	out.flush();
		Thread.sleep(500+new Random().nextInt(500));
	%>
	<p><label>Client Name:</label><%=request.getRemoteHost() %></p>
	<p><label>Client ipAddress:</label><%=request.getRemoteAddr() %></p>	
	<p><label>Client port:</label><%=request.getRemotePort() %></p>
	<p><label>Client Locale:</label><%=request.getLocale() %></p>
	<p><label>QueryString:</label><a href="?id=a123456798&name=godot">點選此連結</a><%=request.getQueryString() %></p>
	
	<p><label>requestURL:</label><%=request.getRequestURI() %></p>
	
	<form method="POST">
		<input type="email"name="email" value=<%=request.getParameter("email")==null?"":request.getParameter("email") %>>
		<input type="submit">
	</form>
	<p><label>getParameter:</label><%=request.getParameter("name")%></p>
	<hr>
	<h3>session(邏輯上的連線)</h3>
	<p>session id:<%=session.getId() %></p>
	<p>session CreationTime:<%=new Date(session.getCreationTime()) %></p>
	<p>session LastAccessedTime:<%=new Date(session.getLastAccessedTime()) %></p>
	<p>session MaxInactiveInterval:<%=session.getMaxInactiveInterval() %>秒</p>

	<h3>response,out</h3>

	<p><label>response buffer size:</label><%=response.getBufferSize()%></p>
	<p><label>response buffer size:</label><%=out.getBufferSize() %></p>
	<h3>application</h3>
	<p><label>contextPath:</label><%=application.getContextPath() %></p>
	<p><label>real Path:</label><%=application.getRealPath("/") %></p>
	<%
			Integer visitor= (Integer)application.getAttribute("vgb.app.visitors.counter");
			application.setAttribute("vgb.app.visitors.counter",visitor!=null?++visitor:1);
	%>	
	<p><label>拜訪人次:</label><%=visitor %></p>
	
	<hr>
	<h3>config</h3>
		<p><label>servlet name:</label><%=config.getServletName() %></p>
		<p><label>servlet name:</label><%=this.getServletName() %></p>
		<p><label>inital Parameter:</label><%=config.getInitParameter("greeting") %></p>
		<p><label>inital Parameter:</label><%=this.getInitParameter("greeting") %></p>
	
	<hr>
	<h3>page</h3>
	
		<p><label>this.i:</label><%=this.i%></p>
		<p><label>this==page:</label><%=this==page%></p>
		<p><label>page.toString:</label><%=page.toString()%></p>
	<hr>
	<h3>pageContext</h3>
	<p><label>context path:</label> 
		<%= ((HttpServletRequest)pageContext.getRequest()).getContextPath() %></p>
	<p><label>initial Parameter:</label> 
		<%= pageContext.getServletConfig().getInitParameter("greeting") %></p>
	
	
	
	
</body>
</html>