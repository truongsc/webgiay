<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DAO" %>
<%@page import="entity.account" %>
<%@page import="entity.invoice" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>Test Orders</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container py-5">
        <h2>Test Quản lý đơn hàng</h2>
        
        <%
        try {
            // Kiểm tra quyền admin
            account acc = (account) session.getAttribute("accountss");
            if (acc == null) {
                out.println("<div class='alert alert-warning'>Chưa đăng nhập</div>");
            } else if (acc.getIsAdmin() != 1) {
                out.println("<div class='alert alert-danger'>Không có quyền admin</div>");
            } else {
                out.println("<div class='alert alert-success'>Có quyền admin: " + acc.getUser() + "</div>");
                
                // Test DAO
                DAO dao = new DAO();
                out.println("<p>DAO đã khởi tạo thành công</p>");
                
                // Test phương thức updateInvoiceStatus
                try {
                    String action = request.getParameter("action");
                    String invoiceIdStr = request.getParameter("invoiceId");
                    
                    if ("confirm".equals(action) && invoiceIdStr != null) {
                        int invoiceId = Integer.parseInt(invoiceIdStr);
                        dao.updateInvoiceStatus(invoiceId, "đã xác nhận");
                        out.println("<div class='alert alert-success'>Đã xác nhận đơn hàng #" + invoiceId + "</div>");
                    }
                    
                    if ("cancel".equals(action) && invoiceIdStr != null) {
                        int invoiceId = Integer.parseInt(invoiceIdStr);
                        dao.updateInvoiceStatus(invoiceId, "đã hủy");
                        out.println("<div class='alert alert-success'>Đã hủy đơn hàng #" + invoiceId + "</div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Lỗi xử lý action: " + e.getMessage() + "</div>");
                }
                
                // Test lấy danh sách đơn hàng
                try {
                    List<invoice> invoiceList = dao.getAllInvoice();
                    if (invoiceList != null) {
                        out.println("<p>Tìm thấy " + invoiceList.size() + " đơn hàng</p>");
                        
                        if (!invoiceList.isEmpty()) {
                            out.println("<table class='table table-striped'>");
                            out.println("<thead><tr><th>ID</th><th>User ID</th><th>Date</th><th>Total</th><th>Status</th><th>Action</th></tr></thead>");
                            out.println("<tbody>");
                            
                            for (invoice inv : invoiceList) {
                                String status = inv.getStatus() != null ? inv.getStatus() : "chờ xác nhận";
                                out.println("<tr>");
                                out.println("<td>#" + inv.getIvid() + "</td>");
                                out.println("<td>" + inv.getUid() + "</td>");
                                out.println("<td>" + inv.getDate() + "</td>");
                                out.println("<td>" + inv.getTotal() + " VND</td>");
                                out.println("<td>" + status + "</td>");
                                out.println("<td>");
                                
                                if ("chờ xác nhận".equals(status)) {
                                    out.println("<a href='test-orders.jsp?action=confirm&invoiceId=" + inv.getIvid() + "' class='btn btn-sm btn-success' onclick='return confirm(\"Xác nhận?\")'>Xác nhận</a> ");
                                    out.println("<a href='test-orders.jsp?action=cancel&invoiceId=" + inv.getIvid() + "' class='btn btn-sm btn-danger' onclick='return confirm(\"Hủy?\")'>Hủy</a>");
                                } else {
                                    out.println("<span class='text-muted'>Đã xử lý</span>");
                                }
                                
                                out.println("</td>");
                                out.println("</tr>");
                            }
                            
                            out.println("</tbody></table>");
                        }
                    } else {
                        out.println("<p>invoiceList is null</p>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Lỗi lấy danh sách: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Lỗi tổng quát: " + e.getMessage() + "</div>");
            e.printStackTrace();
        }
        %>
        
        <br>
        <a href="IndexControl" class="btn btn-primary">Về trang chủ</a>
    </div>
    
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 