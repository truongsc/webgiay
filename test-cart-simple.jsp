<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test Cart Simple</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .cart-item { border: 1px solid #ddd; padding: 10px; margin: 10px 0; }
        .selected { background-color: #e8f5e8; border-color: #28a745; }
        .checkbox { margin-right: 10px; }
        .total { font-weight: bold; color: #28a745; }
        .btn { padding: 10px 20px; background: #28a745; color: white; border: none; cursor: pointer; }
        .btn:disabled { background: #ccc; cursor: not-allowed; }
    </style>
</head>
<body>
    <h1>Test Cart - Chọn sản phẩm</h1>
    
    <div>
        <label>
            <input type="checkbox" id="selectAll" class="checkbox"> 
            <strong>Chọn tất cả</strong>
        </label>
        <span id="selectedCount">(0 sản phẩm được chọn)</span>
    </div>
    
    <hr>
    
    <div id="cartItems">
        <c:forEach items="${list2}" var="o" varStatus="status">
            <c:forEach items="${list1}" var="p">
                <c:if test="${p.id == o.productID}">
                    <div class="cart-item" data-product-id="${o.productID}">
                        <label>
                            <input type="checkbox" class="item-checkbox checkbox" 
                                   data-product-id="${o.productID}"
                                   data-amount="${o.amount}"
                                   data-price="${p.price}"
                                   data-color="${o.color}"
                                   data-size="${o.size}"
                                   data-total="${o.amount * p.price}">
                            <strong>${p.name}</strong> - ${o.color}, Size ${o.size} - ${o.amount} x ${p.price}k = ${o.amount * p.price}k
                        </label>
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>
    </div>
    
    <hr>
    
    <div>
        <p><strong>Tổng tiền: <span id="totalPrice">0</span>đ</strong></p>
        <button id="orderBtn" class="btn" disabled>Đặt hàng</button>
    </div>
    
    <div id="debug">
        <h3>Debug Info:</h3>
        <p>Cart items: <span id="cartItemCount">0</span></p>
        <p>Selected items: <span id="selectedItemCount">0</span></p>
        <p>Selected data: <span id="selectedData">[]</span></p>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Test cart page loaded');
            
            const selectAll = document.getElementById('selectAll');
            const itemCheckboxes = document.querySelectorAll('.item-checkbox');
            const selectedCount = document.getElementById('selectedCount');
            const totalPrice = document.getElementById('totalPrice');
            const orderBtn = document.getElementById('orderBtn');
            const cartItemCount = document.getElementById('cartItemCount');
            const selectedItemCount = document.getElementById('selectedItemCount');
            const selectedData = document.getElementById('selectedData');
            
            console.log('Elements found:', {
                selectAll: selectAll,
                itemCheckboxes: itemCheckboxes.length,
                selectedCount: selectedCount,
                totalPrice: totalPrice,
                orderBtn: orderBtn
            });
            
            // Update cart item count
            cartItemCount.textContent = itemCheckboxes.length;
            
            function updateSelection() {
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
                    
                    // Highlight selected items
                    const cartItem = checkbox.closest('.cart-item');
                    cartItem.classList.add('selected');
                });
                
                // Remove highlight from unselected items
                document.querySelectorAll('.cart-item').forEach(function(item) {
                    const checkbox = item.querySelector('.item-checkbox');
                    if (!checkbox.checked) {
                        item.classList.remove('selected');
                    }
                });
                
                // Update UI
                selectedCount.textContent = `(${count} sản phẩm được chọn)`;
                totalPrice.textContent = total;
                selectedItemCount.textContent = count;
                selectedData.textContent = JSON.stringify(selectedItems);
                
                // Update order button
                if (count > 0) {
                    orderBtn.disabled = false;
                    orderBtn.textContent = `Đặt hàng (${count} sản phẩm)`;
                } else {
                    orderBtn.disabled = true;
                    orderBtn.textContent = 'Đặt hàng';
                }
                
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
                
                console.log('Selection updated:', count, 'items, total:', total);
            }
            
            // Select all functionality
            selectAll.addEventListener('change', function() {
                console.log('Select all changed:', this.checked);
                itemCheckboxes.forEach(function(checkbox) {
                    checkbox.checked = selectAll.checked;
                });
                updateSelection();
            });
            
            // Individual item selection
            itemCheckboxes.forEach(function(checkbox) {
                checkbox.addEventListener('change', function() {
                    console.log('Item checkbox changed:', this.dataset.productId, this.checked);
                    updateSelection();
                });
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
                
                const confirmMsg = 'Xác nhận đặt hàng?\nSố sản phẩm: ' + checkedItems.length + '\nTổng tiền: đ' + totalPrice.textContent.toLocaleString();
                if (confirm(confirmMsg)) {
                    const data = JSON.stringify(selectedItems);
                    const encodedData = encodeURIComponent(data);
                    window.location.href = 'CheckoutControl?selectedItems=' + encodedData;
                }
            });
            
            // Initialize
            updateSelection();
            console.log('Test cart initialization complete');
        });
    </script>
</body>
</html> 