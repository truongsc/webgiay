<%-- head2.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <header class="admin-header">
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container">
      <!-- Logo -->
      <a class="navbar-brand" href="<c:url value='/DashboardControl'/>"><b>DASHBOARD</b></a>
      <!-- Toggle (mobile) -->
      <button class="navbar-toggler" type="button"
              data-bs-toggle="collapse" data-bs-target="#adminNavbar"
              aria-controls="adminNavbar" aria-expanded="false"
              aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="adminNavbar">
        <!-- Menu chính giữa -->
        <ul class="navbar-nav menu-nav">
          <li class="nav-item">
            <a class="nav-link ${pageTitle=='Trang chủ'?'active':''}"
               href="<c:url value='/IndexControl'/>">Trang chủ</a>
          </li>
          <li class="nav-item">
            <a class="nav-link ${pageTitle=='Quản lý tài khoản'?'active':''}"
               href="<c:url value='/AccountmanagementControl'/>">
               Quản lý tài khoản
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link ${pageTitle=='Quản lý sản phẩm'?'active':''}"
               href="<c:url value='/ProductmanagementControl'/>">
               Quản lý sản phẩm
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link ${pageTitle=='Quản lý kho hàng'?'active':''}"
               href="<c:url value='/StockManagementControl'/>">
               Quản lý kho hàng
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link ${pageTitle=='Quản lý đơn hàng'?'active':''}"
               href="<c:url value='/ordermanagement.jsp'/>">
               Quản lý đơn hàng
            </a>
          </li>
        </ul>

        <!-- Notification & Logout (căn phải) -->
        <ul class="navbar-nav ms-auto">
          <c:if test="${sessionScope.accountss != null}">
            <li class="nav-item">
              <a class="nav-link notif" href="#" title="Thông báo">
                <i class="fa fa-bell"></i>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link logout" href="LogoutControl">
                <i class="fa fa-sign-out-alt"></i> Đăng xuất
              </a>
            </li>
          </c:if>
          <c:if test="${sessionScope.accountss == null}">
            <li class="nav-item">
              <a class="nav-link logout" href="login.jsp">
                <i class="fa fa-sign-in-alt"></i> Đăng nhập
              </a>
            </li>
          </c:if>
        </ul>
      </div>
    </div>
  </nav>
  </header>
