<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DAO" %>
<%@page import="entity.account" %>
<%@page import="entity.invoice" %>
<%@page import="java.util.List" %>

<%
    // Kiểm tra quyền admin
    account acc = (account) session.getAttribute("accountss");
    if (acc == null || acc.getIsAdmin() != 1) {
        response.sendRedirect("IndexControl");
        return;
    }
    
    DAO dao = new DAO();
    String action = request.getParameter("action");
    String message = "";
    
    // Tạo đơn hàng test
    if ("create_test".equals(action)) {
        try {
            // Tạo 1 đơn hàng test với trạng thái "chờ xác nhận"
            String insertQuery = "INSERT INTO invoice (uid, date, description, total, status) VALUES (1, NOW(), 'Đơn hàng test', 500000, 'Chờ xác nhận')";
            dao.insertInvoiceTest(insertQuery);
            message = "Đã tạo đơn hàng test thành công!";
        } catch (Exception e) {
            message = "Lỗi tạo đơn hàng test: " + e.getMessage();
        }
    }
    
    // Reset tất cả đơn hàng về "chờ xác nhận"
    if ("reset_all".equals(action)) {
        try {
            for (int i = 1; i <= 5; i++) {
                dao.updateInvoiceStatus(i, "Chờ xác nhận");
            }
            message = "Đã reset tất cả đơn hàng về 'chờ xác nhận'!";
        } catch (Exception e) {
            message = "Lỗi reset: " + e.getMessage();
        }
    }
    
    // Test update status trực tiếp
    if ("test_update".equals(action)) {
        String invoiceIdStr = request.getParameter("invoiceId");
        if (invoiceIdStr != null) {
            try {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                System.out.println("DEBUG: Attempting to update invoice " + invoiceId + " to 'Đã xác nhận'");
                dao.updateInvoiceStatus(invoiceId, "Đã xác nhận");
                message = "✅ Test update thành công cho đơn hàng #" + invoiceId;
            } catch (Exception e) {
                message = "❌ Test update thất bại: " + e.getMessage();
                System.err.println("Test update error: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    // Lấy danh sách đơn hàng
    List<invoice> invoiceList = dao.getAllInvoice();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Debug Orders</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container py-5">
        <h2>Debug - Quản lý đơn hàng</h2>
        
        <% if (!message.isEmpty()) { %>
            <div class="alert alert-info"><%= message %></div>
        <% } %>
        
        <!-- Actions -->
        <div class="mb-4">
            <a href="debug-orders.jsp?action=create_test" class="btn btn-primary">Tạo đơn hàng test</a>
            <a href="debug-orders.jsp?action=reset_all" class="btn btn-warning">Reset tất cả về "chờ xác nhận"</a>
            <a href="ordermanagement.jsp" class="btn btn-success">Về trang quản lý chính</a>
        </div>
        
        <!-- Danh sách đơn hàng với debug info -->
        <div class="card">
            <div class="card-header">
                <h5>Danh sách đơn hàng (Debug)</h5>
            </div>
            <div class="card-body">
                <% if (invoiceList == null || invoiceList.isEmpty()) { %>
                    <p class="text-warning">Không có đơn hàng nào trong database!</p>
                <% } else { %>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User ID</th>
                                <th>Date</th>
                                <th>Total</th>
                                <th>Status (Raw)</th>
                                <th>Status Check</th>
                                <th>Action Preview</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (invoice inv : invoiceList) { 
                                String status = inv.getStatus();
                                String statusDisplay = status != null ? status : "NULL";
                                boolean isPending = "Chờ xác nhận".equals(status) || status == null;
                            %>
                                <tr class="<%= isPending ? "table-warning" : "" %>">
                                    <td><%= inv.getIvid() %></td>
                                    <td><%= inv.getUid() %></td>
                                    <td><%= inv.getDate() %></td>
                                    <td><%= inv.getTotal() %></td>
                                    <td>
                                        <code>"<%= statusDisplay %>"</code>
                                        <br>
                                        <small>Length: <%= statusDisplay.length() %></small>
                                        <% if (status != null) { %>
                                            <br><small>Trimmed: "<%= status.trim() %>"</small>
                                            <br><small>Equals: <%= "Chờ xác nhận".equals(status) %></small>
                                            <br><small>Equals (trimmed): <%= "Chờ xác nhận".equals(status.trim()) %></small>
                                            <br><small>Contains: <%= status.contains("Chờ xác nhận") %></small>
                                            <br><small>Bytes: <%= java.util.Arrays.toString(status.getBytes()) %></small>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (status == null) { %>
                                            <span class="badge bg-secondary">NULL</span>
                                        <% } else if ("Chờ xác nhận".equals(status)) { %>
                                            <span class="badge bg-warning">PENDING</span>
                                        <% } else if ("Đã xác nhận".equals(status)) { %>
                                            <span class="badge bg-success">CONFIRMED</span>
                                        <% } else if ("Đã hủy".equals(status)) { %>
                                            <span class="badge bg-danger">CANCELLED</span>
                                        <% } else { %>
                                            <span class="badge bg-info">OTHER: <%= status %></span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (isPending) { %>
                                            <small class="text-success">✅ Sẽ hiện nút Xác nhận/Hủy</small>
                                            <br>
                                            <a href="debug-orders.jsp?action=test_update&invoiceId=<%= inv.getIvid() %>" 
                                               class="btn btn-xs btn-warning"
                                               onclick="return confirm('Test update đơn hàng này?')">
                                                Test Update
                                            </a>
                                        <% } else { %>
                                            <small class="text-muted">❌ Không hiện nút</small>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                    
                    <!-- Statistics -->
                    <%
                        int pendingCount = 0;
                        int confirmedCount = 0;
                        int cancelledCount = 0;
                        int nullCount = 0;
                        
                        for (invoice inv : invoiceList) {
                            String status = inv.getStatus();
                            if (status == null) {
                                nullCount++;
                                pendingCount++; // NULL cũng được coi là pending
                            } else if ("Chờ xác nhận".equals(status)) {
                                pendingCount++;
                            } else if ("Đã xác nhận".equals(status)) {
                                confirmedCount++;
                            } else if ("Đã hủy".equals(status)) {
                                cancelledCount++;
                            }
                        }
                    %>
                    
                    <div class="row mt-3">
                        <div class="col-md-3">
                            <div class="card bg-warning text-dark">
                                <div class="card-body text-center">
                                    <h4><%= pendingCount %></h4>
                                    <small>Chờ xác nhận (bao gồm NULL)</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white">
                                <div class="card-body text-center">
                                    <h4><%= confirmedCount %></h4>
                                    <small>Đã xác nhận</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-danger text-white">
                                <div class="card-body text-center">
                                    <h4><%= cancelledCount %></h4>
                                    <small>Đã hủy</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-secondary text-white">
                                <div class="card-body text-center">
                                    <h4><%= nullCount %></h4>
                                    <small>Status = NULL</small>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html> 