<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết quản lý kho - Admin</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    
    <style>
        .card {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border: none;
            border-radius: 10px;
        }
        
        .card-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .size-card {
            transition: transform 0.2s ease;
            border: 2px solid #e9ecef;
        }
        
        .size-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .size-card.low-stock {
            border-color: #ffc107;
            background-color: #fff3cd;
        }
        
        .size-card.out-of-stock {
            border-color: #dc3545;
            background-color: #f8d7da;
        }
        
        .size-card.good-stock {
            border-color: #28a745;
            background-color: #d4edda;
        }
        
        .stock-number {
            font-size: 1.5rem;
            font-weight: bold;
        }
        
        .product-info {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .btn-custom {
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 600;
        }
        
        .table th {
            background-color: #f8f9fa;
            border-top: none;
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

    <!-- Main Content -->
    <div class="container py-5">
        <!-- Back Button -->
        <div class="mb-4">
            <a href="StockManagementControl" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại quản lý kho
            </a>
        </div>

        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h2><i class="fas fa-warehouse"></i> Chi tiết quản lý kho</h2>
                <p class="text-muted">Quản lý tồn kho theo từng size sản phẩm</p>
            </div>
        </div>

        <!-- Product Info -->
        <div class="bg-light p-4 rounded mb-4">
            <div class="row">
                <div class="col-md-8">
                    <h3><i class="fas fa-box text-primary"></i> ${product.name}</h3>
                    <p><strong>ID:</strong> ${product.id}</p>
                    <p><strong>Mô tả:</strong> ${product.description}</p>
                </div>
                <div class="col-md-4 text-right">
                    <div class="card text-center">
                        <div class="card-body">
                            <h4 class="text-primary">${product.stock}</h4>
                            <small>Tổng tồn kho</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Message Display -->
        <c:if test="${not empty message}">
            <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show">
                <i class="fas ${messageType == 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle'}"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Size Management Grid -->
        <div class="row">
            <c:forEach items="${sizes}" var="sizeItem">
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-header text-center bg-primary text-white">
                            <h5>Size ${sizeItem.size}</h5>
                        </div>
                        <div class="card-body text-center">
                            <h3 class="${sizeItem.stock == 0 ? 'text-danger' : (sizeItem.stock <= 5 ? 'text-warning' : 'text-success')}">
                                ${sizeItem.stock}
                            </h3>
                            <p class="text-muted">sản phẩm</p>
                            
                            <form method="post" action="StockManagementControl">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="sizeValue" value="${sizeItem.size}">
                                
                                <div class="mb-2">
                                    <input type="number" class="form-control" name="quantity" 
                                           min="0" placeholder="Số lượng" required>
                                </div>
                                
                                <div class="mb-2">
                                    <select class="form-control" name="updateType">
                                        <option value="add">Thêm vào kho</option>
                                        <option value="set">Đặt số lượng</option>
                                    </select>
                                </div>
                                
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-edit"></i> Cập nhật
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="foot.jsp" />

    <!-- Scripts -->
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 