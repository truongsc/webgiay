<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
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
    String error = "";
    
    // Xử lý xác nhận/hủy đơn hàng
    if ("confirm".equals(action)) {
        String invoiceIdStr = request.getParameter("invoiceId");
        if (invoiceIdStr != null) {
            try {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                
                dao.updateInvoiceStatus(invoiceId, "Đã xác nhận");
                message = "Đã xác nhận đơn hàng #" + invoiceId + " thành công!";
                
            } catch (Exception e) {
                error = "Có lỗi xảy ra khi xác nhận đơn hàng: " + e.getMessage();
            }
        } else {
            error = "Không tìm thấy ID đơn hàng để xác nhận!";
        }
    } else if ("cancel".equals(action)) {
        String invoiceIdStr = request.getParameter("invoiceId");
        if (invoiceIdStr != null) {
            try {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                dao.updateInvoiceStatus(invoiceId, "Đã hủy");
                message = "Đã hủy đơn hàng #" + invoiceId;
            } catch (Exception e) {
                error = "Có lỗi xảy ra khi hủy đơn hàng: " + e.getMessage();
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
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <title>Quản lý đơn hàng - Admin</title>
    <style>
        /* 1) Nền xanh đậm */
    .navbar-custom {
      background-color: #004080;  /* đậm hơn, xanh dương */
    }
    /* 2) Menu chính giữa, chia đều */
    .menu-nav {
      flex: 1;                              /* chiếm hết khoảng giữa */
      display: flex !important;
      justify-content: space-evenly;        /* chia đều các item */
      list-style: none;
      margin: 0;
      padding: 0;
    }
    /* 3) Chữ trắng, padding cho link */
    .menu-nav .nav-link {
      color: #fff !important;
      padding: 0.5rem 1rem;
      transition: background-color .2s;
      border-radius: .25rem;
    }
    /* 4) Hover & Active */
    .menu-nav .nav-link:hover {
      background-color: rgba(255,255,255,0.2);
    }
    .menu-nav .nav-link.active {
      background-color: rgba(255,255,255,0.3);
    }
    /* 5) Notification & Logout cũng trắng */
    .navbar-custom .nav-link.logout,
    .navbar-custom .nav-link.notif {
      color: #fff !important;
      padding: 0.5rem;
    }
    .navbar-custom .nav-link.logout:hover,
    .navbar-custom .nav-link.notif:hover {
      background-color: rgba(255,255,255,0.2);
      border-radius: .25rem;
    }
    </style>
</head>

<body>
    <!-- Include Header -->
    <jsp:include page="head2.jsp" />

    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4">
                    <i class="fa fa-shopping-cart"></i> Quản lý đơn hàng
                </h2>
                
                <!-- Messages -->
                <% if (!message.isEmpty()) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fa fa-check-circle"></i> <%= message %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                <% if (!error.isEmpty()) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fa fa-exclamation-triangle"></i> <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>



                <!-- Orders Table -->
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fa fa-list"></i> Danh sách đơn hàng
                        </h5>
                    </div>
                    <div class="card-body">
                        <% if (invoiceList == null || invoiceList.isEmpty()) { %>
                            <div class="text-center py-4">
                                <i class="fa fa-inbox fa-3x text-muted mb-3"></i>
                                <p class="text-muted">Không có đơn hàng nào.</p>
                            </div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th><i class="fa fa-hashtag"></i> ID</th>
                                            <th><i class="fa fa-user"></i> User ID</th>
                                            <th><i class="fa fa-calendar"></i> Ngày đặt</th>
                                            <th><i class="fa fa-money-bill"></i> Tổng tiền</th>
                                            <th><i class="fa fa-eye"></i> Chi tiết</th>
                                            <th><i class="fa fa-flag"></i> Trạng thái</th>
                                            <th><i class="fa fa-cogs"></i> Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                        for (invoice inv : invoiceList) { 
                                            String status = inv.getStatus();
                                            // Logic: "Chờ xác nhận" hoặc NULL = chờ xác nhận
                                            boolean isPending = (status == null || "Chờ xác nhận".equals(status));
                                            String displayStatus = status != null ? status : "Chờ xác nhận";
                                            

                                        %>
                                            <tr>
                                                <td>
                                                    <strong>#<%= inv.getIvid() %></strong>
                                                </td>
                                                <td><%= inv.getUid() %></td>
                                                <td><%= inv.getDate() %></td>
                                                <td class="text-success fw-bold">đ<%= String.format("%,d", (long)(inv.getTotal() * 1000)) %></td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#detailModal<%= inv.getIvid() %>">
                                                        <i class="fa fa-eye"></i> Xem chi tiết
                                                    </button>
                                                </td>
                                                <td>
                                                    <% if (isPending) { %>
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="fa fa-clock"></i> <%= displayStatus %>
                                                        </span>
                                                    <% } else if (status != null && status.contains("xác nhận")) { %>
                                                        <span class="badge bg-info">
                                                            <i class="fa fa-check"></i> <%= status %>
                                                        </span>
                                                    <% } else if (status != null && status.contains("hủy")) { %>
                                                        <span class="badge bg-danger">
                                                            <i class="fa fa-times"></i> <%= status %>
                                                        </span>
                                                    <% } else if (status != null) { %>
                                                        <span class="badge bg-secondary"><%= status %></span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <% if (isPending) { %>
                                                        <div class="btn-group" role="group">
                                                            <form method="POST" action="ordermanagement.jsp" style="display: inline;">
                                                                <input type="hidden" name="action" value="confirm">
                                                                <input type="hidden" name="invoiceId" value="<%= inv.getIvid() %>">
                                                                <button type="submit" class="btn btn-sm btn-success" onclick="return confirm('Xác nhận đơn hàng này?')" title="Xác nhận">
                                                                    <i class="fa fa-check"></i> Xác nhận
                                                                </button>
                                                            </form>
                                                            <form method="POST" action="ordermanagement.jsp" style="display: inline;">
                                                                <input type="hidden" name="action" value="cancel">
                                                                <input type="hidden" name="invoiceId" value="<%= inv.getIvid() %>">
                                                                <button type="submit" class="btn btn-sm btn-danger ms-1" onclick="return confirm('Hủy đơn hàng này?')" title="Hủy">
                                                                    <i class="fa fa-times"></i> Hủy
                                                                </button>
                                                            </form>
                                                        </div>
                                                    <% } else { %>
                                                        <span class="text-muted">
                                                            <i class="fa fa-check-circle"></i> Đã xử lý
                                                        </span>
                                                    <% } %>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Statistics -->
                            <%
                                int pendingCount = 0;
                                int confirmedCount = 0;
                                int cancelledCount = 0;
                                
                                for (invoice inv : invoiceList) {
                                    String status = inv.getStatus();
                                    if (status == null || "Chờ xác nhận".equals(status)) {
                                        pendingCount++;
                                    } else if (status != null && status.contains("Đã xác nhận")) {
                                        confirmedCount++;
                                    } else if (status != null && status.contains("hủy")) {
                                        cancelledCount++;
                                    }
                                }
                            %>
                            <div class="row mt-4">
                                <div class="col-md-4">
                                    <div class="card bg-warning text-white">
                                        <div class="card-body text-center">
                                            <h3><%= pendingCount %></h3>
                                            <p><i class="fa fa-clock"></i> Chờ xác nhận</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card bg-info text-white">
                                        <div class="card-body text-center">
                                            <h3><%= confirmedCount %></h3>
                                            <p><i class="fa fa-check"></i> Đã xác nhận</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card bg-danger text-white">
                                        <div class="card-body text-center">
                                            <h3><%= cancelledCount %></h3>
                                            <p><i class="fa fa-times"></i> Đã hủy</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Total Orders -->
                            <div class="row mt-3">
                                <div class="col-12">
                                    <div class="card bg-info text-white">
                                        <div class="card-body text-center">
                                            <h4>Tổng số đơn hàng: <%= invoiceList.size() %></h4>
                                        </div>
                                    </div>
                                </div>
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

    <!-- Modal chi tiết đơn hàng -->
    <% for (invoice inv : invoiceList) { %>
        <div class="modal fade" id="detailModal<%= inv.getIvid() %>" tabindex="-1" aria-labelledby="detailModalLabel<%= inv.getIvid() %>" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detailModalLabel<%= inv.getIvid() %>">Chi tiết đơn hàng #<%= inv.getIvid() %></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Ngày đặt:</strong> <%= inv.getDate() %></p>
                        <p><strong>Tổng tiền:</strong> đ<%= String.format("%,d", (long)(inv.getTotal() * 1000)) %></p>
                        <p><strong>Trạng thái:</strong> <%= inv.getStatus() %></p>
                        <p><strong>Mô tả:</strong> <%= (inv.getDescription() != null && !inv.getDescription().isEmpty()) ? inv.getDescription() : "-" %></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</body>
</html> 