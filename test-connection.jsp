<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="context.DBContext"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test Database Connection</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .success { color: #28a745; font-weight: bold; background: #d4edda; padding: 10px; border-radius: 4px; margin: 10px 0; }
        .error { color: #dc3545; font-weight: bold; background: #f8d7da; padding: 10px; border-radius: 4px; margin: 10px 0; }
        .info { color: #17a2b8; background: #d1ecf1; padding: 10px; border-radius: 4px; margin: 10px 0; }
        .step { background: #e9ecef; padding: 15px; border-radius: 4px; margin: 10px 0; border-left: 4px solid #007bff; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f8f9fa; }
        .btn { background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; margin: 5px; }
        .btn:hover { background: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 Test Database Connection - WEBGIAY</h1>
        
        <div class="step">
            <h3>📋 Thông tin kết nối:</h3>
            <p><strong>URL:</strong> jdbc:mysql://localhost:3306/web_giay</p>
            <p><strong>Username:</strong> root</p>
            <p><strong>Password:</strong> 23082004</p>
        </div>

        <%
        Connection conn = null;
        try {
            // Test 1: Kết nối database
            out.println("<div class='info'>🔄 Đang thử kết nối database...</div>");
            conn = DBContext.getConnection();
            out.println("<div class='success'>✅ Kết nối database thành công!</div>");
            
            // Test 2: Kiểm tra database web_giay
            out.println("<div class='info'>🔄 Đang kiểm tra database 'web_giay'...</div>");
            String dbQuery = "SELECT DATABASE() as current_db";
            PreparedStatement dbPs = conn.prepareStatement(dbQuery);
            ResultSet dbRs = dbPs.executeQuery();
            if (dbRs.next()) {
                String currentDb = dbRs.getString("current_db");
                if ("web_giay".equals(currentDb)) {
                    out.println("<div class='success'>✅ Đang sử dụng database: " + currentDb + "</div>");
                } else {
                    out.println("<div class='error'>❌ Đang sử dụng database: " + currentDb + " (không phải web_giay)</div>");
                }
            }
            dbRs.close();
            dbPs.close();
            
            // Test 3: Kiểm tra bảng account
            out.println("<div class='info'>🔄 Đang kiểm tra bảng 'account'...</div>");
            String tableQuery = "SHOW TABLES LIKE 'account'";
            PreparedStatement tablePs = conn.prepareStatement(tableQuery);
            ResultSet tableRs = tablePs.executeQuery();
            if (tableRs.next()) {
                out.println("<div class='success'>✅ Bảng 'account' tồn tại</div>");
                
                // Test 4: Kiểm tra dữ liệu trong bảng account
                out.println("<div class='info'>🔄 Đang kiểm tra dữ liệu trong bảng account...</div>");
                String dataQuery = "SELECT * FROM account LIMIT 5";
                PreparedStatement dataPs = conn.prepareStatement(dataQuery);
                ResultSet dataRs = dataPs.executeQuery();
                
                out.println("<h3>📊 Dữ liệu bảng account:</h3>");
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Username</th><th>Password</th><th>isSell</th><th>isAdmin</th></tr>");
                
                int count = 0;
                while(dataRs.next()) {
                    count++;
                    out.println("<tr>");
                    out.println("<td>" + dataRs.getInt("id") + "</td>");
                    out.println("<td>" + dataRs.getString("user") + "</td>");
                    out.println("<td>" + dataRs.getString("pass") + "</td>");
                    out.println("<td>" + dataRs.getInt("isSell") + "</td>");
                    out.println("<td>" + dataRs.getInt("isAdmin") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                if (count > 0) {
                    out.println("<div class='success'>✅ Tìm thấy " + count + " tài khoản trong database</div>");
                } else {
                    out.println("<div class='error'>❌ Không có tài khoản nào trong database</div>");
                    out.println("<div class='step'>");
                    out.println("<h4>🔧 Cách khắc phục:</h4>");
                    out.println("<ol>");
                    out.println("<li>Chạy script SQL: <code>setup_database.sql</code></li>");
                    out.println("<li>Hoặc thêm dữ liệu thủ công:</li>");
                    out.println("</ol>");
                    out.println("<pre>INSERT INTO account (user, pass, isSell, isAdmin) VALUES ('admin', 'admin', 1, 1);</pre>");
                    out.println("</div>");
                }
                
                dataRs.close();
                dataPs.close();
                
            } else {
                out.println("<div class='error'>❌ Bảng 'account' không tồn tại</div>");
                out.println("<div class='step'>");
                out.println("<h4>🔧 Cách khắc phục:</h4>");
                out.println("<p>Chạy script SQL để tạo bảng:</p>");
                out.println("<pre>CREATE TABLE account (id INT AUTO_INCREMENT PRIMARY KEY, user VARCHAR(255) NOT NULL UNIQUE, pass VARCHAR(255) NOT NULL, isSell INT DEFAULT 0, isAdmin INT DEFAULT 0);</pre>");
                out.println("</div>");
            }
            tableRs.close();
            tablePs.close();
            
        } catch(Exception e) {
            out.println("<div class='error'>❌ Lỗi kết nối database!</div>");
            out.println("<div class='step'>");
            out.println("<h4>🔍 Chi tiết lỗi:</h4>");
            out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
            out.println("<h4>🔧 Các bước khắc phục:</h4>");
            out.println("<ol>");
            out.println("<li><strong>Kiểm tra MySQL:</strong> Đảm bảo MySQL đang chạy</li>");
            out.println("<li><strong>Kiểm tra database:</strong> Tạo database 'web_giay' nếu chưa có</li>");
            out.println("<li><strong>Kiểm tra thông tin kết nối:</strong> Xem file DBContext.java</li>");
            out.println("<li><strong>Kiểm tra driver:</strong> Đảm bảo MySQL JDBC driver có trong classpath</li>");
            out.println("</ol>");
            out.println("<h4>📝 Lệnh SQL để tạo database:</h4>");
            out.println("<pre>CREATE DATABASE IF NOT EXISTS web_giay;</pre>");
            out.println("</div>");
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    out.println("<div class='info'>🔒 Đã đóng kết nối database</div>");
                } catch (Exception e) {
                    out.println("<div class='error'>❌ Lỗi khi đóng kết nối: " + e.getMessage() + "</div>");
                }
            }
        }
        %>
        
        <div class="step">
            <h3>🔧 Các bước tiếp theo:</h3>
            <a href="login.jsp" class="btn">📝 Test đăng nhập</a>
            <a href="test-database-connection.jsp" class="btn">🔍 Test chi tiết</a>
            <a href="index.jsp" class="btn">🏠 Về trang chủ</a>
        </div>
        
        <div class="step">
            <h3>📋 Tài khoản test (nếu có dữ liệu):</h3>
            <ul>
                <li><strong>Admin:</strong> username=admin, password=admin</li>
                <li><strong>User:</strong> username=user1, password=123456</li>
                <li><strong>Seller:</strong> username=seller1, password=seller123</li>
            </ul>
        </div>
    </div>
</body>
</html> 