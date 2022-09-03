package uuu.vgb.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;import com.mysql.cj.result.ZonedDateTimeValueFactory;

import uuu.vgb.entity.CartItem;
import uuu.vgb.entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/updateCart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errorList=new ArrayList<>();
		HttpSession session =request.getSession();
		ShoppingCart cart=(ShoppingCart)session.getAttribute("cart");
		
				
		if(cart!=null) {
			for(CartItem item:cart.getCartItemSet()) {
				String quantity=request.getParameter("quantity"+item.hashCode());
				String delete=request.getParameter("delete"+item.hashCode());
				
				if(delete==null) {//只修改數量
					if(quantity!=null&&quantity.matches("\\d+")) {
						int qty=Integer.parseInt(quantity);
						cart.update(item, qty);	
					}else {
						errorList.add("quantity不正確"+item.getProductName()+":"+quantity);
					}
					
				}else {//刪除明細
					cart.remove(item);
				}
			}
			
		}
		//3.redirect 回購物車
		String submit=request.getParameter("submit");
		if("checkout".equals(submit)) {
			response.sendRedirect("checkout.jsp");
		}else {
			response.sendRedirect(request.getContextPath() + "/member/shoppingCart.jsp");
		}

}
}