<%@ page pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>	
	
	<head>
		<link href="style/vgb.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<title>會員註冊</title>
	</head>
	<style>
#register_parent{
 display:flex;
 flex-direction: column;

 }
 #register_body{
  padding-top: 10px;
  margin:0px auto;
 /*background: silver;*/
 width:1150px;
 height:70vh;
 display:flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start;

 }
 
 h2{
 	margin:0px;	
	font-size: 40px;
	padding-top:30px;
 	text-align: center;
 }
.errorMsg{color:red;}


 .register_form{
	
 	float: left;
	width: 80px;	
	text-align: left;
	padding-left: auto;
	
 }
</style>
	<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>	
	<script>
	
       	$(init);		//$(document).ready(init);
// 		$(document).on("click","#captcha_register_Image",refrefreshCaptcha1);
		function init() {
			repopulateForm();
			$("#captcha_Image_register").click(refreshCaptcha1);
			$("#captcha_Image").click(refreshCaptcha);
			$("#changePwdStatus").prop("checked", false);
			}
			function refreshCaptcha1() {
				console.log(captcha_Image_register.src);
				captcha_Image_register.src='images/captcha_register.png?refreshCaptcha1='+new Date();
			}
			function refreshCaptcha() {
				console.log(captcha_Image.src);
				captcha_Image.src='images/captcha.png?refreshCaptcha='+new Date();
			}
			function repopulateForm() {
				<%	if("POST".equals(request.getMethod())) {%>
				$("input[name='userid']").val('<%=request.getParameter("userid")%>')
				$("input[name='name']").val('<%=request.getParameter("name")%>')
				$("input[name='password1']").val('<%=request.getParameter("password1")%>')
				$("input[name='password2']").val('<%=request.getParameter("password2")%>')
			
				$('input[value="<%=request.getParameter("gender")%>"]').prop('checked', true);/*teacher*/
				$('input:radio[name="gender"]').filter('[value="<%=request.getParameter("gender")%>"]').attr('checked', true);
				$("input[name='email']").val('<%=request.getParameter("email")%>')
				$("input[name='birthday']").val('<%=request.getParameter("birthday")%>')
				$("input[name='address']").val('<%=request.getParameter("address")%>')
				$("input[name='phone']").val('<%=request.getParameter("phone")%>')
				$("select[name='bloodType']").val('<%=request.getParameter("bloodType")%>')
				$("input[name='subscribed']").val('<%=request.getParameter("subscribed")%>')
				
				<%}%>
			}
			function displayPassword(thisCheckBox){
				console.log(thisCheckBox.checked); //for test
				if(thisCheckBox.checked){
					$("input[name='password1']").attr('type','text');
					$("input[name='password2']").attr('type','text');
				}else{
					$("input[name='password1']").attr('type','password');
					$("input[name='password2']").attr('type','password');
				}				
			}
		</script>
	<body>
<%
		
		List<String>REGerrorList=(List<String>)request.getAttribute("REGerrorMsg");

		%>	
		
	<jsp:include page="/subview/header.jsp" >
			<jsp:param value="註冊" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>

	<div id="register_parent">
	 	<div id="register_title" style=" height:100px;">	 	
	 		<h2>請完整填寫以下申請資料</h2>
	 	</div>
	 	<div id=register_body>
	 	<hr  style="border: 1px solid red; width:35%;"/>
	 		<form id="register_body_form" action='register.do' method="POST">
	 		<div class='REGerrorMsg'><%=REGerrorList!=null?REGerrorList:""%></div>	
	 		 <p><label class="register_form">身份證:</label><input type="text" name="userid" placeholder="請輸入身份證" required></p>
	 		 <p><label class="register_form">姓名:</label><input type="text" name="name" placeholder="請輸入姓名" required></p>
	 		 <p><label class="register_form">密碼:</label><input type="password" name="password1" placeholder="請輸入密碼(6~20個字)" required><input type='checkbox' id='changePwdStatus' onchange="displayPassword(this)"><label>顯示密碼</label></p>
	 		  <p><label class="register_form">確認密碼:</label><input type="password" name="password2" placeholder="請再確認密碼(6~20個字)" required></p>
	 		 
	 		 <div>	 			
	 					<label class="register_form">性別:</label>
	 					 <input type="radio" class="custom-member-radio" name="gender" value="M" checked />						
						<span class="custom-member-span" for='male' required>男</span>			
						<input type="radio" class="custom-member-radio" name="gender" value="F"/>						
						<span class="custom-member-span" for='female' required>女</span>
						<input type="radio" class="custom-member-radio" name="gender" value="U"/>						
						<span class="custom-member-span" for='unknown' required>不透漏</span>
	 		 </div>
	 		  <p><label class="register_form">信箱:</label><input type="email" name="email" placeholder="請輸入電子信箱" required></p>
	 		  <p><label class="register_form">手機:</label><input type="tel" name="phone" placeholder="請輸入手機號碼" required></p>	 		  
				
				<p><label class="register_form">生日:</label><input type="date" name="birthday" required max='2010-07-14' value='2000-02-05'></p>
				<p><label class="register_form">驗證碼:</label><img id='captcha_Image_register' src='images/captcha_register.png' style='vertical-align:middle;'title='點擊更新驗證碼'></p>
				<p><label class="register_form">&nbsp;</label><input id='captcha_register_Image' name='captcha' type='text' required style='width: 12em' autocomplete="off"
	                           placeholder='請依上圖輸入(不分大小寫)' required> </p>
	                           
				<p><label class="register_form">&nbsp;</label><input  class='button' type="submit" value="註冊"style="width:177px;height:30px;" ></p>
				
				
				
			
	 		</form>
	 	</div>
	</div>
	
	<%@ include file="/subview/footer.jsp" %>
</body>
	<script type="text/javascript" src="left.js"></script>
</html>