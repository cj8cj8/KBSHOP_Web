<%@ page pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
	<head>
		<link href="style/vgb.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta charset="UTF-8">
		<title>會員登入</title>
		<style>
article{
padding-top: 20px;
}
article div{


display: flex;
align-items: center;
justify-content: center;

}
#member_login{
width:80%;
display: flex;
align-items: center;
justify-content: center;
height: 70VH;
}
#member_login_1{
	height:472px;
	weight:420px;
	
	flex-grow: 1;
	display:flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start;
	
}
#member_login_2{
	height:472px;
	weight:420px;
	border:1px solid black;
	flex-grow: 1;
	display:flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start;
}
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
			function displayPassword(thisCheckBox){
				console.log(thisCheckBox.checked); //for test
				if(thisCheckBox.checked){
					pwd.type='text';
				}else{
					pwd.type='password';
				}				
			}
			function refreshCaptcha() {
				console.log(captcha_Image.src);
				captcha_Image.src='images/captcha.png?refreshCaptcha='+new Date();
			}
		</script>
	</head>
	<body>
		<jsp:include page="/subview/header.jsp" >
			<jsp:param value="" name="subheader"/>			
		</jsp:include> 
		<%@ include file="/subview/leftmenu.jsp" %>
		
		
		<%
		
		List<String>errorList=(List<String>)request.getAttribute("errorMsg");

		%>
		
		
		<article>
		
			<div>
		
			<div id="member_login">
				<div id="member_login_1">
					<h2>會員登入</h2>				
					<hr  style="border: 1px solid red; width:35%;"/>
					<form id='memberForm' method='POST' action='login.do'>
					<div class='errorMsg'><%=errorList!=null?errorList:""%></div>
					<div>
						
				
						
					</div>
					
					<p>
					<label class="register_form" for='id'>帳號:</label>
					<input type='text' id='id' name='id' placeholder="請輸入id或email" autocomplete="off" required>
					<!--  <input type="checkbox" name="auto" value='ON' ${cookie.auto.value}/>記住我的帳號-->
					</p>
					<p>
					<label class="register_form" for='pwd'>密碼:</label>
					<input type='password' id='pwd' name='password' placeholder="請輸入密碼" autocomplete="off" required>
					<input type='checkbox' id='changePwdStatus' onchange="displayPassword(this)"><label>顯示密碼</label>
					</p>
					
					<p>
					<label class="register_form" for='captcha'>驗證碼:</label>
					<input type='text' id='captcha' name='captcha' placeholder="請輸入驗證碼" required autocomplete="off">
					
					</p>
					<p>
					<label class="register_form" >&nbsp;</label>
					<a href='javascript:refreshCaptcha()'>
					<img id='captcha_Image' src='images/captcha.png' style='vertical-align:middle;'title='點擊更新驗證碼'>
					</a>
					</p>
					<p>
					<label class="register_form" >&nbsp;</label>
					<a href='<%=request.getContextPath() %>'>
					<input type="button" value="忘記密碼" style="width:88px;height:24px;background-color:white; font-size: 18px;border:none;text-align: center;">
					</a>
					&nbsp;
					<a href='<%=request.getContextPath() %>/register.jsp' style='font-size: 18px'>
					註冊
					</a>
					</p>
					
					<p>
					<label class="register_form" >&nbsp;</label>
					<input class='button'type="submit" value="登入" style="width:177px;height:30px; font-size: 18px;text-align: center;border-radius: 12px;">
					</p>
					
					</form>
				</div>
					
		<!-- 		<div id="member_login_2">
					<h2>立即成為會員</h2>				
					<hr  style="border: 1px solid red; width:80%;"/>
					<form action=""  method="POST">
				
					<div>
					<a href="register.html"><input type="button" value="會員註冊" style="width:100px;hieght:50px;"></a>
					</div>
					</form>
				</div>-->
			</div>
		</div>
		</article>
		<%@ include file="/subview/footer.jsp" %>
		
	</body>
	<script type="text/javascript" src="left.js"></script>
</html>