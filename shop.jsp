<%-- 
    Document   : shop
    Created on : Nov 21, 2024, 6:43:42 PM
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
        <link rel="stylesheet" href="css/shopCustom.css">
    </head>

<body>
    <jsp:include page="head.jsp"></jsp:include>

    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">

            <div class="col-lg-3">
                <h1 class="h2 pb-4">Phân loại sản phẩm</h1>
                <ul class="list-unstyled templatemo-accordion">
                    
                    <li class="pb-3">
                        <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                            Sản phẩm
                            <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                        </a>
                        <ul id="collapseThree" class="collapse list-unstyled pl-3">
                            <c:forEach items="${listc}" var="o">
                                <li><a class="text-decoration-none" href="PhanLoaiControl?cid=${o.cid}">${o.cname}</a></li>
                            </c:forEach>
                        </ul>
                    </li>                   
                </ul>
            </div>

            <div class="col-lg-9">
                <div class="row">
                    <div class="col-md-6">
                        <ul class="list-inline shop-top-menu pb-3 pt-1">
                            <li class="list-inline-item">
                                <a class="h3 text-dark text-decoration-none mr-3" href="ShopControl">Tất cả</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${listp}" var="o">
                    <div class="col-md-4">
                        <div class="card mb-4 product-wap rounded-0">
                            <div class="card rounded-0">
                                <img class="card-img rounded-0 img-fluid" src="${o.image}">
                                <div class="card-img-overlay rounded-0 product-overlay d-flex align-items-center justify-content-center">
                                    <ul class="list-unstyled">
                                        <li><a class="btn btn-success text-white" href="ShopSingleControl?pid=${o.id}"><i class="far fa-heart"></i></a></li>
                                        <li><a class="btn btn-success text-white mt-2" href="ShopSingleControl?pid=${o.id}"><i class="far fa-eye"></i></a></li>
                                        <li><a class="btn btn-success text-white mt-2" href="ShopSingleControl?pid=${o.id}"><i class="fas fa-cart-plus"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <a href="ShopSingleControl?pid=${o.id}" class="h3 text-decoration-none">${o.name}</a>
                                <ul class="w-100 list-unstyled d-flex justify-content-between mb-0">
                                    <li>Size 36-43</li>
                                    <li class="pt-2">
                                        <span class="product-color-dot color-dot-red float-left rounded-circle ml-1"></span>
                                        <span class="product-color-dot color-dot-blue float-left rounded-circle ml-1"></span>
                                        <span class="product-color-dot color-dot-black float-left rounded-circle ml-1"></span>
                                        <span class="product-color-dot color-dot-light float-left rounded-circle ml-1"></span>
                                        <span class="product-color-dot color-dot-green float-left rounded-circle ml-1"></span>
                                    </li>
                                </ul>
                                <ul class="list-unstyled d-flex justify-content-center mb-1">
                                    <li>
                                        <c:set var="avgRating" value="${averageRatingMap[o.id]}" />
                                        <c:set var="feedbackCount" value="${feedbackCountMap[o.id]}" />
                                        <c:choose>
                                            <c:when test="${feedbackCount != null && feedbackCount > 0}">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <c:choose>
                                                        <c:when test="${i <= avgRating}">
                                                            <i class="fa fa-star text-warning"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-star text-secondary"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa fa-star text-warning"></i>
                                                <i class="fa fa-star text-warning"></i>
                                                <i class="fa fa-star text-warning"></i>
                                                <i class="fa fa-star text-warning"></i>
                                                <i class="fa fa-star text-warning"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </ul>
                                <p class="text-center mb-0">
                                    <c:choose>
                                        <c:when test="${latestPriceMap[o.id] != null}">
                                            <span class="text-danger fw-bold">đ${String.format("%,.0f", latestPriceMap[o.id] * 1000)}</span>
                                            <span class="text-muted text-decoration-line-through ms-2">đ${String.format("%,.0f", o.price * 1000)}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger fw-bold">đ${String.format("%,.0f", o.price * 1000)}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                
            </div>

        </div>
    </div>
    <!-- End Content -->

    <!-- Start Brands -->
    <section class="bg-light py-5">
        <div class="container my-4">
            <div class="row text-center py-3">
                <div class="col-lg-6 m-auto">
                    <h1 class="h1">Các thương hiệu kinh doanh</h1>
                    <p>
                        Những thương hiệu hot và luôn đón đầu thị trường tiêu dùng trong nước cũng như nước ngoài.
                    </p>
                </div>
                <div class="col-lg-9 m-auto tempaltemo-carousel">
                    <div class="row d-flex flex-row">
                        <div class="col">
                            <div class="carousel slide carousel-multi-item pt-2 pt-md-0" id="templatemo-slide-brand" data-bs-ride="carousel">
                                <div class="carousel-inner product-links-wap" role="listbox">

                                    <div class="carousel-item active">
                                        <div class="row">
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="img/brand_01.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="img/brand_02.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="img/brand_03.png" alt="Brand Logo"></a>
                                            </div>
                                            <div class="col-3 p-md-5">
                                                <a href="#"><img class="img-fluid brand-img" src="img/brand_04.png" alt="Brand Logo"></a>
                                            </div>
                                        </div>
                                    </div>
 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
   <jsp:include page="foot.jsp"></jsp:include>
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/jquery-migrate-1.2.1.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/templatemo.js"></script>
</body>
</html>