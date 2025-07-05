<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dashboard</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/templatemo.css">
  <link rel="stylesheet" href="css/fontawesome.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
  <style>
    /* Navbar customization */
    .navbar-custom { background-color: #004080; }
    .menu-nav { flex: 1; display: flex !important; justify-content: space-evenly; list-style: none; margin: 0; padding: 0; }
    .menu-nav .nav-link,
    .navbar-custom .nav-link.logout,
    .navbar-custom .nav-link.notif {
      color: #fff !important; padding: 0.5rem 1rem; border-radius: .25rem; transition: background-color .2s;
    }
    .menu-nav .nav-link:hover,
    .navbar-custom .nav-link.logout:hover,
    .navbar-custom .nav-link.notif:hover { background-color: rgba(255,255,255,0.2); }
    .menu-nav .nav-link.active { background-color: rgba(255,255,255,0.3); }
    /* Set overall page background to white */
    body { background-color: #fff; }
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
<jsp:include page="head2.jsp"></jsp:include>
<body>
  <div class="container py-4">
    <!-- Export buttons -->
    <div class="row mb-4">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title mb-3">Xuất báo cáo</h5>
            <div class="d-flex gap-2">
              <a href="ExportReportControl?format=excel" class="btn btn-success">
                <i class="fas fa-file-excel me-2"></i>Xuất Excel
              </a>
              <a href="ExportReportControl?format=word" class="btn btn-primary">
                <i class="fas fa-file-word me-2"></i>Xuất Word
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Cards -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4 mb-5">
      <div class="col">
        <div class="card bg-white border h-100 text-dark text-center p-3">
          <div class="card-body">
            <h5 class="card-title">Đơn hàng hôm nay</h5>
            <p class="display-5 mb-0">${ordersToday}</p>
          </div>
        </div>
      </div>
      <div class="col">
        <div class="card bg-white border h-100 text-dark text-center p-3">
          <div class="card-body">
            <h5 class="card-title">Doanh thu tháng</h5>
            <p class="display-5 mb-0">${revenueMonth}k₫</p>
          </div>
        </div>
      </div>
      <div class="col">
        <div class="card bg-white border h-100 text-dark text-center p-3">
          <div class="card-body">
            <h5 class="card-title">Feedback 7 ngày</h5>
            <p class="display-5 mb-0">${feedback7Days}</p>
          </div>
        </div>
      </div>
      <div class="col">
        <div class="card bg-white border h-100 text-dark text-center p-3">
          <div class="card-body">
            <h5 class="card-title">Đánh giá trung bình</h5>
            <p class="display-5 mb-0">${avgRating}</p>
          </div>
        </div>
      </div>
    </div>
    <!-- Charts -->
    <div class="row mb-5 g-4">
      <div class="col-md-6">
        <div class="card h-100">
          <div class="card-header bg-white">
            <h5 class="mb-0">Doanh thu 7 ngày gần nhất</h5>
          </div>
          <div class="card-body">
            <canvas id="revenueChart" class="w-100"></canvas>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card h-100">
          <div class="card-header bg-white">
            <h5 class="mb-0">Top 5 sản phẩm bán chạy</h5>
          </div>
          <div class="card-body">
            <canvas id="topChart" class="w-100"></canvas>
          </div>
        </div>
      </div>
    </div>
    <!-- Low stock table -->
    <div class="card mb-5">
      <div class="card-header bg-white">
        <h5 class="mb-0">Sản phẩm có tổng tồn kho thấp (&lt; 10)</h5>
      </div>
      <div class="table-responsive">
        <table class="table table-striped mb-0">
          <thead class="table-light">
            <tr><th>ID</th><th>Tên</th><th>Stock</th></tr>
          </thead>
          <tbody>
            <c:forEach var="r" items="${lowStockList}">
              <tr>
                <td>${r[0]}</td>
                <td>${r[1]}</td>
                <td>${r[2]}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- JS -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
    const revLabels = [
      <c:forEach var="d" items="${revLabels}" varStatus="st">"${d}"<c:if test="${!st.last}">,</c:if></c:forEach>
    ];
    const revData = [
      <c:forEach var="v" items="${revData}" varStatus="st">${v}<c:if test="${!st.last}">,</c:if></c:forEach>
    ];
    new Chart(
      document.getElementById('revenueChart'),
      {
        type: 'line',
        data: {
          labels: revLabels,
          datasets: [{
            label: 'Doanh thu (₫)',
            data: revData,
            fill: false,
            tension: 0.2,
            borderColor: '#28a745',
            pointBackgroundColor: '#28a745'
          }]
        },
        options: { scales: { y: { beginAtZero: true } } }
      }
    );

    const topLabels = [
      <c:forEach var="n" items="${topNames}" varStatus="st">"${n}"<c:if test="${!st.last}">,</c:if></c:forEach>
    ];
    const topData = [
      <c:forEach var="s" items="${topSold}" varStatus="st">${s}<c:if test="${!st.last}">,</c:if></c:forEach>
    ];
    new Chart(
      document.getElementById('topChart'),
      {
        type: 'bar',
        data: {
          labels: topLabels,
          datasets: [{
            label: 'Số lượng bán',
            data: topData,
            backgroundColor: '#dc3545',
            borderColor: '#dc3545',
            borderWidth: 1
          }]
        },
        options: { scales: { y: { beginAtZero: true } } }
      }
    );
  </script>
</body>
<jsp:include page="foot.jsp"></jsp:include>
</html>