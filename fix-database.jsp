<%@page import="context.DBContext"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fix Database</title>
    <style>
        .success { color: green; }
        .error { color: red; }
        .info { color: blue; }
    </style>
</head>
<body>
    <h2>Fix Feedback Table</h2>
    
    <%
        String action = request.getParameter("action");
        
        if ("fix".equals(action)) {
            Connection conn = null;
            Statement stmt = null;
            
            try {
                out.println("<h3>Fixing feedback table...</h3>");
                
                DBContext db = new DBContext();
                conn = db.getConnection();
                stmt = conn.createStatement();
                
                // Xóa bảng cũ
                out.println("<p>Step 1: Dropping old table...</p>");
                try {
                    stmt.executeUpdate("DROP TABLE IF EXISTS feedback");
                    out.println("<p class='success'>✓ Old table dropped</p>");
                } catch (Exception e) {
                    out.println("<p class='info'>Old table not found (OK)</p>");
                }
                
                // Tạo bảng mới
                out.println("<p>Step 2: Creating new table with AUTO_INCREMENT...</p>");
                String createTable = "CREATE TABLE feedback (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "uid INT NOT NULL, " +
                    "invoice_id INT NOT NULL, " +
                    "content TEXT NOT NULL, " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), " +
                    "INDEX idx_uid (uid), " +
                    "INDEX idx_invoice_id (invoice_id)" +
                    ")";
                
                stmt.executeUpdate(createTable);
                out.println("<p class='success'>✓ New table created successfully!</p>");
                
                // Test insert
                out.println("<p>Step 3: Testing insert...</p>");
                String testInsert = "INSERT INTO feedback (uid, invoice_id, content, rating) VALUES (1, 1, 'Test feedback after fix', 5)";
                stmt.executeUpdate(testInsert);
                out.println("<p class='success'>✓ Test insert successful!</p>");
                
                out.println("<h3 class='success'>✓ Database fixed successfully!</h3>");
                
            } catch (Exception e) {
                out.println("<p class='error'>✗ Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {}
            }
        }
    %>
    
    <hr>
    <h3>Current Problem:</h3>
    <p class='error'>Field 'id' doesn't have a default value</p>
    <p>This means the 'id' column is not set to AUTO_INCREMENT.</p>
    
    <h3>Solution:</h3>
    <p>Click button below to recreate the feedback table with proper AUTO_INCREMENT.</p>
    
    <form method="post">
        <input type="hidden" name="action" value="fix">
        <button type="submit" style="background-color: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px;">
            Fix Feedback Table
        </button>
    </form>
    
    <hr>
    <p><a href="test-feedback-direct.jsp">Test Feedback After Fix</a></p>
    <p><a href="PaymentHistoryControl">Go to Payment History</a></p>
    
</body>
</html> 