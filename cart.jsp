<%-- 
    Document   : cart
    Created on : Nov 21, 2024, 6:41:33 PM
    Author     : Chi Tien
--%>
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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
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
        
        .order-summary {
            position: sticky;
            top: 20px;
        }
        
        .btn-order {
            background: linear-gradient(45deg, #28a745, #20c997);
            border: none;
            color: white;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .btn-order:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
            color: white;
        }
        
        .btn-order:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .total-summary {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 10px;
            border: 1px solid #dee2e6;
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
        <div class="container alert alert-success alert-dismissible fade show " role="alert">
            <b class="text-success">${message}</b>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <div class="shopping-cart">
    <div class="px-4 px-lg-0">
        <div class="pb-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">
                        
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
                        
                        <!-- Hien thi san pham -->
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="p-2 px-3 text-uppercase"><b>Chọn</b></div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="p-2 px-3 text-uppercase"><b>Sản Phẩm</b></div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="p-2 px-3 text-uppercase"><b>Màu</b></div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="p-2 px-3 text-uppercase"><b>Size</b></div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase"><b>Đơn Giá</b></div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase"><b>Số Lượng</b></div>
                                    </th>
                                    <th scope="col" class="border-0 bg-light">
                                        <div class="py-2 text-uppercase"><b>Xóa</b></div>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>       
                                <c:set var="totalPrice" value="0" scope="page" />
                                <c:forEach items="${list2}" var="o" varStatus="status">
                                    <tr class="cart-row" data-row-index="${status.index}">
                                        <!-- Checkbox column -->
                                        <td class="align-middle">
                                            <div class="form-check">
                                                <c:forEach items="${list1}" var="p">
                                                    <c:if test="${p.id == o.productID}">
                                                        <input class="form-check-input cart-checkbox item-checkbox" 
                                                               type="checkbox" 
                                                               id="item_${status.index}"
                                                               data-product-id="${o.productID}"
                                                               data-amount="${o.amount}"
                                                               data-price="${latestPriceMap[p.id] != null ? latestPriceMap[p.id] : p.price}"
                                                               data-color="${o.color}"
                                                               data-size="${o.size}"
                                                               data-total="${o.amount * (latestPriceMap[p.id] != null ? latestPriceMap[p.id] : p.price)}">
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </td>
                                        
                                        <c:forEach items="${list1}" var = "p">
                                        <c:if test="${p.id == o.productID}">
                                        <th scope="row">
                                            <div class="p-2">
                                                <img src="${p.image}" alt="" width="70" class="img-fluid rounded shadow-sm">
                                                <div class="ml-3 d-inline-block align-middle">
                                                    <h5 class="mb-0"> <a href="ShopSingleControl?pid=${p.id}" class="text-dark d-inline-block">${p.name}</a></h5><span class="text-muted font-weight-normal font-italic">${p.title}</span>
                                                </div>
                                            </div>
                                        </th>
                                        <td class="align-middle"><strong>${o.color}</strong></td>
                                        <td class="align-middle"><strong>${o.size}</strong></td>
                                        <td class="align-middle">
                                            <c:choose>
                                                <c:when test="${latestPriceMap[p.id] != null}">
                                                    <strong>
                                                        <span class="text-danger">đ${String.format("%,.0f", latestPriceMap[p.id] * 1000)}</span>
                                                        <span class="text-muted text-decoration-line-through ms-2">đ${String.format("%,.0f", p.price * 1000)}</span>
                                                        x ${o.amount}
                                                    </strong>
                                                    <c:set var="totalPrice" value="${totalPrice + (o.amount * latestPriceMap[p.id])}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <strong>
                                                        <span class="text-danger">đ${String.format("%,.0f", p.price * 1000)}</span>
                                                        x ${o.amount}
                                                    </strong>
                                                    <c:set var="totalPrice" value="${totalPrice + (o.amount * p.price)}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        </c:if>
                                        </c:forEach>
                                        
                                        <td class="align-middle">
                                            <a href="#"><button class="btnSub bg-white border-0"><b>-</b></button></a>
                                            <strong>${o.amount}</strong>
                                            <a href="#"><button class="btnAdd bg-white border-0">+</button></a>
                                        </td>
                                        <td class="align-middle"><a href="DeleteCartControl?productID=${o.productID}&amount=${o.amount}&color=${o.color}&size=${o.size}" class="text-dark">
                                            <button type="button" class="btn btn-danger btn-sm">
                                                <i class="fa fa-trash"></i> Xóa
                                            </button>
                                        </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                       
                    </div>
                </div>
                                
                <!-- Thanh toan -->          
                <div class="row py-5 p-4 bg-white rounded shadow-sm">
                    <div class="col-lg-8">
                        <div class="alert alert-info">
                            <i class="fa fa-info-circle"></i>
                            <strong>Hướng dẫn:</strong> Chọn các sản phẩm bạn muốn đặt hàng, sau đó nhấn nút "Đặt hàng" để tiến hành thanh toán.
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="total-summary order-summary">
                            <div class="bg-light px-4 py-3 text-uppercase font-weight-bold">
                                <i class="fa fa-calculator"></i> <b>Thông tin đơn hàng</b>
                            </div>
                            <div class="p-4">
                                <ul class="list-unstyled mb-4">
                                    <li class="d-flex justify-content-between py-2 border-bottom">
                                        <span class="text-muted"><b>Số sản phẩm đã chọn:</b></span>
                                        <strong id="selected-items-count">0</strong>
                                    </li>
                                    <li class="d-flex justify-content-between py-2 border-bottom">
                                        <span class="text-muted"><b>Tổng tiền hàng:</b></span>
                                        <strong id="selected-total-price">0 đ</strong>
                                    </li>
                                    <li class="d-flex justify-content-between py-2 border-bottom">
                                        <span class="text-muted"><b>Phí vận chuyển:</b></span>
                                        <strong class="text-success">Miễn phí</strong>
                                    </li> 
                                    <li class="d-flex justify-content-between py-3 border-bottom bg-light px-3 rounded">
                                        <span class="text-dark"><b>Tổng thanh toán:</b></span>
                                        <h5 class="font-weight-bold text-primary mb-0" id="final-total-price">0 đ</h5>
                                    </li>
                                </ul>
                                
                                <!-- Hidden fields for data -->
                                <input type="hidden" name="date" id="date" value="">
                                <input type="hidden" name="description" id="description" value="">
                                <input type="hidden" name="totalPrice" id="totalPrice" value="0">
                                <input type="hidden" name="selectedItems" id="selectedItems" value="">
                                
                                <button type="button" class="btn btn-order w-100 mb-3" id="order-btn" disabled>
                                    <i class="fa fa-shopping-cart"></i> <b>Đặt hàng (0 sản phẩm)</b>
                                </button>
                                
                                <a href="PaymentHistoryControl" class="btn btn-outline-primary w-100">
                                    <i class="fa fa-history"></i> <b>Lịch sử đơn hàng</b>
                                </a>
                            </div>
                        </div>
                    </div> 
                </div>

            </div>
        </div>
    </div>
    </div>
    <jsp:include page="foot.jsp"></jsp:include>
</body>
    <script src="js/cartGetDate.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Cart page loaded');
            
            const selectAllCheckbox = document.getElementById('selectAll');
            const itemCheckboxes = document.querySelectorAll('.item-checkbox');
            const selectedCountSpan = document.getElementById('selectedCount');
            const orderBtn = document.getElementById('order-btn');
            const paymentForm = document.getElementById('payment-form');
            
            console.log('Found elements:', {
                selectAll: selectAllCheckbox,
                itemCheckboxes: itemCheckboxes.length,
                selectedCountSpan: selectedCountSpan,
                orderBtn: orderBtn,
                paymentForm: paymentForm
            });
            
            // Update order summary
            function updateOrderSummary() {
                console.log('Updating order summary...');
                
                const checkedItems = document.querySelectorAll('.item-checkbox:checked');
                const selectedCount = checkedItems.length;
                let totalPrice = 0;
                let selectedItems = [];
                
                console.log('Checked items:', selectedCount);
                
                checkedItems.forEach(function(checkbox) {
                    const itemTotal = parseInt(checkbox.dataset.total);
                    totalPrice += itemTotal;
                    
                    selectedItems.push({
                        productId: checkbox.dataset.productId,
                        amount: checkbox.dataset.amount,
                        price: checkbox.dataset.price,
                        color: checkbox.dataset.color,
                        size: checkbox.dataset.size,
                        total: itemTotal
                    });
                    
                    console.log('Item:', checkbox.dataset.productId, 'Total:', itemTotal);
                });
                
                // Update UI
                if (selectedCountSpan) selectedCountSpan.textContent = selectedCount;
                if (document.getElementById('selected-items-count')) {
                    document.getElementById('selected-items-count').textContent = selectedCount;
                }
                if (document.getElementById('selected-total-price')) {
                    document.getElementById('selected-total-price').textContent = 'đ' + totalPrice + '.000';
                }
                if (document.getElementById('final-total-price')) {
                    document.getElementById('final-total-price').textContent = 'đ' + totalPrice + '.000';
                }
                
                // Update button
                if (orderBtn) {
                    if (selectedCount > 0) {
                        orderBtn.disabled = false;
                        orderBtn.innerHTML = '<i class="fa fa-shopping-cart"></i> <b>Đặt hàng (' + selectedCount + ' sản phẩm)</b>';
                        orderBtn.classList.remove('btn-secondary');
                        orderBtn.classList.add('btn-order');
                    } else {
                        orderBtn.disabled = true;
                        orderBtn.innerHTML = '<i class="fa fa-shopping-cart"></i> <b>Đặt hàng (0 sản phẩm)</b>';
                        orderBtn.classList.remove('btn-order');
                        orderBtn.classList.add('btn-secondary');
                    }
                }
                
                // Update hidden form fields
                if (document.getElementById('totalPrice')) {
                    document.getElementById('totalPrice').value = totalPrice;
                }
                if (document.getElementById('selectedItems')) {
                    document.getElementById('selectedItems').value = JSON.stringify(selectedItems);
                }
                
                // Update select all checkbox
                if (selectAllCheckbox) {
                    if (selectedCount === itemCheckboxes.length && itemCheckboxes.length > 0) {
                        selectAllCheckbox.checked = true;
                        selectAllCheckbox.indeterminate = false;
                    } else if (selectedCount > 0) {
                        selectAllCheckbox.checked = false;
                        selectAllCheckbox.indeterminate = true;
                    } else {
                        selectAllCheckbox.checked = false;
                        selectAllCheckbox.indeterminate = false;
                    }
                }
                
                // Update row styling
                itemCheckboxes.forEach(function(checkbox) {
                    const row = checkbox.closest('tr');
                    if (checkbox.checked) {
                        row.classList.add('selected-row');
                    } else {
                        row.classList.remove('selected-row');
                    }
                });
                
                console.log('Order summary updated - Total:', totalPrice, 'Items:', selectedCount);
            }
            
            // Select all functionality
            if (selectAllCheckbox) {
                selectAllCheckbox.addEventListener('change', function() {
                    console.log('Select all changed:', this.checked);
                    itemCheckboxes.forEach(function(checkbox) {
                        checkbox.checked = selectAllCheckbox.checked;
                    });
                    updateOrderSummary();
                });
            }
            
            // Individual item selection
            itemCheckboxes.forEach(function(checkbox) {
                checkbox.addEventListener('change', function() {
                    console.log('Item checkbox changed:', this.dataset.productId, this.checked);
                    updateOrderSummary();
                });
            });
            
            // Order button click handler
            if (orderBtn) {
                orderBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Order button clicked');
                    
                    const checkedItems = document.querySelectorAll('.item-checkbox:checked');
                    
                    if (checkedItems.length === 0) {
                        alert('Vui lòng chọn ít nhất một sản phẩm để đặt hàng!');
                        return false;
                    }
                    
                    // Confirmation
                    const selectedCount = checkedItems.length;
                    const totalPrice = document.getElementById('totalPrice') ? document.getElementById('totalPrice').value : '0';
                    const confirmMessage = 'Xác nhận đặt hàng?\n\n' +
                                         '• Số sản phẩm: ' + selectedCount + '\n' +
                                         '• Tổng tiền: đ' + totalPrice + '.000\n\n' +
                                         'Bạn có chắc chắn muốn tiếp tục?';
                    
                    if (!confirm(confirmMessage)) {
                        return false;
                    }
                    
                    // Create description
                    let description = 'Đơn hàng bao gồm: ';
                    checkedItems.forEach(function(checkbox, index) {
                        const productId = checkbox.dataset.productId;
                        const amount = checkbox.dataset.amount;
                        const color = checkbox.dataset.color;
                        const size = checkbox.dataset.size;
                        
                        if (index > 0) description += ', ';
                        description += 'SP' + productId + ' (' + color + ', ' + size + ') x' + amount;
                    });
                    
                    if (document.getElementById('description')) {
                        document.getElementById('description').value = description;
                    }
                    
                    // Chuyển hướng đến checkout với thông tin sản phẩm đã chọn
                    const selectedItemsData = document.getElementById('selectedItems') ? document.getElementById('selectedItems').value : '';
                    console.log('Redirecting to checkout with data:', selectedItemsData);
                    
                    // Sử dụng JavaScript để encode URL
                    const encodedData = encodeURIComponent(selectedItemsData);
                    window.location.href = 'CheckoutControl?selectedItems=' + encodedData;
                });
            }
            
            // Initialize
            console.log('Initializing cart page...');
            updateOrderSummary();
            console.log('Cart page initialization complete');
        });
    </script>
</html>