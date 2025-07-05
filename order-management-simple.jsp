<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DAO" %>
<%@page import="entity.account" %>
<%@page import="entity.invoice" %>
<%@page import="entity.userinfor" %>
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
    String error = "";
    
    // Xử lý xác nhận/hủy đơn hàng
    if ("confirm".equals(action)) {
        String invoiceIdStr = request.getParameter("invoiceId");
        if (invoiceIdStr != null) {
            try {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                dao.updateInvoiceStatus(invoiceId, "đã xác nhận");
                message = "Đã xác nhận đơn hàng #" + invoiceId;
            } catch (Exception e) {
                error = "Có lỗi xảy ra: " + e.getMessage();
            }
        }
    } else if ("cancel".equals(action)) {
        String invoiceIdStr = request.getParameter("invoiceId");
        if (invoiceIdStr != null) {
            try {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                dao.updateInvoiceStatus(invoiceId, "đã hủy");
                message = "Đã hủy đơn hàng #" + invoiceId;
            } catch (Exception e) {
                error = "Có lỗi xảy ra: " + e.getMessage();
            }
        }
    }
    
    // Lấy danh sách đơn hàng
    List<invoice> invoiceList = null;
    try {
        invoiceList = dao.getAllInvoice();
    } catch (Exception e) {
        error = "Không thể tải danh sách đơn hàng: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <title>Quản lý đơn hàng - Admin</title>
</head>

<body>
    <!-- Include Header -->
    <jsp:include page="head.jsp" />

    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <h2>Quản lý đơn hàng</h2>
                
                <!-- Messages -->
                <% if (!message.isEmpty()) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= message %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                <% if (!error.isEmpty()) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <!-- Orders Table -->
                <div class="card">
                    <div class="card-header">
                        <h5>Danh sách đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <% if (invoiceList == null || invoiceList.isEmpty()) { %>
                            <p class="text-muted">Không có đơn hàng nào.</p>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>User ID</th>
                                            <th>Ngày đặt</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                        for (invoice inv : invoiceList) { 
                                        %>
                                            <tr>
                                                <td>#<%= inv.getIvid() %></td>
                                                <td><%= inv.getUid() %></td>
                                                <td><%= inv.getDate() %></td>
                                                <td class="text-success"><%= inv.getTotal() %>₫</td>
                                                <td>
                                                    <% String status = inv.getStatus() != null ? inv.getStatus() : "chờ xác nhận"; %>
                                                    <% if ("chờ xác nhận".equals(status)) { %>
                                                        <span class="badge bg-warning text-dark"><%= status %></span>
                                                    <% } else if ("đã xác nhận".equals(status)) { %>
                                                        <span class="badge bg-success"><%= status %></span>
                                                    <% } else if ("đã hủy".equals(status)) { %>
                                                        <span class="badge bg-danger"><%= status %></span>
                                                    <% } else { %>
                                                        <span class="badge bg-secondary"><%= status %></span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <% if ("chờ xác nhận".equals(status)) { %>
                                                        <form method="POST" action="order-management-simple.jsp" style="display: inline;">
                                                            <input type="hidden" name="action" value="confirm">
                                                            <input type="hidden" name="invoiceId" value="<%= inv.getIvid() %>">
                                                            <button type="submit" class="btn btn-sm btn-success" onclick="return confirm('Xác nhận đơn hàng này?')">
                                                                <i class="fa fa-check"></i> Xác nhận
                                                            </button>
                                                        </form>
                                                        <form method="POST" action="order-management-simple.jsp" style="display: inline;">
                                                            <input type="hidden" name="action" value="cancel">
                                                            <input type="hidden" name="invoiceId" value="<%= inv.getIvid() %>">
                                                            <button type="submit" class="btn btn-sm btn-danger ms-1" onclick="return confirm('Hủy đơn hàng này?')">
                                                                <i class="fa fa-times"></i> Hủy
                                                            </button>
                                                        </form>
                                                    <% } else { %>
                                                        <span class="text-muted">Đã xử lý</span>
                                                    <% } %>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="foot.jsp" />

    <!-- Scripts -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 