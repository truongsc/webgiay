<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DAO" %>
<%@page import="entity.account" %>
<%@page import="entity.invoice" %>
<%@page import="java.util.List" %>

<%
    // Kiểm tra đăng nhập
    account acc = (account) session.getAttribute("accountss");
    if (acc == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    DAO dao = new DAO();
    List<invoice> invoices = dao.getInvoicebyID(acc.getId());
    invoice latestInvoice = null;
    if (!invoices.isEmpty()) {
        latestInvoice = invoices.get(invoices.size() - 1); // Lấy đơn hàng mới nhất
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - WEBGIAY</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <style>
        .success-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }
        .success-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding: 40px;
            text-align: center;
            max-width: 600px;
            width: 100%;
        }
        .success-icon {
            width: 100px;
            height: 100px;
            background: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            color: white;
            font-size: 50px;
        }
        .order-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
        }
        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
            color: white;
        }
        .btn-outline {
            border: 2px solid #667eea;
            color: #667eea;
            background: transparent;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-outline:hover {
            background: #667eea;
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    
    <div class="success-container">
        <div class="success-card">
            <div class="success-icon">
                <i class="fa fa-check"></i>
            </div>
            
            <h2 class="text-success mb-3">🎉 Đặt hàng thành công!</h2>
            <p class="text-muted mb-4">Cảm ơn bạn đã mua sắm tại WEBGIAY. Đơn hàng của bạn đã được xác nhận.</p>
            
            <% if (latestInvoice != null) { %>
            <div class="order-details">
                <h5><i class="fa fa-receipt"></i> Thông tin đơn hàng</h5>
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Mã đơn hàng:</strong> #<%= latestInvoice.getIvid() %></p>
                        <p><strong>Ngày đặt:</strong> <%= latestInvoice.getDate() %></p>
                        <p><strong>Tổng tiền:</strong> <span class="text-primary fw-bold">đ<%= String.format("%,d", latestInvoice.getTotal() * 1000) %></span></p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Trạng thái:</strong> 
                            <span class="badge bg-warning text-dark"><%= latestInvoice.getStatus() %></span>
                        </p>
                        <p><strong>Phương thức thanh toán:</strong> <%= (latestInvoice.getDescription() != null && latestInvoice.getDescription().contains("Chuyển khoản")) ? "Chuyển khoản" : "COD" %></p>
                    </div>
                </div>
                
                <hr>
                <h6><i class="fa fa-info-circle"></i> Những bước tiếp theo:</h6>
                <ol class="text-muted">
                    <li>Chúng tôi sẽ xác nhận đơn hàng trong vòng 24 giờ</li>
                    <li>Đơn hàng sẽ được giao trong 2-5 ngày làm việc</li>
                    <li>Bạn sẽ nhận được thông báo qua email/SMS</li>
                </ol>
            </div>
            <% } %>
            
            <div class="mt-4">
                <a href="PaymentHistoryControl" class="btn btn-success me-3">
                    <i class="fa fa-list"></i> Xem lịch sử đơn hàng
                </a>
                <a href="ShopControl" class="btn btn-outline">
                    <i class="fa fa-shopping-bag"></i> Tiếp tục mua sắm
                </a>
            </div>
            
            <div class="mt-4">
                <small class="text-muted">
                    <i class="fa fa-phone"></i> Hỗ trợ: 0123 456 789 | 
                    <i class="fa fa-envelope"></i> Email: support@webgiay.com
                </small>
            </div>
        </div>
    </div>
    
    <jsp:include page="foot.jsp"></jsp:include>
    
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 