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
import uuu.vgb.exception.VGBDataInvalidException;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.CustomerService;
import uuu.vgb.view.CaptchaServlet;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns = "/register.do",loadOnStartup = 1)//RESTful
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.取得request的Form data(mod10),
		List<String> REGerrorList=new ArrayList<>();		
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("userid");
		String name=request.getParameter("name");
		String password1=request.getParameter("password1");
		String password2=request.getParameter("password2");	
		String gender=request.getParameter("gender");
		String email=request.getParameter("email");
		String birthday=request.getParameter("birthday");
		String address=request.getParameter("address");
		String phone=request.getParameter("phone");
		String captcha=request.getParameter("captcha");
		
			if(id==null||(id=id.trim()).length()==0) {
				REGerrorList.add("必須輸入帳號");
			}
			if(password1==null||(password1=password1.trim()).length()==0) {
				REGerrorList.add("必須輸入密碼");
			}
			if(password2==null||!password2.equals(password1)) {
				REGerrorList.add("密碼與確認密碼必須輸入一致");
			}
			if(gender==null) {
				REGerrorList.add("必須選擇性別");
			}
			if(email==null) {
				REGerrorList.add("必須輸入email");
			}
			if(phone==null) {
				REGerrorList.add("必須輸入正確的手機格式");
			}
			HttpSession session=request.getSession();

			if(captcha==null) {
				REGerrorList.add("必須輸入驗證碼");
			}else {
				String oldCaptcha=(String)session.getAttribute("RegisterCaptchaServlet");
				if(!captcha.equals(oldCaptcha)) {
					REGerrorList.add("驗證碼輸入錯誤");
				}	
				
			}
			session.removeAttribute("RegisterCaptchaServlet");
			System.out.println(id);
				//2.無誤呼叫商業邏輯
			if(REGerrorList.isEmpty()) {
				
				try {
					//3.1產生登入成功 for user
					Customer c= new Customer();
					c.setId(id);
					c.setName(name);
					c.setPassword(password1);					
					c.setGender(gender.charAt(0));
					c.setEmail(email);	
					c.setPhone(phone);
					c.setBirthday(birthday);		
					c.setAddress(address);
					c.setSubscribed(true);	
				
					CustomerService service=new CustomerService();
				
					service.register(c);
					
					request.setAttribute("Register_member", c);
					RequestDispatcher dispatcher=request.getRequestDispatcher("register_ok.jsp");
					dispatcher.forward(request, response);
					try(PrintWriter out =response.getWriter();){
						out.println("<html>");
						
						out.println("<head>");
						out.println("<meta http-equiv=\"refresh\" content=\"3;url=index.html\">");

						out.println("<title>註冊成功</title>");
						out.println("</head>");
						out.println("<body>");
						out.println("<h2>註冊成功</h2>");

						out.println("<p>3秒後將自動跳轉<a href='index.html'>首頁</a></p>");
						out.println("</body>");
						out.println("</html>");

					}
				
					return;
				} catch (VGBDataInvalidException e) {	
					REGerrorList.add(e.getMessage());
				} catch (VGBException e) {			
					//將商業邏輯log在console
					this.log(e.getMessage(),e);			//for admin
					REGerrorList.add(e.getMessage()+",請檢查是否輸入有誤或請聯絡管理人員");
				}catch (Exception e) {
					this.log("系統發生錯誤",e);			//for admin
					REGerrorList.add("系統發生錯誤:"+e);
				}
			}
			//3.2將錯誤顯示在網頁上
			
			request.setAttribute("REGerrorMsg", REGerrorList);
			RequestDispatcher dispatcher=request.getRequestDispatcher("register.jsp");
			dispatcher.forward(request, response);
			
			
			
	}

}
