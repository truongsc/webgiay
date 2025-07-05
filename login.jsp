<%-- 
    Document   : login
    Created on : Nov 21, 2024, 6:42:26 PM
    Author     : Chi Tien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        Signin form
    </title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/flogin.css">
   <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">

</head>
<body>
    <div class="form" id="signin-form">
        <form class="form-signin" action="LoginControl" method="post">
            <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Đăng nhập</h1>   
            <p class ="text-warning" role="alert">${mess}</p>
            <input name="user"  type="text" id="inputEmail" class="form-control" placeholder="Tên đăng nhập" required="" autofocus="">
            <br>
            <input name="pass"  type="password" id="inputPassword" class="form-control" placeholder="Mật khẩu" required="">
            <br><br>
            <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i> Đăng nhập</button>
            <hr>  
        </form>
        <span class="form-txt">
            Bạn chưa có tài khoản? 
            <a href="signup.jsp">Đăng ký!</a>
        </span>
    </div>
</body>
</html>