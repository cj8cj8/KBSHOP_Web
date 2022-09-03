<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>	
	
	<head>
		<link href="<%=request.getContextPath()%>/style/vgb.css" rel="stylesheet">
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
 height:100vh;
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
<%
		Customer member=(Customer)session.getAttribute("member");
		
	%>
	<script>
	function displayPassword(thisCheckBox){
		console.log(thisCheckBox.checked); //for test
		if(thisCheckBox.checked){
			pwd.type='text';
		}else{
			pwd.type='password';
		}				
	}
	function displayNewPassword(thisCheckBox){
		console.log(thisCheckBox.checked); //for test
		if(thisCheckBox.checked){
		
			password1.type='text';
			password2.type='text';
		}else{
			password1.type='password';
			password2.type='password';
		}				
	}

	$(document).on("click", "#captchaImage", refreshCaptcha);
	function refreshCaptcha(){
		console.log($(this).attr("src"));
		$(this).attr("src", "../images/captcha_register.png?data=" + new Date());
	}
		$(document).on("click", "#changePassword", changePassword);
	
	function changePassword(){
		if($("#changePassword_block").is(":visible")){
			$("#changePassword_block").css("display", "none");
			
			$("#password1").val("");
			$("#password2").val("");
			$("#changepwd_check").prop("checked", false);
			$("#pwd_text").text("密碼");
			
				
			
		}else{
		
			$("#changePassword_block").css("display", "block");
			$("#pwd_text").text("舊密碼");
			$("#changepwd_check").prop("checked", true);
		}
	}
	$(init);
	function init(){
		$("#changePwdStatus").prop("checked", false);
		//alert('init');
		populateForm();
	}
			
			function populateForm() {
				<%if(member==null){%>
				alert("請先登入");
				<%}else{%>
				<%	if("GET".equals(request.getMethod())) {//帶入已登入的會員資料%>
				
					$("input[name='userid']").val('${sessionScope.member.id}');
					$("input[name='name']").val('${member.name}');
					
				
					$("input[name='gender'][value='<%=member.getGender()%>']").prop("checked", true);
					
					$("input[name='email']").val('<%=member.getEmail()%>');
					$("input[name='birthday']").val('<%=member.getBirthday()%>');
					$("input[name='address']").val('<%=member.getAddress()%>');
					$("input[name='phone']").val('<%=member.getPhone()%>');
					$("input[name='subscribed']").val('<%=member.isSubscribed()%>');
					
					
				<%}else if("POST".equals(request.getMethod())){%>
				$("input[name='userid']").val('${sessionScope.member.id}');
				
				$("input[name='name']").val('<%=request.getParameter("name")%>');
				$("input[name='password']").val('<%=request.getParameter("password")%>');
				
			<%--	$("input[name='changepwd_check']").val('<%=request.getParameter("changepwd_check")%>');
				$("input[name='password1']").val('<%=request.getParameter("password1")%>');
				$("input[name='password2']").val('<%=request.getParameter("password2")%>');--%>
			
				$("input[name='gender'][value='<%=request.getParameter("gender")%>']").prop("checked", true);
		
				$("input[name='email']").val('<%=request.getParameter("email")%>');
				$("input[name='birthday']").val('<%=request.getParameter("birthday")%>');
				$("input[name='address']").val('<%=request.getParameter("address")%>');
				$("input[name='phone']").val('<%=request.getParameter("phone")%>');
				$("select[name='bloodType']").val('<%=request.getParameter("bloodType")%>');
				$("input[name='subscribed']").val('<%=request.getParameter("subscribed")%>');
				
				<%}%>
			<%}%>
			}
		</script>
	<body>
	<%
		
		List<String>UPDATEerrorList=(List<String>)request.getAttribute("UPDATEerrorMsg");

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
	 		<form method='POST' action='updateMember.do'novalidate>
	 	<div class='UPDATEerrorMsg'><%=UPDATEerrorList!=null?UPDATEerrorList:""%></div>	
	 		 <p><label class="register_form">身份證:</label><input name='userid' type='text' required  placeholder='請輸入身分證號' disabled="disabled" style=" pointer-events: none;" ></p>
	 		 
	 		 <p><label class="register_form">姓名:</label> <input name='name' type='text' required placeholder='請輸入姓名' ></p>
	 		 <p> <label class="register_form" id='pwd_text' for='pwd'>密碼:</label>
	                    <input id='pwd' name='password' type='password' placeholder='請輸入密碼(6~20個字)'
	                           minlength="6" maxlength="20" required>
	                           <input id="changePassword"type="button" value="變更密碼" onclick="changePassword">
	                           <input type='checkbox' id='changePwdStatus' onchange="displayPassword(this)"><label>顯示密碼</label>
	                        <br>
	        </p>
	 		   <fieldset id="changePassword_block"  style="display: none">
	                
	                 <legend><input id="changepwd_check" name="changepwd_check"type="checkbox"  onclick="return false" "/>變更密碼</legend>
	                <p>
	                    <label class="register_form" >新密碼:</label>
	                    <input id='password1'name='password1' type='password' placeholder='請輸入密碼(6~20個字)'
	                           minlength="6" maxlength="20" required> <input type='checkbox' value='false' id='changePwdStatus' name='testt' onchange="displayNewPassword(this)"><label>顯示密碼</label><br>
	                    <label class="register_form">密碼確認:</label>
	                    <input id='password2'name='password2' type='password' placeholder='請再確認密碼(6~20個字)'
	                           minlength="6" maxlength="20" required>
	                </p>
	                </fieldset>
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
				<p>
				
				<label class="register_form">驗證碼:</label><img id="captchaImage" src='../images/captcha_register.png' style='vertical-align:middle;'title='點擊更新驗證碼'></p>
				<p><label class="register_form">&nbsp;</label><input id='captcha_register_Image' name='captcha' type='text' required style='width: 12em' autocomplete="off"
	                           placeholder='請依上圖輸入(不分大小寫)' required> </p>
	                           
				<p><label class="register_form">&nbsp;</label><input class='button' type="submit" value="修改"  style="width:177px;height:30px;"></p>
				
				
				
			
	 		</form>
	 	</div>
	</div>
	
	<%@ include file="/subview/footer.jsp" %>
</body>
	<script type="text/javascript" src="left.js"></script>
</html>