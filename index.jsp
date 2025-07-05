<%-- 
    Document   : index
    Created on : Nov 21, 2024, 6:42:12 PM
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
    <c:if test="${not empty message}">
        <div class="container alert alert-success alert-dismissible fade show " role="alert">
            <b class="text-success">${message}</b>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <!-- Slide cac san pham chinh -->
    <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
        <ol class="carousel-indicators">
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="1"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./img/banner_img_01.jpg" " alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left align-self-center">
                                <h1 class="h1 text-success">Nike</h1>
                                <h3 class="h2 ">Thương hiệu hàng đầu</h3>
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./img/banner_img_02.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h1 class="h1 text-success">Adidas</h1>
                                <h3 class="h2">Thương hiệu hàng đầu</h3>
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./img/banner_img_03.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h1 class="h1 text-success">Puma</h1>
                                <h3 class="h2">Thương hiệu hàng đầu</h3>
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev text-decoration-none w-auto ps-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="prev">
            <i class="fas fa-chevron-left"></i>
        </a>
        <a class="carousel-control-next text-decoration-none w-auto pe-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="next">
            <i class="fas fa-chevron-right"></i>
        </a>
    </div>
    <!-- Top 3 danh muc cua thang -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">Danh Mục của tháng</h1>
                <p>
                    Danh mục bán chạy nhất
                </p>
            </div>
        </div>
        <div class="row">
        <c:forEach items="${list3c}" var = "o">
            <div class="col-12 col-md-4 p-5 mt-3">
                <a href="#"><img src="${o.cimage}" class="rounded-circle img-fluid border"></a>
                <h5 class="text-center mt-3 mb-3">${o.cname}</h5>
                <p class="text-center"><a href="PhanLoaiControl?cid=${o.cid}" class="btn btn-success">Mua ngay</a></p>
            </div>
        </c:forEach>
        </div>
    </section>
    <!-- Top 3 san pham cua thang -->
    <section class="bg-light">
        <div class="container py-5">
            <div class="row text-center py-3">
                <div class="col-lg-6 m-auto">
                    <h1 class="h1">Sản phẩm nổi bật</h1>
                    <p>
                        Sản phẩm bán chạy nhất tháng
                    </p>
                </div>
            </div>
            <div class="row">     
            <c:forEach items="${list3p}" var="o">
                <div class="col-12 col-md-4 mb-4">
                    <div class="card h-100">
                        <a href="ShopSingleControl?pid=${o.id}">
                            <img src="${o.image}" class="card-img-top" alt="...">
                        </a>
                        <div class="card-body">
                            <ul class="list-unstyled d-flex justify-content-between">
                                <li>
                                    <i class="text-warning fa fa-star"></i>
                                    <i class="text-warning fa fa-star"></i>
                                    <i class="text-warning fa fa-star"></i>
                                    <i class="text-warning fa fa-star"></i>
                                    <i class="text-warning fa fa-star"></i>
                                </li>
                                <li class="text-muted text-right">đ${String.format("%,.0f", o.price * 1000)}</li>
                            </ul>
                            <a href="ShopSingleControl?pid=${o.id}" class="h2 text-decoration-none text-dark">${o.name}</a>
                            <p class="text-muted">Reviews (1000)</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
            </div>  
        </div>
    </section>
    <jsp:include page="foot.jsp"></jsp:include>
</body>
    <script src="js/bootstrap.bundle.min.js"></script>
</html>