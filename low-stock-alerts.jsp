<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cảnh báo hàng sắp hết - Admin</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <style>
        .alert-card {
            border-left: 4px solid #dc3545;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }
        .stock-urgent { color: #dc3545; font-weight: bold; }
        .stock-warning { color: #ffc107; font-weight: bold; }
        .threshold-control {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-success logo h1 align-self-center" href="index.jsp">
                Zay Shop
            </a>
            <div class="navbar-nav">
                <a class="nav-link" href="index.jsp">Trang chủ</a>
                <a class="nav-link" href="ProductmanagementControl">Quản lý sản phẩm</a>
                <a class="nav-link" href="StockManagementControl">Quản lý kho</a>
                <a class="nav-link" href="OrderManagementControl">Quản lý đơn hàng</a>
                <a class="nav-link" href="LogoutControl">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Back Button -->
        <div class="mb-4">
            <a href="StockManagementControl" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại quản lý kho
            </a>
        </div>

        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="text-danger">
                    <i class="fas fa-exclamation-triangle"></i> 
                    Cảnh báo hàng sắp hết
                </h2>
                <p class="text-muted">Các sản phẩm có số lượng tồn kho thấp dưới ngưỡng cảnh báo</p>
            </div>
        </div>

        <!-- Threshold Control -->
        <div class="threshold-control">
            <form method="get" action="StockManagementControl" class="form-inline">
                <input type="hidden" name="action" value="lowstock">
                <label for="threshold" class="mr-2">Ngưỡng cảnh báo:</label>
                <input type="number" class="form-control mr-2" id="threshold" name="threshold" 
                       value="${threshold}" min="1" max="100">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-filter"></i> Lọc
                </button>
            </form>
        </div>

        <!-- Low Stock Items -->
        <div class="card">
            <div class="card-header bg-warning text-dark">
                <h5 class="mb-0">
                    <i class="fas fa-list"></i> 
                    Danh sách hàng sắp hết (${lowStockItems.size()} sản phẩm)
                </h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty lowStockItems}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i>
                            Không có sản phẩm nào sắp hết hàng với ngưỡng ${threshold}!
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Size ID</th>
                                        <th>Product ID</th>
                                        <th>Size</th>
                                        <th>Số lượng còn lại</th>
                                        <th>Mức độ</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${lowStockItems}" var="item">
                                        <tr class="alert-card">
                                            <td>${item.sid}</td>
                                            <td>${item.pid}</td>
                                            <td><strong>Size ${item.size}</strong></td>
                                            <td>
                                                <span class="${item.stock == 0 ? 'stock-urgent' : 'stock-warning'}">
                                                    ${item.stock} sản phẩm
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.stock == 0}">
                                                        <span class="badge badge-danger">HẾT HÀNG</span>
                                                    </c:when>
                                                    <c:when test="${item.stock <= 2}">
                                                        <span class="badge badge-danger">KHẨN CẤP</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-warning">SẮP HẾT</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="StockManagementControl?action=detail&productId=${item.pid}" 
                                                   class="btn btn-sm btn-primary">
                                                    <i class="fas fa-edit"></i> Cập nhật
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card mt-4">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-tools"></i> Thao tác nhanh
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <a href="StockManagementControl" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-warehouse"></i> Quay về quản lý kho
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="ProductmanagementControl" class="btn btn-outline-success btn-block">
                            <i class="fas fa-plus"></i> Thêm sản phẩm mới
                        </a>
                    </div>
                    <div class="col-md-4">
                        <button onclick="window.print()" class="btn btn-outline-info btn-block">
                            <i class="fas fa-print"></i> In báo cáo
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 