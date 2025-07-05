<%-- 
    Document   : productmanagement
    Created on : Nov 22, 2024, 11:23:11 PM
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
    
    <link rel="stylesheet" href="css/productmanagementCustom.css">
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
    <c:if test="${not empty message}">
        <div class="container alert alert-success alert-dismissible fade show " role="alert">
            <b class="text-success">${message}</b>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <div class="container">
        <div class="table-wrapper">
            <br><br>
            
            
            <div class="row gx-4 align-items-stretch">
           <!-- Card 1 -->
           <div class="col-md-6 d-flex">
             <div class="card mb-4 shadow-sm flex-fill h-100">
               <div class="card-header bg-info text-white">
                 <h5 class="mb-0">Sản phẩm bán được trong 3 tháng gần đây</h5>
               </div>
               <div class="card-body d-flex flex-column">
                 <div class="row gx-2 gy-3 flex-fill">
                   <div class="col-6 fw-bold">Tên sản phẩm</div>
                   <div class="col-6 fw-bold">Số lượng</div>
                   <c:forEach items="${listp3sm}" var="o">
                     <c:forEach items="${lists}" var="s">
                       <c:if test="${o.id == s.productid}">
                         <div class="col-6">${o.name}</div>
                         <div class="col-6">${s.amount}</div>
                       </c:if>
                     </c:forEach>
                   </c:forEach>
                 </div>
                 <!-- nếu muốn footer card hoặc nút gì, thêm vào đây, sẽ dồn xuống đáy -->
               </div>
             </div>
           </div>

           <!-- Card 2 -->
           <div class="col-md-6 d-flex">
             <div class="card mb-4 shadow-sm flex-fill h-100">
               <div class="card-header bg-danger text-white">
                 <h5 class="mb-0">Sản phẩm <span class="text-warning">KHÔNG</span> bán được trong 3 tháng gần đây</h5>
               </div>
               <div class="card-body">
  <div class="table-responsive">
    <table class="table table-sm mb-0">
      <thead class="fw-bold">
        <tr>
          <th>Tên sản phẩm</th>
          <th>Thao tác</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${listp3mUNs}" var="o">
          <tr>
            <td>${o.name}</td>
            <td>
              <form method="post" action="DeleteproductControl"
                    onsubmit="return confirm('Bạn có chắc muốn xóa?');"
                    class="d-inline">
                <button type="submit" class="btn btn-sm btn-outline-danger">
                  <i class="fa fa-trash-alt"></i> Xóa
                </button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
             </div>
           </div>
         </div>


            
            <br>
            <h2><b>Danh sách Sản phẩm</b></h2>
            <div class="col-sm-12 text-end" >
                        <a href="AddnewproductControl"  class="btn btn-success" data-toggle="modal"> <span>Thêm mới sản phẩm</span></a>
                      
            </div>
            <br>
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Giá</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listp}" var="o">
                    <tr>
                        <td>${o.id}</td>
                        <td>${o.name}</td>
                        <td>
                            <img src="${o.image}">
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${latestPriceMap[o.id] != null}">
                                    <span class="text-danger fw-bold">đ${String.format("%,.0f", latestPriceMap[o.id] * 1000)}</span>
                                    <span class="text-muted text-decoration-line-through ms-2">đ${String.format("%,.0f", o.price * 1000)}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger fw-bold">đ${String.format("%,.0f", o.price * 1000)}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="EditproductControl?pid=${o.id}"  class="btn btn-dark" data-toggle="modal">Chỉnh sửa</a>
                        </td>
                    </tr>
                </c:forEach> 
                </tbody>
            </table>
            <br>
            <br>
        </div>
    </div>
      <jsp:include page="foot.jsp"></jsp:include>
    
</body><script src="js/bootstrap.bundle.min.js"></script>
<script src="js/productmanagementCustom.js"></script>
</html>