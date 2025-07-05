<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý kho hàng - Admin</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <style>
        .stock-high { color: #28a745; font-weight: bold; }
        .stock-medium { color: #ffc107; font-weight: bold; }
        .stock-low { color: #dc3545; font-weight: bold; }
        .stock-out { color: #6c757d; font-weight: bold; }
        
        .card-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }
        
        .table-responsive {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .btn-action {
            padding: 5px 10px;
            margin: 2px;
            border-radius: 5px;
        }
        
        .stats-card {
            background: linear-gradient(135deg, #fff, #f8f9fa);
            border: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        
        .stats-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
        
        .search-box {
            border-radius: 25px;
            border: 2px solid #e9ecef;
            padding: 8px 20px;
        }
        
        .search-box:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
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

    <!-- Start Content Page -->
    <div class="container-fluid bg-light py-4">
        <div class="col-md-12 mx-auto text-center">
            <h1 class="h1">Quản lý kho hàng</h1>
            <p>
                Theo dõi và quản lý tồn kho sản phẩm
            </p>
        </div>
    </div>
    <!-- End Banner Hero -->

    <!-- Start Content -->
    <div class="container py-5">
        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-4">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-boxes fa-2x text-primary mb-2"></i>
                        <h5>Tổng sản phẩm</h5>
                        <h3 class="text-primary">${stockSummary.size()}</h3>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 mb-4">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-exclamation-triangle fa-2x text-warning mb-2"></i>
                        <h5>Sắp hết hàng</h5>
                        <h3 class="text-warning" id="lowStockCount">0</h3>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 mb-4">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-times-circle fa-2x text-danger mb-2"></i>
                        <h5>Hết hàng</h5>
                        <h3 class="text-danger" id="outOfStockCount">0</h3>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3 mb-4">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <i class="fas fa-check-circle fa-2x text-success mb-2"></i>
                        <h5>Tồn kho tốt</h5>
                        <h3 class="text-success" id="goodStockCount">0</h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-info" onclick="refreshData()">
                        <i class="fas fa-sync-alt"></i> Làm mới
                    </button>
                </div>
            </div>
            <div class="col-md-6">
                <div class="input-group">
                    <input type="text" class="form-control search-box" id="searchInput" 
                           placeholder="Tìm kiếm sản phẩm...">
                    <button class="btn" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    <div class="input-group-append">
                        
                    </div>
                </div>
            </div>
        </div>

        <!-- Stock Table -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-warehouse"></i> Tổng quan kho hàng
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover" id="stockTable">
                                <thead class="thead-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Tổng kho</th>
                                        <th>Số size</th>
                                        <th>Tồn kho thấp nhất</th>
                                        <th>Tồn kho cao nhất</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${stockSummary}" var="item">
                                        <tr>
                                            <td>${item[0]}</td>
                                            <td>${item[1]}</td>
                                            <td>
                                                <span class="stock-display" data-stock="${item[2]}">
                                                    ${item[2]}
                                                </span>
                                            </td>
                                            <td>${item[3]}</td>
                                            <td>
                                                <span class="stock-display" data-stock="${item[4]}">
                                                    ${item[4]}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="stock-display" data-stock="${item[5]}">
                                                    ${item[5]}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge" id="status-${item[0]}">
                                                    <!-- Status will be updated by JavaScript -->
                                                </span>
                                            </td>
                                            <td>
                                                <a href="StockManagementControl?action=detail&productId=${item[0]}" 
                                                   class="btn btn-sm btn-primary btn-action">
                                                    <i class="fas fa-edit"></i> Chi tiết
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
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
    
    <script>
        $(document).ready(function() {
            updateStockDisplay();
            updateStatistics();
            
            // Search functionality
            $('#searchInput').on('keyup', function() {
                var value = $(this).val().toLowerCase();
                $('#stockTable tbody tr').filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        });
        
        function updateStockDisplay() {
            $('.stock-display').each(function() {
                var stock = parseInt($(this).data('stock'));
                var stockClass = '';
                
                if (stock <= 0) {
                    stockClass = 'stock-out';
                } else if (stock <= 5) {
                    stockClass = 'stock-low';
                } else if (stock <= 20) {
                    stockClass = 'stock-medium';
                } else {
                    stockClass = 'stock-high';
                }
                
                $(this).addClass(stockClass);
            });
        }
        
        function updateStatistics() {
            var lowStock = 0;
            var outOfStock = 0;
            var goodStock = 0;
            
            $('#stockTable tbody tr').each(function() {
                var totalStock = parseInt($(this).find('td:eq(2) .stock-display').data('stock'));
                var minStock = parseInt($(this).find('td:eq(4) .stock-display').data('stock'));
                var productId = $(this).find('td:eq(0)').text();
                var statusBadge = $('#status-' + productId);
                
                if (minStock <= 0) {
                    outOfStock++;
                    statusBadge.removeClass().addClass('badge bg-danger').text('Hết hàng');
                } else if (minStock <= 5) {
                    lowStock++;
                    statusBadge.removeClass().addClass('badge bg-warning text-dark').text('Sắp hết');
                } else {
                    goodStock++;
                    statusBadge.removeClass().addClass('badge bg-info').text('Tồn kho tốt');
                }
            });
            
            $('#lowStockCount').text(lowStock);
            $('#outOfStockCount').text(outOfStock);
            $('#goodStockCount').text(goodStock);
        }
        
        function refreshData() {
            location.reload();
        }
    </script>
    <!-- End Script -->
</body>
</html> 