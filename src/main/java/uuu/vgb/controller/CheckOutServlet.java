package uuu.vgb.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;
import uuu.vgb.entity.Order;
import uuu.vgb.entity.PaymentType;
import uuu.vgb.entity.ShippingType;
import uuu.vgb.entity.ShoppingCart;
import uuu.vgb.exception.StockShortageException;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.MailService;
import uuu.vgb.service.OrderService;

/**
 * Servlet implementation class CheckOutServlet
 */
@WebServlet("/member/checkout.do")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOutServlet() {
        super();
       
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession();
		Customer member=(Customer)session.getAttribute("member");
		ShoppingCart cart=(ShoppingCart)session.getAttribute("cart");
		
		if(cart==null||cart.isEmpty()) {
			response.sendRedirect("shoppingCart.jsp");
			return;
		}
		List<String> errorsList=new ArrayList<>();
		//取得request中的Form Data
		String paymentType = request.getParameter("paymentType");
		String shippingType = request.getParameter("shippingType");
		String recipientName = request.getParameter("recipientName");
		String recipientEmail = request.getParameter("recipientEmail");
		String recipientPhone = request.getParameter("recipientPhone");
		String shippingAddress = request.getParameter("shippingAddress"); 
	
		PaymentType pType = null;
		ShippingType shType = null;
		if(paymentType==null || paymentType.length()==0
				|| shippingType==null || shippingType.length()==0) {
			errorsList.add("必須選擇付款方式/貨運方式");
		}else {
			try {
				pType = PaymentType.valueOf(paymentType);				
			}catch(RuntimeException e) {
				errorsList.add("付款方式不正確: " + paymentType);
			}
			
			try {
				shType = ShippingType.valueOf(shippingType);
			}catch(RuntimeException e) {
				errorsList.add("貨運方式不正確: " + shippingType);
			}
		}
		if(recipientName==null || (recipientName=recipientName.trim()).length()==0) {
			errorsList.add("必須輸入收件人姓名");
		}
		
		if(recipientEmail==null || (recipientEmail=recipientEmail.trim()).length()==0) {
			errorsList.add("必須輸入收件人Email");
		}
		
		if(recipientPhone==null || (recipientPhone=recipientPhone.trim()).length()==0) {
			errorsList.add("必須輸入收件人電話");
		}
		
		if(shippingAddress==null || (shippingAddress=shippingAddress.trim()).length()==0) {
			errorsList.add("必須輸入收件地址");
		}
		
		//2.若無誤則呼叫商業邏輯
		if(errorsList.isEmpty()) {
			Order order = new Order();
			order.setMember(member);
			order.add(cart);			
			order.setCreatedDate(LocalDate.now());
			order.setCreatedTime(LocalTime.now());
		
			order.setPaymentType(pType);
			order.setPaymentFee(pType.getFee());
			order.setShippingType(shType);
			order.setShippingFee(shType.getFee());
			order.setRecipientName(recipientName);
			order.setRecipientEmail(recipientEmail);
			order.setRecipientPhone(recipientPhone);
			order.setShippingAddres(shippingAddress);
			
			OrderService oService = new OrderService();
			try {
				oService.createOrder(order);
				MailService.sendOrderMail(member.getEmail(),order.getId(),order.getTotalAmountWithFee(),LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
				//3.1 成功:redirect to orders_history.jsp
				session.removeAttribute("cart");
				  if (order.getPaymentType() == PaymentType.CARD) {
					  	System.out.println("測試信用卡");
		               request.setAttribute("order", order);

		               request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);

		               return;

		            }
				response.sendRedirect( request.getContextPath() + "/member/order_history.jsp");
				return;
			} catch (StockShortageException e) {
				this.log(e.getMessage(),e);
				errorsList.add(e.toString());
				session.setAttribute("stockError", errorsList);
				response.sendRedirect( request.getContextPath() + "/member/shoppingCart.jsp");
				return;
			} catch (VGBException e) {
				this.log(e.getMessage(),e);
				errorsList.add(e.getMessage());
			} catch (Exception e) {
				this.log("建立訂單發生非預期錯誤",e);
				errorsList.add("建立訂單發生錯誤:" + e);
			}
		}
		//3.2 失敗:forward to /member/check_out.jsp
		   request.setAttribute("errorList", errorsList);

		      System.out.println(errorsList); //for test

		   request.getRequestDispatcher("checkout.jsp").forward(request, response);

		      return;
	
	
	}

}
