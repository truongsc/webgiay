<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.DAO" %>
<%@page import="entity.*" %>
<%@page import="java.util.*" %>

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
            } catch (NumberFormatException e) {
                error = "ID đơn hàng không hợp lệ!";
            }
        }
    } else if ("cancel".equals(action)) {
        String invoiceIdStr = request.getParameter("invoiceId");
        if (invoiceIdStr != null) {
            try {
                int invoiceId = Integer.parseInt(invoiceIdStr);
                dao.updateInvoiceStatus(invoiceId, "đã hủy");
                message = "Đã hủy đơn hàng #" + invoiceId;
            } catch (NumberFormatException e) {
                error = "ID đơn hàng không hợp lệ!";
            }
        }
    }
    
    // Lấy danh sách đơn hàng
    String statusFilter = request.getParameter("status");
    List<invoice> invoiceList;
    
    if (statusFilter != null && !statusFilter.isEmpty()) {
        invoiceList = dao.getInvoicesByStatus(statusFilter);
    } else {
        invoiceList = dao.getAllInvoiceWithUserInfo();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="css/fontawesome.min.css">

    <title>Quản lý đơn hàng - Admin</title>
</head>

<body>
    <!-- Include Header -->
    <jsp:include page="head.jsp" />

    <!-- Start Content Page -->
    <div class="container-fluid bg-light py-5">
        <div class="col-md-12 mx-auto text-center">
            <h1 class="h1">Quản lý đơn hàng</h1>
            <p>
                Xem và xác nhận đơn hàng của khách hàng
            </p>
        </div>
    </div>
    <!-- End Banner Hero -->

    <!-- Start Content -->
    <div class="container py-5">
        <!-- Messages -->
        <% if (!message.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        <% if (!error.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <!-- Filter -->
        <div class="row mb-4">
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Bộ lọc đơn hàng</h5>
                        <form method="GET" action="order-management.jsp">
                            <div class="input-group">
                                <select class="form-select" name="status">
                                    <option value="">Tất cả đơn hàng</option>
                                    <option value="chờ xác nhận" <%= "chờ xác nhận".equals(statusFilter) ? "selected" : "" %>>Chờ xác nhận</option>
                                    <option value="đã xác nhận" <%= "đã xác nhận".equals(statusFilter) ? "selected" : "" %>>Đã xác nhận</option>
                                    <option value="đã hủy" <%= "đã hủy".equals(statusFilter) ? "selected" : "" %>>Đã hủy</option>
                                </select>
                                <button class="btn btn-success" type="submit">Lọc</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Orders List -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Danh sách đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <% if (invoiceList == null || invoiceList.isEmpty()) { %>
                            <div class="text-center py-4">
                                <p class="text-muted">Không có đơn hàng nào.</p>
                            </div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Khách hàng</th>
                                            <th>Ngày đặt</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Chi tiết</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (invoice inv : invoiceList) { 
                                            userinfor userInfo = dao.getUserinforByInvoiceId(inv.getIvid());
                                        %>
                                            <tr>
                                                <td>#<%= inv.getIvid() %></td>
                                                <td><%= userInfo != null ? userInfo.getName() : "N/A" %></td>
                                                <td><%= inv.getDate() %></td>
                                                <td class="text-success fw-bold">đ<%= String.format("%,d", (long)(inv.getTotal() * 1000)) %></td>
                                                <td>
                                                    <% if ("chờ xác nhận".equals(inv.getStatus())) { %>
                                                        <span class="badge bg-warning text-dark"><%= inv.getStatus() %></span>
                                                    <% } else if ("đã xác nhận".equals(inv.getStatus())) { %>
                                                        <span class="badge bg-success"><%= inv.getStatus() %></span>
                                                    <% } else if ("đã hủy".equals(inv.getStatus())) { %>
                                                        <span class="badge bg-danger"><%= inv.getStatus() %></span>
                                                    <% } else { %>
                                                        <span class="badge bg-secondary"><%= inv.getStatus() %></span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#detailModal<%= inv.getIvid() %>">
                                                        <i class="fa fa-eye"></i> Xem
                                                    </button>
                                                </td>
                                                <td>
                                                    <% if ("chờ xác nhận".equals(inv.getStatus())) { %>
                                                        <form method="POST" action="order-management.jsp" style="display: inline;">
                                                            <input type="hidden" name="action" value="confirm">
                                                            <input type="hidden" name="invoiceId" value="<%= inv.getIvid() %>">
                                                            <button type="submit" class="btn btn-sm btn-success" onclick="return confirm('Xác nhận đơn hàng này?')">
                                                                <i class="fa fa-check"></i> Xác nhận
                                                            </button>
                                                        </form>
                                                        <form method="POST" action="order-management.jsp" style="display: inline;">
                                                            <input type="hidden" name="action" value="cancel">
                                                            <input type="hidden" name="invoiceId" value="<%= inv.getIvid() %>">
                                                            <button type="submit" class="btn btn-sm btn-danger ms-1" onclick="return confirm('Hủy đơn hàng này?')">
                                                                <i class="fa fa-times"></i> Hủy
                                                            </button>
                                                        </form>
                                                    <% } else { %>
                                                        <span class="text-muted">Không có thao tác</span>
                                                    <% } %>
                                                </td>
                                            </tr>

                                            <!-- Detail Modal -->
                                            <div class="modal fade" id="detailModal<%= inv.getIvid() %>" tabindex="-1" aria-labelledby="detailModalLabel<%= inv.getIvid() %>" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="detailModalLabel<%= inv.getIvid() %>">Chi tiết đơn hàng #<%= inv.getIvid() %></h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <h6>Thông tin khách hàng:</h6>
                                                                    <p><strong>Tên:</strong> <%= userInfo != null ? userInfo.getName() : "N/A" %></p>
                                                                    <p><strong>Tuổi:</strong> <%= userInfo != null ? userInfo.getAge() : "N/A" %></p>
                                                                    <p><strong>Địa chỉ:</strong> <%= userInfo != null ? userInfo.getAddress() : "N/A" %></p>
                                                                    <p><strong>Điện thoại:</strong> <%= userInfo != null ? userInfo.getPhone() : "N/A" %></p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <h6>Thông tin đơn hàng:</h6>
                                                                    <p><strong>Ngày đặt:</strong> <%= inv.getDate() %></p>
                                                                    <p><strong>Tổng tiền:</strong> <span class="text-success">đ<%= String.format("%,d", (long)(inv.getTotal() * 1000)) %></span></p>
                                                                    <p><strong>Trạng thái:</strong> 
                                                                        <% if ("chờ xác nhận".equals(inv.getStatus())) { %>
                                                                            <span class="badge bg-warning text-dark"><%= inv.getStatus() %></span>
                                                                        <% } else if ("đã xác nhận".equals(inv.getStatus())) { %>
                                                                            <span class="badge bg-success"><%= inv.getStatus() %></span>
                                                                        <% } else if ("đã hủy".equals(inv.getStatus())) { %>
                                                                            <span class="badge bg-danger"><%= inv.getStatus() %></span>
                                                                        <% } else { %>
                                                                            <span class="badge bg-secondary"><%= inv.getStatus() %></span>
                                                                        <% } %>
                                                                    </p>
                                                                    <% if (inv.getDescription() != null && !inv.getDescription().isEmpty()) { %>
                                                                        <p><strong>Ghi chú:</strong> <%= inv.getDescription() %></p>
                                                                    <% } %>
                                                                </div>
                                                            </div>
                                                            
                                                            <hr>
                                                            
                                                            <h6>Chi tiết sản phẩm:</h6>
                                                            <% 
                                                                List<entity.invoice_detail> invoiceDetails = dao.getListByInvoiceId(inv.getIvid());
                                                                if (invoiceDetails != null && !invoiceDetails.isEmpty()) {
                                                            %>
                                                                <div class="table-responsive">
                                                                    <table class="table table-sm">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>Sản phẩm</th>
                                                                                <th>Số lượng</th>
                                                                                <th>Đơn giá</th>
                                                                                <th>Thành tiền</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <% for (entity.invoice_detail detail : invoiceDetails) { 
                                                                                product prod = dao.getProductById(String.valueOf(detail.getProductID()));
                                                                            %>
                                                                                <tr>
                                                                                    <td>
                                                                                        <div class="d-flex align-items-center">
                                                                                            <img src="<%= prod.getImage() %>" alt="<%= prod.getName() %>" class="me-2" style="width: 40px; height: 40px; object-fit: cover;">
                                                                                            <div>
                                                                                                <div class="fw-bold"><%= prod.getName() %></div>
                                                                                                <small class="text-muted">Màu: <%= detail.getColor() %>, Size: <%= detail.getSize() %></small>
                                                                                            </div>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td><%= detail.getAmount() %></td>
                                                                                    <td>đ<%= String.format("%,d", (long)(detail.getPrice() * 1000)) %></td>
                                                                                    <td class="fw-bold">đ<%= String.format("%,d", (long)(detail.getAmount() * detail.getPrice() * 1000)) %></td>
                                                                                </tr>
                                                                            <% } %>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            <% } %>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                            <% if ("chờ xác nhận".equals(inv.getStatus())) { %>
                                                                <form method="POST" action="order-management.jsp" style="display: inline;">
                                                                    <input type="hidden" name="action" value="confirm">
                                                                    <input type="hidden" name="invoiceId" value="<%= inv.getIvid() %>">
                                                                    <button type="submit" class="btn btn-success" onclick="return confirm('Xác nhận đơn hàng này?')">
                                                                        <i class="fa fa-check"></i> Xác nhận đơn hàng
                                                                    </button>
                                                                </form>
                                                            <% } %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
    <!-- End Content -->

    <!-- Include Footer -->
    <jsp:include page="foot.jsp" />

    <!-- Start Script -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/jquery-migrate-1.2.1.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/templatemo.js"></script>
    <!-- End Script -->
</body>

</html> 