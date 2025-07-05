<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.invoice" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê doanh số chi tiết - Admin</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
</head>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-3">
                <div class="list-group">
                    <a href="ProductmanagementControl" class="list-group-item list-group-item-action">Quản lý sản phẩm</a>
                    <a href="RevenueStatisticsControl" class="list-group-item list-group-item-action">Tổng doanh số</a>
                    <a href="AdminStatisticsControl" class="list-group-item list-group-item-action active">Thống kê chi tiết</a>
                </div>
            </div>
            <div class="col-md-9">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h3 class="mb-0"><i class="fa fa-chart-bar"></i> Thống kê doanh số chi tiết</h3>
                    </div>
                    <div class="card-body">
                        <h4 class="mb-4">Tổng doanh số các đơn đã xác nhận: <span class="text-success fw-bold">đ${String.format("%,d", totalRevenue * 1000)}</span></h4>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Khách hàng (UID)</th>
                                        <th>Ngày đặt</th>
                                        <th>Mô tả</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${confirmedInvoices}" var="inv">
                                        <tr>
                                            <td>#${inv.ivid}</td>
                                            <td>${inv.uid}</td>
                                            <td>${inv.date}</td>
                                            <td>${inv.description}</td>
                                            <td>đ${String.format("%,d", inv.total * 1000)}</td>
                                            <td>${inv.status}</td>
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
    <jsp:include page="foot.jsp"></jsp:include>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 