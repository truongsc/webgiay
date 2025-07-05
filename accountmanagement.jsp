<%-- 
    Document   : accountmanagement
    Created on : Nov 26, 2024, 1:32:27 PM
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
    <style>
    /* 1) Nền xanh đậm */
    .navbar-custom {
      background-color: #004080;  /* đậm hơn, xanh dương */
    }
    /* 2) Menu chính giữa, chia đều */
    .menu-nav {
      flex: 1;                              /* chiếm hết khoảng giữa */
      display: flex !important;
      justify-content: space-evenly;        /* chia đều các item */
      list-style: none;
      margin: 0;
      padding: 0;
    }
    /* 3) Chữ trắng, padding cho link */
    .menu-nav .nav-link {
      color: #fff !important;
      padding: 0.5rem 1rem;
      transition: background-color .2s;
      border-radius: .25rem;
    }
    /* 4) Hover & Active */
    .menu-nav .nav-link:hover {
      background-color: rgba(255,255,255,0.2);
    }
    .menu-nav .nav-link.active {
      background-color: rgba(255,255,255,0.3);
    }
    /* 5) Notification & Logout cũng trắng */
    .navbar-custom .nav-link.logout,
    .navbar-custom .nav-link.notif {
      color: #fff !important;
      padding: 0.5rem;
    }
    .navbar-custom .nav-link.logout:hover,
    .navbar-custom .nav-link.notif:hover {
      background-color: rgba(255,255,255,0.2);
      border-radius: .25rem;
    }
  </style>

</head>
<body>
    <jsp:include page="head2.jsp"></jsp:include>
    <div class="container">
        <div class="table-wrapper">
            <br><br>
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
                        <h2>Quản lí <b>Tài khoản</b></h2>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>Tên đăng nhập</th>
                    <th>Vai trò</th>
                    <th>Họ và tên</th>
                    <th>Tuổi</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Địa chỉ</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listu}" var ="o">
                    <tr> 
                        <c:forEach items="${lista}" var = "p">
                            <c:if test="${p.id == o.uid}">
                        <td>${p.user}</td> 
                        <td><c:choose>
                                <c:when test="${p.isAdmin == 1}"><b>Admin</b></c:when>   
                                <c:when test="${p.isSell == 1}"><b>Sell</b></c:when>    
                                <c:otherwise>Khách hàng</c:otherwise></c:choose>
                        </td>
                            </c:if>
                        </c:forEach>
                        <td>${o.name}</td>
                        <td>${o.age}</td>
                        <td>${o.email}</td>
                        <td>${o.phonenumber}</td>
                        <td>${o.address}</td>
                        <td>
                            <a href="UserinforControl?uid=${o.uid}"  class="btn btn-dark" data-toggle="modal">Edit</a>
                        </td>
                    </tr>        
                </c:forEach>
                </tbody>
            </table>
            <br>
        </div>
    </div>
    <jsp:include page="foot.jsp"></jsp:include>
</body>
    <script src="js/bootstrap.bundle.min.js"></script>
</html>