<%-- 
    Document   : editproduct
    Created on : Nov 23, 2024, 5:58:20 PM
    Author     : Chi Tien
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <div class="container mt-4">
        <h2 class="text-danger">Chỉnh sửa thông tin sản phẩm</h2>
        <form action="EditproductControl2" method="post">
            <div class="mb-3">
                <label class="form-label"><b>ID:</b></label>
                <input value="${editproduct.id}" type="text" class="form-control" name="id" required readonly>
            </div>
            <div class="mb-3">
                <label class="form-label"><b>Tên sản phẩm:</b></label>
                <input value="${editproduct.name}" type="text" class="form-control" name="name" required>
            </div>
            <div class="mb-3">
                <label class="form-label"><b>Hình ảnh:</b></label>
                <input value="${editproduct.image}" type="text" class="form-control" name="image" required>
            </div>
            <div class="mb-3">
                <label class="form-label"><b>Giá</b>:</label>
                <input value="" type="text" class="form-control" name="price" placeholder="Nhập giá mới nếu muốn cập nhật">
            </div>
            <div class="mb-3">
                <label class="form-label"><b>Tiêu đề sản phẩm:</b></label>
                <input value="${editproduct.title}" type="text" class="form-control" name="title" required>
            </div>
            <div class="mb-3">
                <label class="form-label"><b>Mô tả sản phẩm:</b></label>
                <input value="${editproduct.description}" type="text" class="form-control" name="description" required>
            </div>
            <div class="mb-3">
    
                <label><b>Chọn danh mục sản phẩm:</b></label>
                    <br>
                    <select name="category" class="form-select" aria-label="Default select example">
                    <c:forEach items="${listc}" var="o">
                        <option value="${o.cid}" <c:if test="${o.cid == editproduct.cateID}">selected</c:if>>${o.cname}</option>
                    </c:forEach>
                    </select>
            </div>
            <button type="submit" class="btn btn-danger">Lưu</button>
            <a href="ProductmanagementControl" class="btn btn-secondary">Quay lại</a>
        </form>
        <br> <br>
    </div>
    <jsp:include page="foot.jsp"></jsp:include>
</body>
    <script src="js/bootstrap.bundle.min.js"></script>
</html>