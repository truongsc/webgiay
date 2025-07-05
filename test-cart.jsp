<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test Cart</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; }
        .error { color: red; }
        .success { color: green; }
        .info { color: blue; }
    </style>
</head>
<body>
    <h1>Test Cart Functionality</h1>
    
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
        <h2>2. Test DAO Methods</h2>
        <%
        try {
            dao.DAO dao = new dao.DAO();
            
            // Test getAllProduct
            java.util.List<entity.product> products = dao.getAllProduct();
            out.println("<p class='success'>✓ getAllProduct: " + products.size() + " products found</p>");
            
            // Test getAllCart
            java.util.List<entity.cart> carts = dao.getAllCart();
            out.println("<p class='success'>✓ getAllCart: " + carts.size() + " cart items found</p>");
            
            // Test getCartByAccountID
            java.util.List<entity.cart> userCarts = dao.getCartByAccountID(1);
            out.println("<p class='success'>✓ getCartByAccountID(1): " + userCarts.size() + " items found</p>");
            
        } catch (Exception e) {
            out.println("<p class='error'>✗ DAO test failed: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>3. Test Session</h2>
        <%
        HttpSession session = request.getSession();
        entity.account acc = (entity.account) session.getAttribute("accountss");
        if (acc != null) {
            out.println("<p class='success'>✓ User logged in: " + acc.getUser() + " (ID: " + acc.getId() + ")</p>");
        } else {
            out.println("<p class='info'>ℹ No user logged in</p>");
        }
        
        java.util.List<entity.cart> guestCart = (java.util.List<entity.cart>) session.getAttribute("cart_guest");
        if (guestCart != null) {
            out.println("<p class='success'>✓ Guest cart found: " + guestCart.size() + " items</p>");
        } else {
            out.println("<p class='info'>ℹ No guest cart in session</p>");
        }
        %>
    </div>
    
    <div class="test-section">
        <h2>4. Test Add to Cart</h2>
        <form action="AddtocartControl" method="post">
            <p>Product ID: <input type="text" name="pid" value="1" required></p>
            <p>User ID: <input type="text" name="uid" value="1" required></p>
            <p>Amount: <input type="text" name="amount" value="1" required></p>
            <p>Color: <input type="text" name="color" value="Đen" required></p>
            <p>Size: <input type="text" name="size" value="40" required></p>
            <input type="submit" value="Test Add to Cart">
        </form>
    </div>
    
    <div class="test-section">
        <h2>5. Test Cart Control</h2>
        <p><a href="CartControl" target="_blank">Test CartControl Servlet</a></p>
    </div>
    
    <div class="test-section">
        <h2>6. Test Direct Cart Page</h2>
        <p><a href="cart.jsp" target="_blank">Test cart.jsp directly</a></p>
    </div>
    
    <div class="test-section">
        <h2>7. Server Info</h2>
        <p>Server: <%= application.getServerInfo() %></p>
        <p>Servlet Version: <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></p>
        <p>JSP Version: <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %></p>
    </div>
</body>
</html> 