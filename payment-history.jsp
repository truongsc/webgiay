<%-- 
    Document   : payment-history
    Created on : Dec 5, 2024, 5:34:37 PM
    Author     : Chi Tien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
        <title>FIN SHOES</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/templatemo.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
        <link rel="stylesheet" href="css/fontawesome.min.css">
</head>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    <c:if test="${not empty message}">
        <div class="container alert alert-success alert-dismissible fade show " role="alert">
            <b class="text-success">${message}</b>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <div class="container">
    <div class="table-wrapper">
        <div class="table-title">
            <div class="row">
                <div class="col-sm-6">
                    <br><h2 class="text-danger">Lịch sử thanh toán</h2>
                </div>
            </div>
        </div>
        <div class="accordion" id="accordionPaymentHistory">
            <c:forEach items="${listi}" var="o" varStatus="status">
                <div class="accordion-item mb-3">
                    <!-- Custom header with action buttons outside -->
                    <div class="card-header d-flex justify-content-between align-items-center" style="background-color: #f8f9fa; border: 1px solid #dee2e6;">
                        <div class="flex-grow-1" style="cursor: pointer;" data-bs-toggle="collapse" 
                             data-bs-target="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}">
                            <div class="row">
                                <div class="col-md-3">
                                    <strong>Đơn #${o.ivid}</strong>
                                    <br><small class="text-muted">${o.date}</small>
                                </div>
                                <div class="col-md-3">
                                    <span class="text-primary fw-bold">đ${String.format("%,d", o.total * 1000)}</span>
                                </div>
                                <div class="col-md-6">
                                    <c:choose>
                                        <c:when test="${o.status == null || o.status == 'Chờ xác nhận'}">
                                            <span class="badge bg-warning text-dark">
                                                <i class="fa fa-clock"></i> Chờ xác nhận
                                            </span>
                                        </c:when>
                                        <c:when test="${o.status == 'Đã xác nhận'}">
                                            <span class="badge bg-success">
                                                <i class="fa fa-check"></i> Đã xác nhận
                                            </span>
                                        </c:when>
                                        <c:when test="${o.status == 'Đã hủy'}">
                                            <span class="badge bg-danger">
                                                <i class="fa fa-times"></i> Đã hủy
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">
                                                <i class="fa fa-question"></i> ${o.status != null ? o.status : 'Chờ xác nhận'}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action buttons - separate from accordion toggle -->
                        <div class="ms-3">
                            <c:choose>
                                <c:when test="${o.status == 'Đã xác nhận'}">
                                    <!-- Kiểm tra đã đánh giá chưa -->
                                    <c:set var="hasFeedback" value="false" />
                                    <c:forEach items="${feedbackList}" var="fb">
                                        <c:if test="${fb.invoice_id == o.ivid}">
                                            <c:set var="hasFeedback" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <c:choose>
                                        <c:when test="${hasFeedback}">
                                            <div class="text-center">
                                                <span class="text-success d-block mb-1">
                                                    <i class="fa fa-check-circle"></i> Đã đánh giá
                                                </span>
                                                <a href="FeedbackControl?invoiceId=${o.ivid}&action=edit" 
                                                   class="btn btn-sm btn-outline-warning">
                                                    <i class="fa fa-edit"></i> Sửa
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="FeedbackControl?invoiceId=${o.ivid}" 
                                               class="btn btn-sm btn-outline-success">
                                                <i class="fa fa-star"></i> Đánh giá
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${o.status == null || o.status == 'Chờ xác nhận'}">
                                    <span class="text-muted">
                                        <i class="fa fa-hourglass-half"></i> Chờ xác nhận
                                    </span>
                                </c:when>
                                <c:when test="${o.status == 'Đã hủy'}">
                                    <span class="text-danger">
                                        <i class="fa fa-ban"></i> Đã hủy
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">-</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- Toggle icon -->
                        <div class="ms-2">
                            <i class="fa fa-chevron-down" data-bs-toggle="collapse" 
                               data-bs-target="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}"
                               style="cursor: pointer; transition: transform 0.3s;"></i>
                        </div>
                    </div>
                    <div id="collapse${status.index}" class="accordion-collapse collapse" 
                         aria-labelledby="heading${status.index}" data-bs-parent="#accordionPaymentHistory">
                        <div class="accordion-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <h6 class="text-primary mb-3">Chi tiết đơn hàng:</h6>
                                    <c:set var="orderDetails" value="${invoiceDetailsMap[o.ivid]}" />
                                    <c:choose>
                                        <c:when test="${not empty orderDetails}">
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
                                                        <c:forEach items="${orderDetails}" var="detail">
                                                            <c:set var="product" value="${detail.productByProductId}" />
                                                            <tr>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <img src="img/${product.image}" alt="${product.name}" 
                                                                             class="me-2" style="width: 50px; height: 50px; object-fit: cover;">
                                                                        <div>
                                                                            <strong>${product.name}</strong>
                                                                            <br><small class="text-muted">ID: ${product.id}</small>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td class="align-middle">${detail.amount}</td>
                                                                <td class="align-middle">
                                                                    <span class="fw-bold text-danger">đ${String.format("%,.0f", detail.priceAtPurchase * 1000)}</span>
                                                                    <br>
                                                                    <span class="text-muted" style="text-decoration: line-through; font-size: 0.9em;">đ${String.format("%,.0f", product.price * 1000)}</span>
                                                                </td>
                                                                <td class="align-middle fw-bold">
                                                                    đ${String.format("%,.0f", detail.priceAtPurchase * detail.amount * 1000)}
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-info">
                                                <i class="fa fa-info-circle"></i> Không có chi tiết sản phẩm cho đơn hàng này.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <div class="row mt-3">
                                        <div class="col-md-6">
                                            <p><strong>Mô tả:</strong> ${o.description}</p>
                                        </div>
                                        <div class="col-md-6 text-end">
                                            <h5 class="text-primary">
                                                <strong>Tổng cộng: đ${String.format("%,d", o.total * 1000)}</strong>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    </div>
    <jsp:include page="foot.jsp"></jsp:include>
    
    <script>
        // Xoay icon khi mở/đóng accordion
        document.addEventListener('DOMContentLoaded', function() {
            var accordionItems = document.querySelectorAll('.accordion-collapse');
            accordionItems.forEach(function(item) {
                item.addEventListener('show.bs.collapse', function() {
                    var icon = document.querySelector('[data-bs-target="#' + this.id + '"] i.fa-chevron-down');
                    if (icon) {
                        icon.style.transform = 'rotate(180deg)';
                    }
                });
                item.addEventListener('hide.bs.collapse', function() {
                    var icon = document.querySelector('[data-bs-target="#' + this.id + '"] i.fa-chevron-down');
                    if (icon) {
                        icon.style.transform = 'rotate(0deg)';
                    }
                });
            });
        });
    </script>
    
</body><script src="js/bootstrap.bundle.min.js"></script>
</html>