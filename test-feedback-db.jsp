<%@page import="dao.DAO"%>
<%@page import="entity.feedback"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Test Feedback Database</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .success { color: green; }
        .error { color: red; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Test Feedback Database Connection</h2>
    
    <%
        DAO dao = new DAO();
        boolean hasError = false;
        String errorMsg = "";
        
        try {
            // Test 1: Lấy tất cả feedback
            out.println("<h3>Test 1: Lấy tất cả feedback</h3>");
            List<feedback> allFeedback = dao.getAllFeedback();
            out.println("<p class='success'>✓ Kết nối database thành công!</p>");
            out.println("<p>Số lượng feedback: " + allFeedback.size() + "</p>");
            
            if (allFeedback.size() > 0) {
                out.println("<table>");
                out.println("<tr><th>ID</th><th>User ID</th><th>Invoice ID</th><th>Content</th><th>Rating</th><th>Created At</th></tr>");
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
            }
            
        } catch (Exception e) {
            hasError = true;
            errorMsg = e.getMessage();
            out.println("<p class='error'>✗ Lỗi kết nối database: " + e.getMessage() + "</p>");
            out.println("<p class='error'>Chi tiết: " + e.toString() + "</p>");
        }
        
        // Test 2: Thử insert một feedback test
        if (!hasError) {
            try {
                out.println("<h3>Test 2: Thử insert feedback test</h3>");
                dao.insertFeedback(1, 1, "Test feedback từ JSP", 5);
                out.println("<p class='success'>✓ Insert feedback thành công!</p>");
                
                // Lấy lại để kiểm tra
                List<feedback> newFeedback = dao.getAllFeedback();
                out.println("<p>Số lượng feedback sau insert: " + newFeedback.size() + "</p>");
                
            } catch (Exception e) {
                out.println("<p class='error'>✗ Lỗi insert feedback: " + e.getMessage() + "</p>");
            }
        }
    %>
    
    <hr>
    <h3>Hướng dẫn:</h3>
    <ol>
        <li>Nếu thấy lỗi "Table 'feedback' doesn't exist" → Chạy SQL script tạo bảng</li>
        <li>Nếu thấy "✓ Kết nối database thành công" → Database OK</li>
        <li>Nếu insert thành công → Hệ thống feedback đã sẵn sàng</li>
    </ol>
    
    <p><a href="PaymentHistoryControl">← Quay lại Payment History</a></p>
</body>
</html> 