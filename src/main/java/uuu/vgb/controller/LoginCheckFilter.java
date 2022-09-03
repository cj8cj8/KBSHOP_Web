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
@WebFilter(
		urlPatterns = { "/member/*" }, 
		initParams = { 
				@WebInitParam(name = "member", value = "member")
		})
public class LoginCheckFilter extends HttpFilter implements Filter {
       private String member="member";
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginCheckFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//Req,Res轉型
		HttpServletRequest httpReq=(HttpServletRequest)request;
		HttpServletResponse httpRes=(HttpServletResponse)response;
		
		HttpSession session=httpReq.getSession();
		//強制登入
		Customer memberObj=(Customer)session.getAttribute(member);
		if(memberObj!=null) {
		chain.doFilter(request, response);
		
		}else {
			session.setAttribute("login.prev.uri", httpReq.getRequestURI());
			httpRes.sendRedirect(httpReq.getContextPath()+"/login.jsp");
		}
	
	}

	/**
	 * @see Filter#init(FilterConfig)
	 * @see GenericFIlter#init()
	 */

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		String member=this.getInitParameter("member");
		if(member!=null&&member.length()>0)this.member=member;
		
		
	}

}
