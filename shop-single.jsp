<%-- 
    Document   : shop-single
    Created on : Nov 21, 2024, 6:43:09 PM
    Author     : Chi Tien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        
        <style>
            /* Color Selection Styles */
            .color-options {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }
            
            .color-option {
                text-align: center;
            }
            
            .color-label {
                cursor: pointer;
                padding: 10px;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                transition: all 0.3s ease;
            }
            
            .color-label:hover {
                border-color: #007bff;
                transform: translateY(-2px);
            }
            
            input[name="color-radio"]:checked + .color-label {
                border-color: #28a745;
                background-color: #f8fff9;
            }
            
            .color-box {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                margin: 0 auto 5px;
                border: 2px solid #ddd;
            }
            
            .color-black { background-color: #000; }
            .color-white { background-color: #fff; border: 2px solid #ddd; }
            .color-blue { background-color: #007bff; }
            .color-red { background-color: #dc3545; }
            .color-yellow { background-color: #ffc107; }
            .color-default { background-color: #6c757d; }
            
            .color-name {
                font-size: 12px;
                font-weight: 500;
                color: #2c3e50;
            }
            
            /* Size Selection Styles */
            .size-options {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }
            
            .size-option {
                text-align: center;
            }
            
            .size-label {
                cursor: pointer;
                padding: 10px 15px;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                transition: all 0.3s ease;
                position: relative;
                display: block;
            }
            
            .size-label:hover {
                border-color: #007bff;
                transform: translateY(-2px);
            }
            
            input[name="size-radio"]:checked + .size-label {
                border-color: #28a745;
                background-color: #f8fff9;
            }
            
            .size-out-of-stock {
                opacity: 0.5;
                cursor: not-allowed;
            }
            
            .size-out-of-stock:hover {
                transform: none;
                border-color: #e9ecef;
            }
            
            .low-stock {
                position: absolute;
                top: -5px;
                right: -5px;
                background-color: #ffc107;
                color: #000;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                font-size: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }
            
            .stock-info {
                font-size: 12px;
                margin-top: 5px;
            }
            
            .quantity-selector {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .quantity-selector input {
                text-align: center;
                border-radius: 5px;
            }
            
            .quantity-selector input:invalid {
                border-color: #dc3545;
                background-color: #fff5f5;
            }
            
            .quantity-selector input:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }
            
            .btn-checkout {
                background: linear-gradient(135deg, #28a745, #20c997);
                border: none;
                color: white;
                font-weight: bold;
                padding: 15px 30px;
                border-radius: 10px;
                transition: all 0.3s ease;
            }
            
            .btn-checkout:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            
            /* Product Info */
            .product-info {
                border-left: 4px solid #007bff;
            }
            
            /* Responsive */
            @media (max-width: 576px) {
                .color-options, .size-options {
                    justify-content: center;
                }
                
                .color-box {
                    width: 35px;
                    height: 35px;
                }
                
                .size-label {
                    width: 45px;
                    height: 45px;
                }
            }
            
            .alert-stock {
                background-color: #fff3cd;
                border: 1px solid #ffeaa7;
                color: #856404;
                padding: 10px;
                border-radius: 5px;
                margin-top: 10px;
            }
        </style>
    </head>

<body>
    <jsp:include page="head.jsp"></jsp:include>

    

 
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-5 mt-5">
                    <div class="card mb-3">
                        <img class="card-img img-fluid" src="${p.image}" alt="Card image cap" id="product-detail">
                    </div>
                    <div class="row">
                        
                        <div class="col-1 align-self-center">
                            <a href="#multi-item-example" role="button" data-bs-slide="prev">
                                <i class="text-dark fas fa-chevron-left"></i>
                                <span class="sr-only">Previous</span>
                            </a>
                        </div>
                        
                        <div id="multi-item-example" class="col-10 carousel slide carousel-multi-item" data-bs-ride="carousel">
                           
                            <div class="carousel-inner product-links-wap" role="listbox">

                               
                                <div class="carousel-item active">
                                    <div class="row">
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_01.jpg" alt="Product Image 1">
                                            </a>
                                        </div>
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_02.jpg" alt="Product Image 2">
                                            </a>
                                        </div>
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_03.jpg" alt="Product Image 3">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                               

                                
                                <div class="carousel-item">
                                    <div class="row">
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_04.jpg" alt="Product Image 4">
                                            </a>
                                        </div>
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_05.jpg" alt="Product Image 5">
                                            </a>
                                        </div>
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_06.jpg" alt="Product Image 6">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                               

                               
                                <div class="carousel-item">
                                    <div class="row">
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_07.jpg" alt="Product Image 7">
                                            </a>
                                        </div>
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_08.jpg" alt="Product Image 8">
                                            </a>
                                        </div>
                                        <div class="col-4">
                                            <a href="#">
                                                <img class="card-img img-fluid" src="img/product_single_09.jpg" alt="Product Image 9">
                                            </a>
                                        </div>
                                    </div>
                                </div>
                             
                            </div>
                        
                        </div>
                  
                        <div class="col-1 align-self-center">
                            <a href="#multi-item-example" role="button" data-bs-slide="next">
                                <i class="text-dark fas fa-chevron-right"></i>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                 
                    </div>
                </div>
          
                <div class="col-lg-7 mt-5">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">${p.title}</h1>
                            <p class="h3 py-2">
                                <c:choose>
                                    <c:when test="${latestPrice != null}">
                                        <span class="text-danger fw-bold">đ${String.format("%,.0f", latestPrice * 1000)}</span>
                                        <span class="text-muted text-decoration-line-through ms-2">đ${String.format("%,.0f", p.price * 1000)}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger fw-bold">đ${String.format("%,.0f", p.price * 1000)}</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <p class="py-2">
                                <c:choose>
                                    <c:when test="${feedbackCount > 0}">
                                        <span onclick="scrollToFeedback()" style="cursor: pointer;" title="Xem đánh giá chi tiết">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= averageRating}">
                                                        <i class="fa fa-star text-warning"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa fa-star text-secondary"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <span class="list-inline-item text-dark">Rating <fmt:formatNumber value="${averageRating}" pattern="0.0"/> | <a href="#feedback-section" class="text-decoration-none text-primary" onclick="scrollToFeedback()">${feedbackCount} Đánh giá</a></span>
                                    </c:when>
                                                                         <c:otherwise>
                                        <span onclick="scrollToFeedback()" style="cursor: pointer;" title="Xem thông tin đánh giá">
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                        </span>
                                        <span class="list-inline-item text-dark">Rating 5.0 | <a href="#feedback-section" class="text-decoration-none text-muted" onclick="scrollToFeedback()">Chưa có đánh giá</a></span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <ul class="list-inline">
                                <li class="list-inline-item">
                                    <h6>Thương hiệu:</h6>
                                </li>
                                <li class="list-inline-item">
                                    <p class="text-muted"><strong>${p.name}</strong></p>
                                </li>
                            </ul>

                            <h6>Chi tiết:</h6>
                            <p>Sản phẩm best seller</p>
                            
                            <form action="AddtocartControl" method="post" id="product-form">
                                <input type="hidden" name="pid" value="${p.id}">
                                <input type="hidden" name="uid" value="${sessionScope.accountss != null ? sessionScope.accountss.id : '0'}">
                                <input type="hidden" name="color" id="selected-color" value="">
                                <input type="hidden" name="size" id="selected-size" value="">
                                <input type="hidden" name="amount" id="selected-amount" value="1">

                                <!-- Chọn màu sắc -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Màu sắc: <span id="color-display" class="text-muted">Vui lòng chọn màu</span></h6>
                                    <div class="color-options d-flex flex-wrap gap-2">
                                        <c:forEach items="${listc}" var="color" varStatus="status">
                                            <div class="color-option" data-color="${color.color}">
                                                <input type="radio" name="color-radio" id="color-${status.index}" value="${color.color}" class="d-none">
                                                <label for="color-${status.index}" class="color-label">
                                                    <div class="color-box ${color.color == 'Đen' ? 'color-black' : color.color == 'Trắng' ? 'color-white' : color.color == 'Xanh' ? 'color-blue' : color.color == 'Đỏ' ? 'color-red' : color.color == 'Vàng' ? 'color-yellow' : 'color-default'}"></div>
                                                    <span class="color-name">${color.color}</span>
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Chọn kích thước -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Kích thước: <span id="size-display" class="text-muted">Vui lòng chọn size</span></h6>
                                    <div class="size-options d-flex flex-wrap gap-2">
                                        <c:forEach items="${lists}" var="size" varStatus="status">
                                            <div class="size-option" data-size="${size.size}" data-stock="${size.stock}">
                                                <input type="radio" name="size-radio" id="size-${status.index}" value="${size.size}" 
                                                       class="d-none" ${size.stock <= 0 ? 'disabled' : ''}>
                                                <label for="size-${status.index}" class="size-label ${size.stock <= 0 ? 'size-out-of-stock' : ''}">
                                                    ${size.size}
                                                    <c:if test="${size.stock <= 5 && size.stock > 0}">
                                                        <span class="low-stock">!</span>
                                                    </c:if>
                                                </label>
                                                <small class="stock-info">
                                                    <c:choose>
                                                        <c:when test="${size.stock <= 0}">
                                                            <span class="text-danger">Hết hàng</span>
                                                        </c:when>
                                                        <c:when test="${size.stock <= 5}">
                                                            <span class="text-warning">Còn ${size.stock}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-success">Còn ${size.stock}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Chọn số lượng -->
                                <div class="mb-4">
                                    <h6 class="mb-3">Số lượng:</h6>
                                    <div class="quantity-selector d-flex align-items-center">
                                        <button type="button" class="btn btn-outline-secondary btn-sm" id="decrease-btn" onclick="changeQuantity(-1)">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                        <input type="number" class="form-control text-center mx-2" id="quantity-input" value="1" min="1" max="10" style="width: 70px;" readonly>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" id="increase-btn" onclick="changeQuantity(1)">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Thông tin thêm -->
                                <div class="mb-4">
                                    <h6>Thông tin sản phẩm:</h6>
                                    <div class="product-info p-3 bg-light rounded">
                                        <p class="mb-1"><strong>Mô tả:</strong> ${p.description}</p>
                                        <p class="mb-0"><small class="text-muted">Sản phẩm chính hãng, bảo hành đầy đủ</small></p>
                                    </div>
                                </div>

                                <!-- Nút thêm vào giỏ hàng -->
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-success btn-lg" name="submit" value="addtocard" onclick="return validateSelection()">
                                        <i class="fa fa-shopping-cart me-2"></i>Thêm vào giỏ hàng
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Product Feedback Section -->
    <section class="bg-light" id="feedback-section">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>Đánh giá từ khách hàng</h3>
                        </div>
                        <div class="card-body">
                            <!-- Thống kê rating -->
                            <div class="row mb-4">
                                <div class="col-md-4 text-center">
                                    <h2 class="text-warning">
                                        <c:choose>
                                            <c:when test="${averageRating > 0}">
                                                <fmt:formatNumber value="${averageRating}" pattern="0.0"/>
                                            </c:when>
                                            <c:otherwise>0.0</c:otherwise>
                                        </c:choose>
                                    </h2>
                                    <div class="mb-2">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= averageRating}">
                                                    <i class="fa fa-star text-warning"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-star text-secondary"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                    <p class="text-muted">${feedbackCount} đánh giá</p>
                                </div>
                                <div class="col-md-8">
                                    <p class="lead">Sản phẩm này có ${feedbackCount} đánh giá từ khách hàng đã mua.</p>
                                </div>
                            </div>
                            
                            <!-- Danh sách feedback -->
                            <c:if test="${not empty feedbacks}">
                                <h5>Bình luận chi tiết:</h5>
                                <c:forEach items="${feedbacks}" var="feedback">
                                    <div class="border-bottom mb-3 pb-3">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <strong>Khách hàng</strong>
                                                <div class="mb-1">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= feedback.rating}">
                                                                <i class="fa fa-star text-warning"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fa fa-star text-secondary"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <small class="text-muted">${feedback.created_at}</small>
                                        </div>
                                        <p class="mt-2">${feedback.content}</p>
                                    </div>
                                </c:forEach>
                            </c:if>
                            
                            <c:if test="${empty feedbacks}">
                                <div class="text-center py-4">
                                    <p class="text-muted">Chưa có đánh giá nào cho sản phẩm này.</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
     <jsp:include page="foot.jsp"></jsp:include>
    
    <script>
        function scrollToFeedback() {
            const feedbackSection = document.getElementById('feedback-section');
            if (feedbackSection) {
                feedbackSection.scrollIntoView({ 
                    behavior: 'smooth',
                    block: 'start'
                });
                
                // Thêm hiệu ứng highlight
                const card = feedbackSection.querySelector('.card');
                if (card) {
                    card.style.transition = 'all 0.3s ease';
                    card.style.boxShadow = '0 0 20px rgba(0,123,255,0.3)';
                    card.style.border = '2px solid #007bff';
                    
                    // Xóa hiệu ứng sau 3 giây
                    setTimeout(() => {
                        card.style.boxShadow = '';
                        card.style.border = '';
                    }, 3000);
                }
            }
        }
        
        // Xử lý chọn màu sắc
        document.addEventListener('DOMContentLoaded', function() {
            // Color selection
            const colorRadios = document.querySelectorAll('input[name="color-radio"]');
            const colorDisplay = document.getElementById('color-display');
            const selectedColorInput = document.getElementById('selected-color');
            
            colorRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    if (this.checked) {
                        selectedColorInput.value = this.value;
                        colorDisplay.innerHTML = '<strong>' + this.value + '</strong>';
                        colorDisplay.className = 'text-success';
                    }
                });
            });
            
            // Size selection
            const sizeRadios = document.querySelectorAll('input[name="size-radio"]');
            const sizeDisplay = document.getElementById('size-display');
            const selectedSizeInput = document.getElementById('selected-size');
            
            sizeRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    if (this.checked) {
                        const sizeOption = this.closest('.size-option');
                        const stock = parseInt(sizeOption.dataset.stock);
                        
                        selectedSizeInput.value = this.value;
                        sizeDisplay.innerHTML = '<strong>' + this.value + '</strong> <small class="text-muted">(Còn ' + stock + ' sản phẩm)</small>';
                        sizeDisplay.className = 'text-success';
                        
                        // Update quantity input max value based on stock
                        const quantityInput = document.getElementById('quantity-input');
                        const selectedAmountInput = document.getElementById('selected-amount');
                        
                        // Cập nhật max value
                        quantityInput.max = stock;
                        
                        // Reset quantity if current value exceeds stock
                        const currentQuantity = parseInt(quantityInput.value);
                        if (currentQuantity > stock) {
                            const newQuantity = Math.min(stock, 1);
                            quantityInput.value = newQuantity;
                            selectedAmountInput.value = newQuantity;
                            
                            // Hiển thị thông báo
                            if (stock > 0) {
                                alert(`Số lượng đã được điều chỉnh xuống ${newQuantity} do chỉ còn ${stock} sản phẩm trong kho cho size này.`);
                            } else {
                                alert('Size này đã hết hàng!');
                            }
                        }
                        
                        // Disable/enable quantity buttons based on stock
                        const decreaseBtn = document.getElementById('decrease-btn');
                        const increaseBtn = document.getElementById('increase-btn');
                        
                        if (stock <= 0) {
                            quantityInput.disabled = true;
                            decreaseBtn.disabled = true;
                            increaseBtn.disabled = true;
                        } else {
                            quantityInput.disabled = false;
                            decreaseBtn.disabled = false;
                            increaseBtn.disabled = false;
                        }
                    }
                });
            });
            
            // Quantity handling
            const quantityInput = document.getElementById('quantity-input');
            const selectedAmountInput = document.getElementById('selected-amount');
            
            quantityInput.addEventListener('change', function() {
                const selectedSizeRadio = document.querySelector('input[name="size-radio"]:checked');
                
                if (!selectedSizeRadio) {
                    alert('Vui lòng chọn kích thước trước!');
                    this.value = 1;
                    selectedAmountInput.value = 1;
                    return;
                }
                
                const sizeOption = selectedSizeRadio.closest('.size-option');
                const availableStock = parseInt(sizeOption.dataset.stock);
                const inputValue = parseInt(this.value);
                
                // Kiểm tra giá trị hợp lệ
                if (isNaN(inputValue) || inputValue < 1) {
                    alert('Số lượng phải là số nguyên dương!');
                    this.value = 1;
                    selectedAmountInput.value = 1;
                    return;
                }
                
                // Kiểm tra tồn kho
                if (inputValue > availableStock) {
                    alert(`Số lượng vượt quá hàng tồn kho (${availableStock})!`);
                    this.value = availableStock;
                    selectedAmountInput.value = availableStock;
                    return;
                }
                
                selectedAmountInput.value = inputValue;
            });
            
            quantityInput.addEventListener('input', function() {
                const selectedSizeRadio = document.querySelector('input[name="size-radio"]:checked');
                
                if (selectedSizeRadio) {
                    const sizeOption = selectedSizeRadio.closest('.size-option');
                    const availableStock = parseInt(sizeOption.dataset.stock);
                    const inputValue = parseInt(this.value);
                    
                    if (!isNaN(inputValue) && inputValue > availableStock) {
                        this.style.borderColor = '#dc3545';
                        this.style.backgroundColor = '#fff5f5';
                    } else {
                        this.style.borderColor = '';
                        this.style.backgroundColor = '';
                    }
                }
            });
        });
        
        // Xử lý thay đổi số lượng
        function changeQuantity(delta) {
            const input = document.getElementById('quantity-input');
            const selectedAmountInput = document.getElementById('selected-amount');
            const selectedSizeRadio = document.querySelector('input[name="size-radio"]:checked');
            
            if (!selectedSizeRadio) {
                alert('Vui lòng chọn kích thước trước!');
                return;
            }
            
            const sizeOption = selectedSizeRadio.closest('.size-option');
            const availableStock = parseInt(sizeOption.dataset.stock);
            let currentValue = parseInt(input.value);
            let newValue = currentValue + delta;
            
            // Kiểm tra giới hạn tồn kho
            if (newValue > availableStock) {
                alert(`Chỉ còn ${availableStock} sản phẩm trong kho cho size này!`);
                return;
            }
            
            if (newValue >= 1 && newValue <= availableStock) {
                input.value = newValue;
                selectedAmountInput.value = newValue;
            }
        }
        
        // Validation trước khi submit
        function validateSelection() {
            const selectedColor = document.getElementById('selected-color').value;
            const selectedSize = document.getElementById('selected-size').value;
            const selectedAmount = parseInt(document.getElementById('selected-amount').value);
            const selectedSizeRadio = document.querySelector('input[name="size-radio"]:checked');
            
            if (!selectedColor) {
                alert('Vui lòng chọn màu sắc!');
                document.querySelector('.color-options').scrollIntoView({ behavior: 'smooth' });
                return false;
            }
            
            if (!selectedSize) {
                alert('Vui lòng chọn kích thước!');
                document.querySelector('.size-options').scrollIntoView({ behavior: 'smooth' });
                return false;
            }
            
            if (!selectedAmount || selectedAmount < 1) {
                alert('Vui lòng chọn số lượng hợp lệ!');
                return false;
            }
            
            // Kiểm tra tồn kho
            if (selectedSizeRadio) {
                const sizeOption = selectedSizeRadio.closest('.size-option');
                const availableStock = parseInt(sizeOption.dataset.stock);
                
                if (selectedAmount > availableStock) {
                    alert(`Số lượng bạn chọn (${selectedAmount}) vượt quá hàng tồn kho (${availableStock}) cho size này!`);
                    return false;
                }
            }
            
            // Hiển thị thông báo xác nhận
            const confirmMessage = `Thêm vào giỏ hàng:\n• Màu: ${selectedColor}\n• Size: ${selectedSize}\n• Số lượng: ${selectedAmount}`;
            return confirm(confirmMessage);
        }
    </script>
</body>
<script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/jquery-migrate-1.2.1.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/templatemo.js"></script>
    <!-- js chuyen slide -->
    <script src="js/slick.min.js"></script>
    <script src="js/shop-singleCustom.js"></script>
</html>