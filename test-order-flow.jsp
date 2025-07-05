<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test Order Flow</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; }
        .error { color: red; }
        .success { color: green; }
        .info { color: blue; }
        .btn { padding: 10px 20px; margin: 5px; background: #007bff; color: white; border: none; cursor: pointer; }
        .btn:hover { background: #0056b3; }
    </style>
</head>
<body>
    <h1>Test Order Flow</h1>
    
    <div class="test-section">
        <h2>1. Test Database Connection</h2>
        <%
        try {
            context.DBContext db = new context.DBContext();
            java.sql.Connection conn = db.getConnection();
            out.println("<p class='success'>✓ Database connection successful</p>");
            conn.close();
        } catch (Exception e) {
            out.println("<p class='error'>✗ Database connection failed: " + e.getMessage() + "</p>");
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>2. Test Session</h2>
        <%
        HttpSession session = request.getSession();
        entity.account acc = (entity.account) session.getAttribute("accountss");
        if (acc != null) {
            out.println("<p class='success'>✓ User logged in: " + acc.getUser() + " (ID: " + acc.getId() + ")</p>");
        } else {
            out.println("<p class='info'>ℹ No user logged in</p>");
        }
        
        String selectedItems = (String) session.getAttribute("selectedItems");
        if (selectedItems != null) {
            out.println("<p class='success'>✓ Selected items in session: " + selectedItems.substring(0, Math.min(100, selectedItems.length())) + "...</p>");
        } else {
            out.println("<p class='info'>ℹ No selected items in session</p>");
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>3. Test Cart Data</h2>
        <%
        try {
            dao.DAO dao = new dao.DAO();
            if (acc != null) {
                java.util.List<entity.cart> cartItems = dao.getCartByAccountID(acc.getId());
                out.println("<p class='success'>✓ Cart items: " + cartItems.size() + "</p>");
                
                for (entity.cart item : cartItems) {
                    entity.product p = dao.getProductByid(String.valueOf(item.getProductID()));
                    if (p != null) {
                        out.println("<p class='info'>- " + p.getName() + " (ID: " + item.getProductID() + 
                                  ", Amount: " + item.getAmount() + ", Color: " + item.getColor() + 
                                  ", Size: " + item.getSize() + ", Price: đ" + String.format("%,.0f", p.getPrice() * 1000) + ")</p>");
                    }
                }
            } else {
                out.println("<p class='info'>ℹ No user logged in, cannot check cart</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>✗ Error checking cart: " + e.getMessage() + "</p>");
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>4. Test Invoice Data</h2>
        <%
        try {
            dao.DAO dao = new dao.DAO();
            if (acc != null) {
                java.util.List<entity.invoice> invoices = dao.getInvoicebyID(acc.getId());
                out.println("<p class='success'>✓ User invoices: " + invoices.size() + "</p>");
                
                for (entity.invoice inv : invoices) {
                    out.println("<p class='info'>- Invoice ID: " + inv.getIvid() + 
                              ", Date: " + inv.getDate() + 
                              ", Total: " + inv.getTotal() + 
                              ", Status: " + inv.getStatus() + "</p>");
                }
            } else {
                out.println("<p class='info'>ℹ No user logged in, cannot check invoices</p>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>✗ Error checking invoices: " + e.getMessage() + "</p>");
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>5. Test Actions</h2>
        <p><a href="CartSimpleControl" class="btn">Test Cart Simple</a></p>
        <p><a href="CartControl" class="btn">Test Cart Control</a></p>
        <p><a href="checkout.jsp" class="btn">Test Checkout Page</a></p>
        <p><a href="PaymentHistoryControl" class="btn">Test Payment History</a></p>
    </div>
    
    <div class="test-section">
        <h2>6. Test Order Creation</h2>
        <form action="PaymentControl" method="post">
            <p>Date: <input type="text" name="date" value="2024-12-19" required></p>
            <p>Description: <input type="text" name="description" value="Test order" required></p>
            <p>Total Price: <input type="text" name="totalPrice" value="1000" required></p>
            <p>Receiver Name: <input type="text" name="receiverName" value="Test User" required></p>
            <p>Receiver Phone: <input type="text" name="receiverPhone" value="0123456789" required></p>
            <p>Receiver Address: <input type="text" name="receiverAddress" value="Test Address" required></p>
            <p>Receiver City: <input type="text" name="receiverCity" value="Ho Chi Minh" required></p>
            <p>Receiver District: <input type="text" name="receiverDistrict" value="District 1" required></p>
            <p>Payment Method: 
                <select name="paymentMethod" required>
                    <option value="cod">Thanh toán khi nhận hàng</option>
                    <option value="bank">Chuyển khoản ngân hàng</option>
                    <option value="momo">Ví MoMo</option>
                </select>
            </p>
            <input type="submit" value="Test Create Order" class="btn">
        </form>
    </div>
    
    <div class="test-section">
        <h2>7. Server Info</h2>
        <p>Server: <%= application.getServerInfo() %></p>
        <p>Servlet Version: <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></p>
        <p>JSP Version: <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %></p>
    </div>
</body>
</html> 