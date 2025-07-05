<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>FIN SHOES - Cart</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    
    <style>
        .cart-checkbox {
            width: 18px;
            height: 18px;
            margin-right: 10px;
        }
        
        .selected-row {
            background-color: #f8f9fa !important;
            border-left: 4px solid #28a745;
        }
        
        .btn-order {
            background: linear-gradient(45deg, #28a745, #20c997);
            border: none;
            color: white;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        
        .btn-order:hover {
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-order:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
        }
        
        .select-all-container {
            background-color: #e3f2fd;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    
    <c:if test="${not empty message}">
        <div class="container alert alert-success alert-dismissible fade show" role="alert">
            <b class="text-success">${message}</b>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <div class="container mt-4">
        <h2><i class="fa fa-shopping-cart"></i> Giỏ hàng</h2>
        
        <!-- Select All Option -->
        <div class="select-all-container">
            <div class="form-check">
                <input class="form-check-input cart-checkbox" type="checkbox" id="selectAll">
                <label class="form-check-label fw-bold" for="selectAll">
                    <i class="fa fa-check-square"></i> Chọn tất cả sản phẩm
                </label>
                <span class="ms-3 text-muted">(<span id="selectedCount">0</span> sản phẩm được chọn)</span>
            </div>
        </div>
        
        <!-- Cart Items -->
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th><b>Chọn</b></th>
                        <th><b>Sản Phẩm</b></th>
                        <th><b>Màu</b></th>
                        <th><b>Size</b></th>
                        <th><b>Đơn Giá</b></th>
                        <th><b>Số Lượng</b></th>
                        <th><b>Xóa</b></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list2}" var="o" varStatus="status">
                        <tr class="cart-row">
                            <td>
                                <c:forEach items="${list1}" var="p">
                                    <c:if test="${p.id == o.productID}">
                                        <input class="form-check-input cart-checkbox item-checkbox" 
                                               type="checkbox" 
                                               data-product-id="${o.productID}"
                                               data-amount="${o.amount}"
                                               data-price="${p.price}"
                                               data-color="${o.color}"
                                               data-size="${o.size}"
                                               data-total="${o.amount * p.price}">
                                    </c:if>
                                </c:forEach>
                            </td>
                            
                            <c:forEach items="${list1}" var="p">
                                <c:if test="${p.id == o.productID}">
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${p.image}" alt="" width="50" class="me-3">
                                            <div>
                                                <h6 class="mb-0">${p.name}</h6>
                                                <small class="text-muted">${p.title}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td><strong>${o.color}</strong></td>
                                    <td><strong>${o.size}</strong></td>
                                    <td><strong>đ${String.format("%,.0f", p.price * 1000)}</strong></td>
                                </c:if>
                            </c:forEach>
                            
                            <td>
                                <strong>${o.amount}</strong>
                            </td>
                            
                            <td>
                                <a href="DeleteCartControl?productID=${o.productID}&amount=${o.amount}&color=${o.color}&size=${o.size}" 
                                   class="btn btn-danger btn-sm">
                                    <i class="fa fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Order Summary -->
        <div class="row mt-4">
            <div class="col-md-8">
                <div class="alert alert-info">
                    <i class="fa fa-info-circle"></i>
                    <strong>Hướng dẫn:</strong> Chọn các sản phẩm bạn muốn đặt hàng, sau đó nhấn nút "Đặt hàng".
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fa fa-calculator"></i> Thông tin đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Số sản phẩm:</span>
                            <strong id="selected-items-count">0</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tổng tiền:</span>
                            <strong id="selected-total-price">0 đ</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Phí vận chuyển:</span>
                            <strong class="text-success">Miễn phí</strong>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <span><strong>Tổng thanh toán:</strong></span>
                            <h5 class="text-primary mb-0" id="final-total-price">0 đ</h5>
                        </div>
                        
                        <!-- Hidden fields -->
                        <input type="hidden" id="totalPrice" value="0">
                        <input type="hidden" id="selectedItems" value="">
                        
                        <button type="button" class="btn btn-order w-100 mb-2" id="order-btn" disabled>
                            <i class="fa fa-shopping-cart"></i> <b>Đặt hàng (0 sản phẩm)</b>
                        </button>
                        
                        <a href="PaymentHistoryControl" class="btn btn-outline-primary w-100">
                            <i class="fa fa-history"></i> Lịch sử đơn hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="foot.jsp"></jsp:include>
    
    <script src="js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Cart simple page loaded');
            
            const selectAll = document.getElementById('selectAll');
            const itemCheckboxes = document.querySelectorAll('.item-checkbox');
            const selectedCount = document.getElementById('selectedCount');
            const orderBtn = document.getElementById('order-btn');
            
            console.log('Elements found:', {
                selectAll: selectAll,
                itemCheckboxes: itemCheckboxes.length,
                selectedCount: selectedCount,
                orderBtn: orderBtn
            });
            
            function updateOrderSummary() {
                const checkedItems = document.querySelectorAll('.item-checkbox:checked');
                const count = checkedItems.length;
                let total = 0;
                let selectedItems = [];
                
                checkedItems.forEach(function(checkbox) {
                    const itemTotal = parseInt(checkbox.dataset.total);
                    total += itemTotal;
                    
                    selectedItems.push({
                        productId: checkbox.dataset.productId,
                        amount: checkbox.dataset.amount,
                        price: checkbox.dataset.price,
                        color: checkbox.dataset.color,
                        size: checkbox.dataset.size,
                        total: itemTotal
                    });
                    
                    // Highlight selected rows
                    const row = checkbox.closest('tr');
                    row.classList.add('selected-row');
                });
                
                // Remove highlight from unselected rows
                document.querySelectorAll('.cart-row').forEach(function(row) {
                    const checkbox = row.querySelector('.item-checkbox');
                    if (!checkbox.checked) {
                        row.classList.remove('selected-row');
                    }
                });
                
                // Update UI
                selectedCount.textContent = count;
                document.getElementById('selected-items-count').textContent = count;
                document.getElementById('selected-total-price').textContent = 'đ' + total.toLocaleString();
                document.getElementById('final-total-price').textContent = 'đ' + total.toLocaleString();
                
                // Update button
                if (count > 0) {
                    orderBtn.disabled = false;
                    orderBtn.innerHTML = '<i class="fa fa-shopping-cart"></i> <b>Đặt hàng (' + count + ' sản phẩm)</b>';
                } else {
                    orderBtn.disabled = true;
                    orderBtn.innerHTML = '<i class="fa fa-shopping-cart"></i> <b>Đặt hàng (0 sản phẩm)</b>';
                }
                
                // Update hidden fields
                document.getElementById('totalPrice').value = total;
                document.getElementById('selectedItems').value = JSON.stringify(selectedItems);
                
                // Update select all
                if (count === itemCheckboxes.length && itemCheckboxes.length > 0) {
                    selectAll.checked = true;
                    selectAll.indeterminate = false;
                } else if (count > 0) {
                    selectAll.checked = false;
                    selectAll.indeterminate = true;
                } else {
                    selectAll.checked = false;
                    selectAll.indeterminate = false;
                }
                
                console.log('Updated:', count, 'items, total:', total);
            }
            
            // Select all
            selectAll.addEventListener('change', function() {
                itemCheckboxes.forEach(function(checkbox) {
                    checkbox.checked = selectAll.checked;
                });
                updateOrderSummary();
            });
            
            // Individual items
            itemCheckboxes.forEach(function(checkbox) {
                checkbox.addEventListener('change', updateOrderSummary);
            });
            
            // Order button
            orderBtn.addEventListener('click', function() {
                const checkedItems = document.querySelectorAll('.item-checkbox:checked');
                if (checkedItems.length === 0) {
                    alert('Vui lòng chọn ít nhất một sản phẩm!');
                    return;
                }
                
                const selectedItems = [];
                checkedItems.forEach(function(checkbox) {
                    selectedItems.push({
                        productId: checkbox.dataset.productId,
                        amount: checkbox.dataset.amount,
                        price: checkbox.dataset.price,
                        color: checkbox.dataset.color,
                        size: checkbox.dataset.size,
                        total: checkbox.dataset.total
                    });
                });
                
                const totalPrice = document.getElementById('totalPrice').value;
                const confirmMsg = 'Xác nhận đặt hàng?\n\n' +
                                 'Số sản phẩm: ' + checkedItems.length + '\n' +
                                 'Tổng tiền: đ' + totalPrice.toLocaleString() + '\n\n' +
                                 'Bạn có chắc chắn muốn tiếp tục?';
                
                if (confirm(confirmMsg)) {
                    const data = JSON.stringify(selectedItems);
                    const encodedData = encodeURIComponent(data);
                    window.location.href = 'CheckoutControl?selectedItems=' + encodedData;
                }
            });
            
            // Initialize
            updateOrderSummary();
            console.log('Cart simple initialization complete');
        });
    </script>
</body>
</html> 