<%-- 
    Document   : newjsp
    Created on : Nov 21, 2024, 6:39:56 PM
    Author     : Chi Tien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>FIN SHOES - ABOUT</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/templatemo.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
        <link rel="stylesheet" href="css/fontawesome.min.css">
    </head>
<body>
    <jsp:include page="head.jsp"></jsp:include>
    
    <!-- Thong tin cua hang -->
    <section class="bg-success py-5">
        <div class="container">
            <div class="row align-items-center py-5">
                <div class="col-md-8 text-white">
                    <h1>Thông Tin Về Cửa Hàng</h1>
                    <p>
                        Hệ thống bán lẻ giày thể thao số 1 Hà Nội với những mẫu mã đa dạng cùng với phong cách phục vụ tận tình, chu đáo.
                        Đảm bảo sự thoải mái và hài lòng về chất lượng sản phẩm, chất lượng dịch
                        vụ và đặc biệt là giá cả hợp lí tại cửa hàng.
                    </p>
                </div>
                <div class="col-md-4">
                    <img src="img/about-hero.svg" alt="About Hero">
                </div>
            </div>
        </div>
    </section>
    
    <!-- Dich vu cua chung toi -->
    <section class="container py-5">
        <div class="row text-center pt-5 pb-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">Dịch Vụ Của chúng tôi</h1>
                <p>
                    Được thành lập từ năm 2024, FIN SHOES tự hào là đơn vị uy tín chuyên cung cấp các mẫu giày Thể Thao với mẫu mã đa dạng và giá cả hợp lí. 
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-truck fa-lg"></i></div>
                    <h2 class="h5 mt-4 text-center">Giao hàng toàn quốc</h2>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fas fa-exchange-alt"></i></div>
                    <h2 class="h5 mt-4 text-center">Trả và đổi hàng</h2>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-percent"></i></div>
                    <h2 class="h5 mt-4 text-center">Khuyến mãi</h2>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-user"></i></div>
                    <h2 class="h5 mt-4 text-center">Chăm sóc khách hàng 24h</h2>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Cac thuong hieu -->
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
                            <div class="carousel-item active">
                                <div class="row">
                                    <div class="col-3 p-md-5">
                                        <img class="img-fluid brand-img" src="img/brand_01.png" alt="Brand Logo">
                                    </div>
                                    <div class="col-3 p-md-5">
                                        <img class="img-fluid brand-img" src="img/brand_02.png" alt="Brand Logo">
                                    </div>
                                    <div class="col-3 p-md-5">
                                        <img class="img-fluid brand-img" src="img/brand_03.png" alt="Brand Logo">
                                    </div>
                                    <div class="col-3 p-md-5">
                                       <img class="img-fluid brand-img" src="img/brand_04.png" alt="Brand Logo">
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
</body>
    <script src="js/bootstrap.bundle.min.js"></script>
</html>