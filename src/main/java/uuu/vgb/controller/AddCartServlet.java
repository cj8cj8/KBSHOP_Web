package uuu.vgb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Product;
import uuu.vgb.entity.ShoppingCart;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.ProductService;

/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/AddCart.do")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errorList=new ArrayList<>();
		HttpSession session =request.getSession();
		//1.讀取requset的Form Data: productId,type,size,quantity
		String productId=request.getParameter("productId");
		String productType=request.getParameter("kbtype");
		String productSize=request.getParameter("productSize");
		String quantity=request.getParameter("quantity");
		System.out.printf("id:%s,type:%s,size:%s,quantity:%s",
				productId,productType,productSize,quantity);
		
		if(productId==null) {
			errorList.add("沒有產品ID無法加入購物車");
		}
		if(quantity==null||!quantity.matches("\\d+")) {
			errorList.add("quantity必須是整數:"+quantity);
		}
		
		//2.執行商業邏輯
		if(errorList.isEmpty()) {
			ProductService productService=new ProductService();
			try{
				Product p=productService.getProductById(productId);
				if(p!=null) {
						int qty=Integer.parseInt(quantity);
						
					  Integer type = (productType!=null?Integer.valueOf(productType):null);
					  Integer size = (productSize!=null?Integer.valueOf(productSize):null);
					if(qty>0) {
						ShoppingCart cart=(ShoppingCart)session.getAttribute("cart");
						if(cart==null) {
							cart=new ShoppingCart();
							session.setAttribute("cart", cart);
						}
						
						cart.add(p, type,size, qty);
					}else {
						errorList.add("加入購物車時數量不得小於0"+p.getName()+qty);
					}
				}else{
					errorList.add("加入購物車時查無此產品"+productId);
				}
			}catch (VGBException e) {
				this.log(e.getMessage(),e);
			}catch(Exception e) {
				this.log("發生非預期錯誤:"+e);
			}
		}
		if(errorList.size()>0) {
			this.log("加入購物車發生錯誤:\n"+errorList.toString());
		}
		String ajax=request.getParameter("ajax");
		if(ajax!=null) {
			//3收到非同步請求forward到/small_cart.jsp
			request.getRequestDispatcher("/member/small_shoppingCart.jsp").forward(request,response);
		}else {			
			//3收到同步請求.rediect/membert/cart.jsp
			response.sendRedirect(request.getContextPath()+"/member/shoppingCart.jsp");
		
		}
		
				
		
	}

}
