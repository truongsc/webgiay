<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="context.DBContext"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test Database Connection</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .test-form { background: #f9f9f9; padding: 20px; border-radius: 5px; margin: 20px 0; }
        input[type="text"], input[type="password"] { padding: 8px; margin: 5px; width: 200px; }
        input[type="submit"] { padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>🔧 Test Database Connection & Login System</h1>
    
    <%
    try {
        // Test connection
        Connection conn = DBContext.getConnection();
        out.println("<p class='success'>✅ Database connection successful!</p>");
        
        // Test account table
        String query = "SELECT * FROM account LIMIT 10";
        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        
        out.println("<h2>📋 Account Table Data:</h2>");
        out.println("<table>");
        out.println("<tr><th>ID</th><th>Username</th><th>Password</th><th>isSell</th><th>isAdmin</th></tr>");
        
        int count = 0;
        while(rs.next()) {
            count++;
            out.println("<tr>");
            out.println("<td>" + rs.getInt("id") + "</td>");
            out.println("<td>" + rs.getString("user") + "</td>");
            out.println("<td>" + rs.getString("pass") + "</td>");
            out.println("<td>" + rs.getInt("isSell") + "</td>");
            out.println("<td>" + rs.getInt("isAdmin") + "</td>");
            out.println("</tr>");
        }
        
        out.println("</table>");
        out.println("<p>Total accounts found: " + count + "</p>");
        
        if (count == 0) {
            out.println("<p class='error'>⚠️ No accounts found! Please run the SQL script to create sample accounts.</p>");
        }
        
        // Test specific login
        String testUser = "admin";
        String testPass = "admin";
        
        String loginQuery = "SELECT * FROM account WHERE user = ? AND pass = ?";
        PreparedStatement loginPs = conn.prepareStatement(loginQuery);
        loginPs.setString(1, testUser);
        loginPs.setString(2, testPass);
        ResultSet loginRs = loginPs.executeQuery();
        
        out.println("<h2>🧪 Test Login for user: " + testUser + "</h2>");
        if(loginRs.next()) {
            out.println("<p class='success'>✅ Login successful for user: " + testUser + "</p>");
            out.println("<p>Account ID: " + loginRs.getInt("id") + "</p>");
        } else {
            out.println("<p class='error'>❌ Login failed for user: " + testUser + "</p>");
            out.println("<p>This account doesn't exist or password is wrong.</p>");
        }
        
        rs.close();
        ps.close();
        loginRs.close();
        loginPs.close();
        conn.close();
        
    } catch(Exception e) {
        out.println("<p class='error'>❌ Database connection failed!</p>");
        out.println("<p><strong>Error:</strong> " + e.getMessage() + "</p>");
        out.println("<h3>Possible solutions:</h3>");
        out.println("<ul>");
        out.println("<li>Make sure MySQL is running</li>");
        out.println("<li>Check if database 'web_giay' exists</li>");
        out.println("<li>Verify username/password in DBContext.java</li>");
        out.println("<li>Check if MySQL driver is in classpath</li>");
        out.println("</ul>");
        e.printStackTrace();
    }
    %>
    
    <div class="test-form">
        <h2>🔐 Test Login Form</h2>
        <form action="LoginControl" method="post">
            <label>Username:</label><br>
            <input type="text" name="user" value="admin" placeholder="Enter username"><br><br>
            <label>Password:</label><br>
            <input type="password" name="pass" value="admin" placeholder="Enter password"><br><br>
            <input type="submit" value="Test Login">
        </form>
    </div>
    
    <div class="test-form">
        <h2>📝 Sample Accounts to Test:</h2>
        <ul>
            <li><strong>Admin:</strong> username: admin, password: admin</li>
            <li><strong>User:</strong> username: user1, password: 123456</li>
            <li><strong>Seller:</strong> username: seller1, password: seller123</li>
        </ul>
    </div>
    
    <div class="test-form">
        <h2>🔧 Database Setup Instructions:</h2>
        <ol>
            <li>Make sure MySQL is running</li>
            <li>Create database: <code>CREATE DATABASE web_giay;</code></li>
            <li>Run the SQL script: <code>create_sample_accounts.sql</code></li>
            <li>Check if table 'account' has data</li>
        </ol>
    </div>
</body>
</html> 