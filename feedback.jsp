<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>FIN SHOES - Đánh Giá Sản Phẩm</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    
    <style>
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            font-size: 2.5rem;
            justify-content: center;
            padding: 10px 0;
            text-align: center;
        }
        
        .star-rating input {
            display: none;
        }
        
        .star-rating label {
            color: #ddd;
            cursor: pointer;
            display: block;
            transition: color 0.2s;
            padding: 5px;
            user-select: none;
        }
        
        .star-rating label:hover {
            color: #ffc107;
            transform: scale(1.1);
        }
        
        .star-rating input:checked ~ label,
        .star-rating label:hover ~ label {
            color: #ffc107;
        }
        
        .star-rating input:checked + label {
            color: #ffc107;
        }
    </style>
</head>

<body>
    <jsp:include page="head.jsp"></jsp:include>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">
                            <c:choose>
                                <c:when test="${isEdit}">Sửa Đánh Giá Sản Phẩm</c:when>
                                <c:otherwise>Đánh Giá Sản Phẩm</c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>
                        
                        <form action="FeedbackControl" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="action" value="submit">
                            <input type="hidden" name="invoiceId" value="${invoiceId}">
                            <c:if test="${isEdit}">
                                <input type="hidden" name="isEdit" value="true">
                            </c:if>
                            

                            
                            <div class="mb-4">
                                <label class="form-label"><strong>Đánh giá của bạn:</strong></label>
                                <div class="star-rating">
                                    <input type="radio" name="rating" value="5" id="5-stars" 
                                           ${existingFeedback.rating == 5 ? 'checked' : ''}>
                                    <label for="5-stars" class="star">★</label>
                                    <input type="radio" name="rating" value="4" id="4-stars"
                                           ${existingFeedback.rating == 4 ? 'checked' : ''}>
                                    <label for="4-stars" class="star">★</label>
                                    <input type="radio" name="rating" value="3" id="3-stars"
                                           ${existingFeedback.rating == 3 ? 'checked' : ''}>
                                    <label for="3-stars" class="star">★</label>
                                    <input type="radio" name="rating" value="2" id="2-stars"
                                           ${existingFeedback.rating == 2 ? 'checked' : ''}>
                                    <label for="2-stars" class="star">★</label>
                                    <input type="radio" name="rating" value="1" id="1-star"
                                           ${existingFeedback.rating == 1 ? 'checked' : ''}>
                                    <label for="1-star" class="star">★</label>
                                </div>
                                <div id="rating-display" class="mt-2 text-muted">
                                    <small>Chọn số sao để đánh giá</small>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="content" class="form-label"><strong>Nhận xét của bạn:</strong></label>
                                <textarea class="form-control" id="content" name="content" rows="5" 
                                          placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm..." required>${existingFeedback.content}</textarea>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="PaymentHistoryControl" class="btn btn-secondary me-md-2">Hủy</a>
                                <button type="submit" class="btn btn-success">
                                    <c:choose>
                                        <c:when test="${isEdit}">Cập Nhật Đánh Giá</c:when>
                                        <c:otherwise>Gửi Đánh Giá</c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="foot.jsp"></jsp:include>
    
    <script src="js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Xử lý star rating
            const ratingInputs = document.querySelectorAll('input[name="rating"]');
            const ratingDisplay = document.getElementById('rating-display');
            
            ratingInputs.forEach(function(input) {
                input.addEventListener('change', function() {
                    if (this.checked) {
                        const rating = this.value;
                        const stars = '★'.repeat(rating) + '☆'.repeat(5 - rating);
                        ratingDisplay.innerHTML = '<small><strong>' + rating + '/5 sao: ' + stars + '</strong></small>';
                        ratingDisplay.className = 'mt-2 text-warning';
                    }
                });
            });
        });
        
        function validateForm() {
            // Kiểm tra rating
            var ratingInputs = document.querySelectorAll('input[name="rating"]:checked');
            
            if (ratingInputs.length === 0) {
                alert('Vui lòng chọn số sao đánh giá!');
                return false;
            }
            
            // Kiểm tra content
            var content = document.querySelector('textarea[name="content"]').value;
            
            if (!content || content.trim() === '') {
                alert('Vui lòng nhập nội dung đánh giá!');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html> 