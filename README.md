# WEBGIAY - Website Bán Giày Online

Đây là dự án website bán giày online được phát triển bằng Java Servlet và JSP.

## 📹 Video Demo

Xem video demo về trang web tại: [docs/demo-video.mp4](docs/demo-video.mp4)

### Nội dung video demo:
- Giới thiệu tổng quan về trang web
- Hướng dẫn đăng ký và đăng nhập
- Chức năng mua sắm và giỏ hàng
- Quản lý sản phẩm (dành cho admin)
- Quản lý đơn hàng
- Thống kê doanh thu

## 🚀 Tính năng chính

### Cho người dùng:
- Đăng ký và đăng nhập tài khoản
- Xem danh sách sản phẩm
- Tìm kiếm và lọc sản phẩm
- Thêm sản phẩm vào giỏ hàng
- Thanh toán và đặt hàng
- Xem lịch sử đơn hàng
- Cập nhật thông tin cá nhân

### Cho admin:
- Quản lý sản phẩm (thêm, sửa, xóa)
- Quản lý đơn hàng
- Quản lý tài khoản người dùng
- Thống kê doanh thu
- Quản lý kho hàng
- Xem phản hồi từ khách hàng

## 🛠️ Công nghệ sử dụng

- **Backend**: Java Servlet, JSP
- **Database**: MySQL
- **Frontend**: HTML, CSS, JavaScript, Bootstrap
- **Server**: Apache Tomcat

## 📁 Cấu trúc dự án

```
WEBGIAY/
├── src/                    # Source code Java
│   ├── java/
│   │   ├── context/        # Database connection
│   │   ├── control/        # Servlet controllers
│   │   ├── dao/           # Data Access Objects
│   │   └── entity/        # Entity classes
├── web/                    # Web resources
│   ├── css/               # Stylesheets
│   ├── js/                # JavaScript files
│   ├── img/               # Images
│   └── *.jsp              # JSP pages
├── docs/                   # Documentation & demo videos
├── sql/                    # Database scripts
└── README.md              # Project documentation
```

## 🚀 Cách chạy dự án

1. **Cài đặt môi trường:**
   - Java JDK 8+
   - Apache Tomcat 9+
   - MySQL 8.0+

2. **Cấu hình database:**
   ```sql
   -- Chạy file setup_database.sql để tạo database
   source setup_database.sql
   ```

3. **Deploy lên Tomcat:**
   - Import project vào IDE (NetBeans/IntelliJ)
   - Build project
   - Deploy lên Tomcat server

4. **Truy cập website:**
   - URL: `http://localhost:8080/WEBGIAY`

## 📝 Tài khoản mặc định

### Admin:
- Username: `admin`
- Password: `admin123`

### User thường:
- Username: `user`
- Password: `user123`

## 📞 Liên hệ

Nếu có thắc mắc hoặc góp ý, vui lòng liên hệ qua:
- Email: [your-email@example.com]
- GitHub: [your-github-username]

## 📄 License

Dự án này được phát triển cho mục đích học tập và nghiên cứu. 