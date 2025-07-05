<%@page import="dao.DAO"%>
<%@page import="entity.account"%>
<%@page import="entity.feedback"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Test Feedback Direct</title>
    <style>
        .success { color: green; }
        .error { color: red; }
        .info { color: blue; }
    </style>
</head>
<body>
    <h2>Test Feedback Direct Insert</h2>
    
    <%
        // Lấy session và account
        account acc = (account) session.getAttribute("accountss");
        out.println("<p class='info'>Current user: " + (acc != null ? acc.getUser() + " (ID: " + acc.getId() + ")" : "Not logged in") + "</p>");
        
        String action = request.getParameter("action");
        DAO dao = new DAO();
        
        if ("insert".equals(action)) {
            String invoiceIdStr = request.getParameter("invoiceId");
            String content = request.getParameter("content");
            String ratingStr = request.getParameter("rating");
            
            out.println("<h3>Processing Insert...</h3>");
            out.println("<p>InvoiceId: " + invoiceIdStr + "</p>");
            out.println("<p>Content: " + content + "</p>");
            out.println("<p>Rating: " + ratingStr + "</p>");
            
            if (acc != null && invoiceIdStr != null && content != null && ratingStr != null) {
                try {
                    int invoiceId = Integer.parseInt(invoiceIdStr);
                    int rating = Integer.parseInt(ratingStr);
                    int userId = acc.getId();
                    
                    out.println("<p>Calling dao.insertFeedback(" + userId + ", " + invoiceId + ", '" + content + "', " + rating + ")</p>");
                    
                    dao.insertFeedback(userId, invoiceId, content, rating);
                    out.println("<p class='success'>✓ INSERT THÀNH CÔNG!</p>");
                    
                } catch (Exception e) {
                    out.println("<p class='error'>✗ INSERT LỖI: " + e.getMessage() + "</p>");
                    out.println("<p class='error'>Stack trace: " + e.toString() + "</p>");
                }
            } else {
                out.println("<p class='error'>✗ Missing data or not logged in!</p>");
            }
        }
        
        // Hiển thị tất cả feedback
        try {
            out.println("<h3>Current Feedback in Database:</h3>");
            List<feedback> allFeedback = dao.getAllFeedback();
            
            if (allFeedback.size() > 0) {
                out.println("<table border='1' style='border-collapse: collapse;'>");
                out.println("<tr style='background-color: #f0f0f0;'>");
                out.println("<th>ID</th><th>User ID</th><th>Invoice ID</th><th>Content</th><th>Rating</th><th>Created At</th>");
                out.println("</tr>");
                
                for (feedback fb : allFeedback) {
                    out.println("<tr>");
                    out.println("<td>" + fb.getId() + "</td>");
                    out.println("<td>" + fb.getUid() + "</td>");
                    out.println("<td>" + fb.getInvoice_id() + "</td>");
                    out.println("<td>" + fb.getContent() + "</td>");
                    out.println("<td>" + fb.getRating() + "</td>");
                    out.println("<td>" + fb.getCreated_at() + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                out.println("<p class='info'>Total feedback records: " + allFeedback.size() + "</p>");
            } else {
                out.println("<p class='info'>No feedback records found in database.</p>");
            }
            
        } catch (Exception e) {
            out.println("<p class='error'>Error reading feedback: " + e.getMessage() + "</p>");
        }
    %>
    
    <hr>
    <h3>Test Insert Form:</h3>
    <% if (acc != null) { %>
        <form method="post">
            <input type="hidden" name="action" value="insert">
            Invoice ID: <input type="number" name="invoiceId" value="1" required><br><br>
            Content: <textarea name="content" required>Test feedback từ JSP direct</textarea><br><br>
            Rating: <select name="rating" required>
                <option value="1">1 sao</option>
                <option value="2">2 sao</option>
                <option value="3">3 sao</option>
                <option value="4">4 sao</option>
                <option value="5" selected>5 sao</option>
            </select><br><br>
            <button type="submit">Insert Feedback</button>
        </form>
    <% } else { %>
        <p class='error'>Please login first to test feedback insert.</p>
        <a href="login.jsp">Login</a>
    <% } %>
    
    <hr>
    <p><a href="test-feedback-direct.jsp">Refresh</a></p>
    <p><a href="PaymentHistoryControl">Go to Payment History</a></p>
    
</body>
</html> 