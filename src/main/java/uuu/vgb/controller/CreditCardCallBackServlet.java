package uuu.vgb.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uuu.vgb.entity.Customer;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.MailService;
import uuu.vgb.service.OrderService;

/**
 * Servlet implementation class CreditCardCallBackServlet
 */
@WebServlet("/member/credit_card_back.do")
public class CreditCardCallBackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreditCardCallBackServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer member = (Customer) request.getSession().getAttribute("member");

	       // 1. 取得request中的parameter
	       String amount = request.getParameter("amount");
	       String auth_code = request.getParameter("auth_code");
	       String card4no = request.getParameter("card4no");
	       String card6no = request.getParameter("card6no");
	       String merchantTradeNo = request.getParameter("MerchantTradeNo");
	       String process_date = request.getParameter("process_date");
	       String paymentTypeChargeFee = request.getParameter("PaymentTypeChargeFee");    
	       String orderId = (String)request.getSession().getAttribute("credit_card_order_id");
	       request.getSession().removeAttribute("credit_card_order_id");	      
	     
	       // 2. 呼叫商業邏輯
	       OrderService service = new OrderService();
	      
	       try {
		       MailService.sendCreditCardPaymentMail(member.getEmail(),orderId,amount , LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

	           service.updateOrderStatusToPAID(member, orderId, card6no, card4no, auth_code, process_date, amount);// 呼叫前面步驟一完成的修改訂單狀態為已付款的程式
	         
	       } catch (VGBException ex) {
	           this.log("信用卡授權發生錯誤", ex);
	       }
	    
	       response.sendRedirect(request.getContextPath() + "/member/order_history.jsp");
	}

}
