<%@page import="dao.DAO"%>
<%@page import="entity.feedback"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Feedback Simple</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>Debug Feedback - Test Direct Insert</h2>
    
    <%
        String action = request.getParameter("action");
        DAO dao = new DAO();
        
        if ("insert".equals(action)) {
            try {
                out.println("<h3>Thử insert feedback trực tiếp...</h3>");
                
                // Insert feedback test
                dao.insertFeedback(1, 1, "Test feedback direct", 5);
                out.println("<p class='success'>✓ Insert thành công!</p>");
                
            } catch (Exception e) {
                out.println("<p class='error'>✗ Lỗi: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
        
        try {
            // Hiển thị tất cả feedback
            out.println("<h3>Danh sách feedback hiện có:</h3>");
            List<feedback> allFeedback = dao.getAllFeedback();
            
            if (allFeedback.size() > 0) {
                out.println("<table border='1'>");
                out.println("<tr><th>ID</th><th>UID</th><th>Invoice ID</th><th>Content</th><th>Rating</th><th>Created At</th></tr>");
                
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
            } else {
                out.println("<p>Chưa có feedback nào trong database.</p>");
            }
            
        } catch (Exception e) {
            out.println("<p class='error'>Lỗi đọc feedback: " + e.getMessage() + "</p>");
        }
    %>
    
    <hr>
    <h3>Test Actions:</h3>
    <p><a href="debug-simple.jsp?action=insert">Thử insert feedback test</a></p>
    <p><a href="debug-simple.jsp">Refresh để xem feedback</a></p>
    <p><a href="PaymentHistoryControl">Quay lại Payment History</a></p>
    
</body>
</html> 