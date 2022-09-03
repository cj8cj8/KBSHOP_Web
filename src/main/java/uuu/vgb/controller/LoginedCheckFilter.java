package uuu.vgb.controller;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
@WebFilter(	urlPatterns = {"/login.jsp", "/register.jsp","/register_ok.jsp","/login_ok.jsp"}, 
			initParams = {@WebInitParam(name = "member", value = "member")}
	)
public class LoginedCheckFilter extends HttpFilter implements Filter { 
    private String member = "member";

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest)request;
		HttpServletResponse httpRes = (HttpServletResponse)response;		
		//強制登入檢查
		HttpSession session = httpReq.getSession();		
		Customer memberObj= (Customer)session.getAttribute(member);
		if(memberObj==null) { //尚未登入
			chain.doFilter(request, response);
		} else {
			session.setAttribute("login.prev.uri", httpReq.getRequestURI());
			//已登入則強迫轉址給首頁
			httpRes.sendRedirect( httpReq.getContextPath()+"/");
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 * @see GenericFilter#init()
	 */
	@Override
	public void init() throws ServletException {		
		String member = this.getInitParameter("member");
		if(member!=null && member.length()>0) this.member = member;
	}
}