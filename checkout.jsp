<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.DAO" %>
<%@page import="entity.account" %>
<%@page import="entity.cart" %>
<%@page import="entity.product" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%
    // Kiểm tra đăng nhập
    account acc = (account) session.getAttribute("accountss");
    if (acc == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    DAO dao = new DAO();
    
    // Lấy danh sách sản phẩm đã chọn từ session
    String selectedItemsJson = (String) session.getAttribute("selectedItems");
    List<cart> selectedItems = new ArrayList<>();
    double totalPrice = 0;
    
    System.out.println("Checkout.jsp - Selected items from session: " + selectedItemsJson);
    
    if (selectedItemsJson != null && !selectedItemsJson.trim().isEmpty()) {
        try {
            // Parse JSON sử dụng JavaScript Object Notation
            // Ví dụ: [{"productId":"1","amount":"2","color":"Đen","size":"40","price":"500","total":"1000"}]
            String jsonStr = selectedItemsJson;
            
            // Loại bỏ dấu ngoặc vuông đầu và cuối
            if (jsonStr.startsWith("[") && jsonStr.endsWith("]")) {
                jsonStr = jsonStr.substring(1, jsonStr.length() - 1);
            }
            
            // Tách các object
            String[] objects = jsonStr.split("\\},\\{");
            
            for (int i = 0; i < objects.length; i++) {
                String obj = objects[i];
                
                // Loại bỏ dấu ngoặc nhọn
                if (obj.startsWith("{")) obj = obj.substring(1);
                if (obj.endsWith("}")) obj = obj.substring(0, obj.length() - 1);
                
                // Parse các cặp key-value
                String[] pairs = obj.split(",");
                int productId = 0, amount = 0, size = 0;
                String color = "";
                double price = 0;
                
                for (String pair : pairs) {
                    String[] keyValue = pair.split(":");
                    if (keyValue.length == 2) {
                        String key = keyValue[0].trim().replace("\"", "");
                        String value = keyValue[1].trim().replace("\"", "");
                        
                        switch (key) {
                            case "productId":
                                productId = Integer.parseInt(value);
                                break;
                            case "amount":
                                amount = Integer.parseInt(value);
                                break;
                            case "color":
                                color = value;
                                break;
                            case "size":
                                size = Integer.parseInt(value);
                                break;
                            case "price":
                                price = Double.parseDouble(value);
                                break;
                        }
                    }
                }
                
                if (productId > 0 && amount > 0) {
                    cart cartItem = new cart();
                    cartItem.setProductID(productId);
                    cartItem.setAmount(amount);
                    cartItem.setColor(color);
                    cartItem.setSize(size);
                    selectedItems.add(cartItem);
                    
                    // Tính tổng tiền
                    product p = dao.getProductByid(String.valueOf(productId));
                    Double latest = dao.getLatestPriceByProductId(productId);
                    double priceToUse = (latest != null) ? latest : p.getPrice();
                    totalPrice += amount * priceToUse;
                    
                    System.out.println("Checkout.jsp - Added item: ProductID=" + productId + 
                                     ", Amount=" + amount + ", Color=" + color + 
                                     ", Size=" + size + ", Price=" + priceToUse);
                }
            }
        } catch (Exception e) {
            System.out.println("Checkout.jsp - Error parsing JSON: " + e.getMessage());
            e.printStackTrace();
            
            // Fallback: lấy tất cả sản phẩm trong giỏ hàng
            selectedItems = dao.getCartByAccountID(acc.getId());
            for (cart item : selectedItems) {
                product p = dao.getProductByid(String.valueOf(item.getProductID()));
                if (p != null) {
                    totalPrice += item.getAmount() * p.getPrice();
                }
            }
        }
    } else {
        System.out.println("Checkout.jsp - No selected items in session, using all cart items");
        // Nếu không có selectedItems, lấy tất cả sản phẩm trong giỏ hàng
        selectedItems = dao.getCartByAccountID(acc.getId());
        for (cart item : selectedItems) {
            product p = dao.getProductByid(String.valueOf(item.getProductID()));
            if (p != null) {
                totalPrice += item.getAmount() * p.getPrice();
            }
        }
    }
    
    System.out.println("Checkout.jsp - Total items: " + selectedItems.size() + ", Total price: " + totalPrice);
    
    // Nếu không có sản phẩm nào, chuyển về giỏ hàng
    if (selectedItems.isEmpty()) {
        response.sendRedirect("CartControl");
        return;
    }
    
    // Chuẩn bị map giá mới nhất cho từng sản phẩm
    java.util.HashMap<Integer, Double> latestPriceMap = new java.util.HashMap<>();
    for (cart item : selectedItems) {
        Double latest = dao.getLatestPriceByProductId(item.getProductID());
        if (latest != null) latestPriceMap.put(item.getProductID(), latest);
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - WEBGIAY</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <style>
        .checkout-container {
            background: #f8f9fa;
            min-height: 100vh;
            padding: 40px 0;
        }
        .checkout-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .checkout-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px 10px 0 0;
        }
        .form-section {
            padding: 25px;
            border-bottom: 1px solid #eee;
        }
        .form-section:last-child {
            border-bottom: none;
        }
        .section-title {
            color: #333;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        .section-title i {
            margin-right: 10px;
            color: #667eea;
        }
        .order-summary {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .payment-method {
            border: 2px solid #eee;
            border-radius: 8px;
            padding: 15px;
            margin: 10px 0;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .payment-method:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }
        .payment-method.selected {
            border-color: #667eea;
            background: #f0f4ff;
        }
        .payment-method input[type="radio"] {
            margin-right: 10px;
        }
        .btn-checkout {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            color: white;
        }
        .total-price {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
        }
        .product-info {
            display: flex;
            align-items: center;
        }
        .product-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    
    <div class="checkout-container">
        <div class="container">
            <div class="row">
                <!-- Form thông tin người nhận -->
                <div class="col-lg-8">
                    <div class="checkout-card">
                        <div class="checkout-header">
                            <h3><i class="fa fa-shopping-cart"></i> Thông tin đặt hàng</h3>
                            <p class="mb-0">Vui lòng điền đầy đủ thông tin để hoàn tất đơn hàng</p>
                        </div>
                        
                        <form action="PaymentControl" method="post" id="checkout-form">
                            <!-- Thông tin người nhận -->
                            <div class="form-section">
                                <h5 class="section-title">
                                    <i class="fa fa-user"></i> Thông tin người nhận hàng
                                </h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="receiverName" class="form-label">Họ và tên *</label>
                                            <input type="text" class="form-control" id="receiverName" name="receiverName" 
                                                   value="<%= acc.getUser() %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="receiverPhone" class="form-label">Số điện thoại *</label>
                                            <input type="tel" class="form-control" id="receiverPhone" name="receiverPhone" 
                                                   placeholder="0123456789" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="receiverAddress" class="form-label">Địa chỉ giao hàng *</label>
                                    <textarea class="form-control" id="receiverAddress" name="receiverAddress" 
                                              rows="3" placeholder="Nhập địa chỉ chi tiết..." required></textarea>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="receiverCity" class="form-label">Tỉnh/Thành phố *</label>
                                            <select class="form-select" id="receiverCity" name="receiverCity" required>
                                                <option value="">Chọn tỉnh/thành phố</option>
                                                <option value="Hà Nội">Hà Nội</option>
                                                <option value="TP.HCM">TP.HCM</option>
                                                <option value="Đà Nẵng">Đà Nẵng</option>
                                                <option value="Hải Phòng">Hải Phòng</option>
                                                <option value="Cần Thơ">Cần Thơ</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="receiverDistrict" class="form-label">Quận/Huyện *</label>
                                            <input type="text" class="form-control" id="receiverDistrict" name="receiverDistrict" 
                                                   placeholder="Nhập quận/huyện" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="receiverNote" class="form-label">Ghi chú</label>
                                    <textarea class="form-control" id="receiverNote" name="receiverNote" 
                                              rows="2" placeholder="Ghi chú thêm về địa chỉ giao hàng..."></textarea>
                                </div>
                            </div>
                            
                            <!-- Phương thức thanh toán -->
                            <div class="form-section">
                                <h5 class="section-title">
                                    <i class="fa fa-credit-card"></i> Phương thức thanh toán
                                </h5>
                                <div class="payment-method" onclick="selectPayment('cod')">
                                    <input type="radio" name="paymentMethod" id="cod" value="cod" checked>
                                    <label for="cod">
                                        <i class="fa fa-money-bill-wave text-success"></i>
                                        <strong>Thanh toán khi nhận hàng (COD)</strong>
                                        <br>
                                        <small class="text-muted">Thanh toán bằng tiền mặt khi nhận hàng</small>
                                    </label>
                                </div>
                                <div class="payment-method" onclick="selectPayment('bank')">
                                    <input type="radio" name="paymentMethod" id="bank" value="bank">
                                    <label for="bank">
                                        <i class="fa fa-university text-primary"></i>
                                        <strong>Chuyển khoản ngân hàng</strong>
                                        <br>
                                        <small class="text-muted">Chuyển khoản trước khi giao hàng</small>
                                    </label>
                                </div>
                                <div class="payment-method" onclick="selectPayment('momo')">
                                    <input type="radio" name="paymentMethod" id="momo" value="momo">
                                    <label for="momo">
                                        <i class="fa fa-mobile-alt text-danger"></i>
                                        <strong>Ví MoMo</strong>
                                        <br>
                                        <small class="text-muted">Thanh toán qua ví điện tử MoMo</small>
                                    </label>
                                </div>
                            </div>
                            
                            <!-- Hidden fields -->
                            <input type="hidden" name="date" id="date" value="">
                            <input type="hidden" name="description" id="description" value="">
                            <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
                            <input type="hidden" name="selectedItems" value="<%= selectedItemsJson != null ? selectedItemsJson : "all" %>">
                            
                            <!-- Nút đặt hàng -->
                            <div class="form-section text-center">
                                <button type="submit" class="btn btn-checkout btn-lg">
                                    <i class="fa fa-check"></i> Xác nhận đặt hàng
                                </button>
                                <a href="CartControl" class="btn btn-outline-secondary btn-lg ms-3">
                                    <i class="fa fa-arrow-left"></i> Quay lại giỏ hàng
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Tóm tắt đơn hàng -->
                <div class="col-lg-4">
                    <div class="checkout-card">
                        <div class="checkout-header">
                            <h5><i class="fa fa-list"></i> Tóm tắt đơn hàng</h5>
                        </div>
                        <div class="form-section">
                            <div class="order-summary">
                                <h6 class="mb-3">Sản phẩm đã chọn (<%= selectedItems.size() %>)</h6>
                                
                                <% for (cart item : selectedItems) { 
                                    product p = dao.getProductByid(String.valueOf(item.getProductID()));
                                    if (p != null) {
                                %>
                                <div class="order-item">
                                    <div class="product-info">
                                        <img src="<%= p.getImage() %>" alt="" width="50" class="img-fluid rounded shadow-sm me-2">
                                        <div>
                                            <strong><%= p.getName() %> (x<%= item.getAmount() %>)</strong><br>
                                            <small class="text-muted">
                                                Size: <%= item.getSize() %> | 
                                                Màu: <%= item.getColor() %>
                                            </small>
                                        </div>
                                    </div>
                                    <div>
                                        <% Double latest = latestPriceMap.get(item.getProductID()); %>
                                        <% if (latest != null) { %>
                                            <span class="text-danger fw-bold">đ<%= String.format("%,.0f", latest * 1000) %></span>
                                            <span class="text-muted text-decoration-line-through ms-2">đ<%= String.format("%,.0f", p.getPrice() * 1000) %></span>
                                        <% } else { %>
                                            <span class="text-danger fw-bold">đ<%= String.format("%,.0f", p.getPrice() * 1000) %></span>
                                        <% } %>
                                    </div>
                                </div>
                                <% } } %>
                                
                                <hr>
                                <div class="order-item">
                                    <strong>Tổng cộng:</strong>
                                    <div class="total-price"><%= String.format("đ%,.0f", totalPrice * 1000) %></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="foot.jsp"></jsp:include>
    
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/cartGetDate.js"></script>
    <script>
        // Chọn phương thức thanh toán
        function selectPayment(method) {
            // Bỏ chọn tất cả
            document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
                radio.checked = false;
            });
            
            // Chọn phương thức được click
            document.getElementById(method).checked = true;
            
            // Cập nhật style
            document.querySelectorAll('.payment-method').forEach(div => {
                div.classList.remove('selected');
            });
            event.currentTarget.classList.add('selected');
        }
        
        // Validation form
        document.getElementById('checkout-form').addEventListener('submit', function(e) {
            const receiverName = document.getElementById('receiverName').value.trim();
            const receiverPhone = document.getElementById('receiverPhone').value.trim();
            const receiverAddress = document.getElementById('receiverAddress').value.trim();
            const receiverCity = document.getElementById('receiverCity').value;
            const receiverDistrict = document.getElementById('receiverDistrict').value.trim();
            
            if (!receiverName || !receiverPhone || !receiverAddress || !receiverCity || !receiverDistrict) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                return false;
            }
            
            // Validate phone number
            const phoneRegex = /^[0-9]{10,11}$/;
            if (!phoneRegex.test(receiverPhone)) {
                e.preventDefault();
                alert('Số điện thoại không hợp lệ! Vui lòng nhập 10-11 chữ số.');
                return false;
            }
            
            // Confirmation
            const orderTotalPrice = <%= totalPrice %>;
            const confirmMessage = `Xác nhận đặt hàng?\n\n` +
                                 `• Tổng tiền: đ${orderTotalPrice.toLocaleString()}\n` +
                                 `• Số sản phẩm: <%= selectedItems.size() %>\n\n` +
                                 `Bạn có chắc chắn muốn tiếp tục?`;
            
            if (!confirm(confirmMessage)) {
                e.preventDefault();
                return false;
            }
        });
        
        // Tạo description cho đơn hàng
        document.addEventListener('DOMContentLoaded', function() {
            const description = 'Đơn hàng bao gồm: ' + 
                              '<%= selectedItems.size() %> sản phẩm - ' +
                              'Tổng tiền: <%= String.format("đ%,.0f", totalPrice * 1000) %>';
            document.getElementById('description').value = description;
        });
    </script>
</body>
</html> 