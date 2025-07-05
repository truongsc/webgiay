<%-- 
    Document   : head
    Created on : Nov 22, 2024, 3:29:19 AM
    Author     : Chi Tien
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
        <div class="container text-light">
            <div class="w-100 d-flex justify-content-between">
                <div>
                    <i class="fa fa-envelope mx-2"></i>
                    <a class="navbar-sm-brand text-light text-decoration-none" href="mailto:nctien.doc@gmail.com">nctien.doc@gmail.com</a>
                    <i class="fa fa-phone mx-2"></i>
                    <a class="navbar-sm-brand text-light text-decoration-none" href="#">0394272146</a>
                </div>
                <div>
                    <a class="text-light" href="https://www.facebook.com/tien.chi.1614" target="_blank" rel="sponsored"><i class="fab fa-facebook-f fa-sm fa-fw me-2"></i></a>
                    <a class="text-light" href="https://www.instagram.com/ursusneit/" target="_blank"><i class="fab fa-instagram fa-sm fa-fw me-2"></i></a>
                </div>
            </div>
        </div>
    </nav>

    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-success logo h1 align-self-center" href="IndexControl">FIN SHOES</a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                        <li class="nav-item"><a class="nav-link" href="IndexControl">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="about.jsp">Thông Tin</a></li>
                        <li class="nav-item"><a class="nav-link" href="ShopControl">Cửa Hàng</a></li>
                        <li class="nav-item"><a class="nav-link" href="contact.jsp">Liên Hệ</a></li>  
                    </ul>
                </div>
                <div class="navbar align-self-center d-flex">
                    <c:if test="${sessionScope.accountss.isSell != 1}">
                        <c:if test="${sessionScope.accountss.isAdmin != 1}">
                        <form action="SearchControl" method="post" class="form-inline my-2 my-lg-0">
                            <div class="input-group input-group-sm">
                                <input value="${txts}" name="txt" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-secondary btn-number"><i class="fa fa-search"></i></button>
                                </div>
                            </div>
                        </form>
                        </c:if>
                    </c:if>
                    <p>&nbsp;&nbsp;&nbsp;</p>  
                    
                    <!-- Hiển thị giỏ hàng cho tất cả người dùng (trừ admin và seller) -->
                    <c:if test="${sessionScope.accountss == null || (sessionScope.accountss.isSell != 1 && sessionScope.accountss.isAdmin != 1)}">
                        <a class="nav-icon position-relative text-decoration-none" href="CartControl">
                            <i class="fa fa-fw fa-cart-arrow-down text-dark mr-1"></i>
                            <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark">+1</span>
                        </a>
                    </c:if>
                    
                    <c:if test="${sessionScope.accountss != null}">
                            <!-- Menu cho người dùng thông thường -->
                            <c:if test="${sessionScope.accountss.isSell != 1 && sessionScope.accountss.isAdmin != 1}">
                                <a class="nav-icon position-relative text-decoration-none me-2" href="PaymentHistoryControl" title="Lịch sử mua hàng">
                                    <i class="fa fa-history text-dark"></i>
                                </a>
                            </c:if>
                            <a class="nav-icon position-relative text-decoration-none" href="UserinforControl?uid=${sessionScope.accountss.id}">Hello ${sessionScope.accountss.user}</a>
                            <a class="nav-icon position-relative text-decoration-none" href="LogoutControl"> Đăng xuất </a>
                    </c:if>
                    <c:if test="${sessionScope.accountss == null}">
                            <a class="nav-icon position-relative text-decoration-none" href="login.jsp">Đăng nhập</a>
                    </c:if>
                    <c:if test="${sessionScope.accountss.isSell == 1}">
                        <div class="">
                            <button class="btn btn-outline-success" type="button">
                             <a class="nav-link" href="DashboardControl">Quản lý</a>
                            </button>
                           
                        </div>
                    </c:if>     
                </div>
            </div>
        </div>
    </nav>
</html>