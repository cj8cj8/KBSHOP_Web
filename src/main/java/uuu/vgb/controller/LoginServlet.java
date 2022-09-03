package uuu.vgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;
import uuu.vgb.exception.LoginFailedException;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns = "/login.do",loadOnStartup = 1)//RESTful
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.取得request的Form data(mod10),
		List<String> errorList=new ArrayList<>();		
		HttpSession session=request.getSession();
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		String captcha=request.getParameter("captcha");
			if(id==null||(id=id.trim()).length()==0) {
				errorList.add("必須輸入帳號");
			}
			if(password==null||(password=password.trim()).length()==0) {
				errorList.add("必須輸入密碼");
			}
			if(captcha==null||(captcha=captcha.trim()).length()==0) {
				errorList.add("必須輸入驗證碼");
			}else {
				String oldCaptcha=(String)session.getAttribute("LoginCaptchaServlet");
				if(!captcha.equals(oldCaptcha)) {
					errorList.add("驗證碼輸入錯誤");
				}
			}
			session.removeAttribute("LoginCaptchaServlet");
				//2.無誤呼叫商業邏輯
			if(errorList.isEmpty()) {
				CustomerService service=new CustomerService();
				try {
					
					//3.1內部轉交(forward)產生登入成功(login_ok.jsp) for user(mod09)
					Customer c=service.login(id, password);
					//session.setMaxInactiveInterval(20);//sec
					session.setAttribute("member", c);
					
					String prevURI = (String)session.getAttribute("login.prev.uri");
					session.removeAttribute("login.prev.uri");
					if(prevURI!=null) request.setAttribute("login.prev.uri", prevURI);
					//3.1 內部轉交(forward)登入成功網頁(login_ok.jsp), for user, (mod09) 			
					request.getRequestDispatcher("/login_ok.jsp").forward(request, response);
					
					//3.1 外部轉址(redirect)首頁, for user, (mod15)			
					//response.sendRedirect(request.getContextPath());				
					return;
				} catch (LoginFailedException e) {	
					errorList.add(e.getMessage());
				} catch (VGBException e) {			
					//將商業邏輯log在console
					this.log(e.getMessage(),e);			//for admin
					errorList.add(e.getMessage()+",請聯絡管理人員");
				}catch (Exception e) {
					this.log("系統發生錯誤",e);			//for admin
					errorList.add("系統發生錯誤:"+e);
				}
			}
			//3.2內部轉交至登入網頁
			
		request.setAttribute("errorMsg", errorList);
		RequestDispatcher dispatcher=request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
			
	}

}
