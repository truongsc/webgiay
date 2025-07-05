<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê doanh số - Admin</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
</head>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0"><i class="fa fa-chart-line"></i> Thống kê doanh số</h3>
                    </div>
                    <div class="card-body">
                        <h4 class="mb-4">Tổng doanh số các đơn đã xác nhận:</h4>
                        <h2 class="text-success fw-bold">đ${String.format("%,d", totalRevenue * 1000)}</h2>
                        <hr>
                        <a href="ProductmanagementControl" class="btn btn-outline-primary"><i class="fa fa-arrow-left"></i> Quay lại quản lý sản phẩm</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="foot.jsp"></jsp:include>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 