<%@page import="java.time.LocalDate"%>

<%@page import="uuu.vgb.entity.Order"%>

<%@page import="uuu.vgb.service.OrderService"%>

<%@page import="uuu.vgb.entity.Customer"%>

<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

    <head>

       <meta name="viewport" content="width=device-width, initial-scale=1.0">

       <link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">

       <title>通知已轉帳</title>

    </head>

    <body>

       <jsp:include page="/subview/header.jsp" >

           <jsp:param value="通知已轉帳" name="subheader"/>

       </jsp:include>

      

   
       <article>

       <%

        String orderId=request.getParameter("orderId");

        OrderService oService = new OrderService();
		
        Customer member=(Customer)session.getAttribute("member");
        Order order = null;

        if(member!=null && orderId!=null){

             order = oService.getOrderDetail(member.getId(), orderId);

        }

        %>

 

        <article>

 

        <%if(order==null){ %>

            <p>查無此訂單</p>

        <%}else{%>       

            ${requestScope.errors}

            <form action="<%=request.getContextPath() %>/member/atm_transfered.do" method="POST">

                <p>

                    <label>訂單編號:</label>                   

                    <input readonly name="orderId" value="<%= orderId %>">

                </p>

                <p>

                    <label>轉帳銀行:</label>

                    <input required name="bank" placeholder="請輸入轉帳銀行名稱" value="${param.bank}">

                </p>

                <p>

                    <label>帳號後5碼:</label>

                    <input required name="last5Code" placeholder="請輸入轉帳帳號後5碼" value="${param.last5Code}">

                </p>

                <p>

                    <label>轉帳金額:</label>

                    <input required type="number" min="1" name="amount"

                       value="<%= request.getParameter("amount")==null?order.getTotalAmountWithFee():request.getParameter("amount") %>" >

                </p>

                <p>

                    <label>轉帳日期:</label>

                    <input type="date" required name="date" min="<%= order.getCreatedDate() %>" max="<%= LocalDate.now() %>" value="${param.date}">

                    <label>時間:</label><input  type="time" required name="time" value="${param.time}">

                </p>        

                <input type="reset" value="還原"/>

                <input type="submit" value="確定"/>

            </form>

        <%}%>                

       </article>

    

    </body>

</html>