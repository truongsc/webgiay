<%-- 
    Document   : signup
    Created on : Nov 22, 2024, 3:31:11 PM
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
    Signup form
  </title>
      <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/flogin.css">
   <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    
    <style>
        .form-control {
            margin-bottom: 15px;
        }
        .error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: -10px;
            margin-bottom: 10px;
            display: none;
        }
        .form-control.is-invalid {
            border-color: #dc3545;
        }
        .form-control.is-valid {
            border-color: #28a745;
        }
        .password-strength {
            font-size: 12px;
            margin-top: -10px;
            margin-bottom: 10px;
        }
        .strength-weak { color: #dc3545; }
        .strength-medium { color: #ffc107; }
        .strength-strong { color: #28a745; }
    </style>
</head>

<body>

<div class="form" id="signup-form">
   <form action="SignupControl" method="post" class="form-signup" onsubmit="return validateSignupForm()">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center">Đăng ký tài khoản</h1>          
                
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                <% } %>
                
                <input name="user" type="text" id="user-name" class="form-control" placeholder="Tên đăng nhập" required="" autofocus="" minlength="3" maxlength="20">
                <div class="error-message" id="username-error"></div>
                
                <input name="pass" type="password" id="user-pass" class="form-control" placeholder="Mật khẩu" required autofocus="" minlength="6">
                <div class="password-strength" id="password-strength"></div>
                <div class="error-message" id="password-error"></div>
                
                <input name="repass" type="password" id="user-repeatpass" class="form-control" placeholder="Nhắc lại mật khẩu" required autofocus="">
                <div class="error-message" id="repassword-error"></div>
                
                <button class="btn btn-primary btn-block" type="submit" id="signup-btn"><i class="fas fa-user-plus"></i> Đăng ký</button>
                
                <hr>  
                <a href="login.jsp" id="cancel_signup"><i class="fas fa-angle-left"></i>Quay lại</a>
            </form>

</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const usernameInput = document.getElementById('user-name');
    const passwordInput = document.getElementById('user-pass');
    const repasswordInput = document.getElementById('user-repeatpass');
    const signupBtn = document.getElementById('signup-btn');
    
    // Username validation
    usernameInput.addEventListener('input', function() {
        validateUsername();
    });
    
    // Password validation
    passwordInput.addEventListener('input', function() {
        validatePassword();
        validatePasswordMatch();
        checkPasswordStrength();
    });
    
    // Confirm password validation
    repasswordInput.addEventListener('input', function() {
        validatePasswordMatch();
    });
    
    function validateUsername() {
        const username = usernameInput.value.trim();
        const errorElement = document.getElementById('username-error');
        
        if (username.length < 3) {
            showError(usernameInput, errorElement, 'Tên đăng nhập phải có ít nhất 3 ký tự');
            return false;
        } else if (username.length > 20) {
            showError(usernameInput, errorElement, 'Tên đăng nhập không được quá 20 ký tự');
            return false;
        } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
            showError(usernameInput, errorElement, 'Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới');
            return false;
        } else {
            showSuccess(usernameInput, errorElement);
            return true;
        }
    }
    
    function validatePassword() {
        const password = passwordInput.value;
        const errorElement = document.getElementById('password-error');
        
        if (password.length < 6) {
            showError(passwordInput, errorElement, 'Mật khẩu phải có ít nhất 6 ký tự');
            return false;
        } else {
            showSuccess(passwordInput, errorElement);
            return true;
        }
    }
    
    function validatePasswordMatch() {
        const password = passwordInput.value;
        const repassword = repasswordInput.value;
        const errorElement = document.getElementById('repassword-error');
        
        if (repassword && password !== repassword) {
            showError(repasswordInput, errorElement, 'Mật khẩu nhắc lại không khớp');
            return false;
        } else if (repassword) {
            showSuccess(repasswordInput, errorElement);
            return true;
        }
        return true;
    }
    
    function checkPasswordStrength() {
        const password = passwordInput.value;
        const strengthElement = document.getElementById('password-strength');
        
        if (password.length === 0) {
            strengthElement.textContent = '';
            return;
        }
        
        let strength = 0;
        if (password.length >= 6) strength++;
        if (/[a-z]/.test(password)) strength++;
        if (/[A-Z]/.test(password)) strength++;
        if (/[0-9]/.test(password)) strength++;
        if (/[^a-zA-Z0-9]/.test(password)) strength++;
        
        if (strength <= 2) {
            strengthElement.textContent = 'Độ mạnh: Yếu';
            strengthElement.className = 'password-strength strength-weak';
        } else if (strength <= 3) {
            strengthElement.textContent = 'Độ mạnh: Trung bình';
            strengthElement.className = 'password-strength strength-medium';
        } else {
            strengthElement.textContent = 'Độ mạnh: Mạnh';
            strengthElement.className = 'password-strength strength-strong';
        }
    }
    
    function showError(input, errorElement, message) {
        input.classList.remove('is-valid');
        input.classList.add('is-invalid');
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }
    
    function showSuccess(input, errorElement) {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
        errorElement.style.display = 'none';
    }
});

function validateSignupForm() {
    const username = document.getElementById('user-name').value.trim();
    const password = document.getElementById('user-pass').value;
    const repassword = document.getElementById('user-repeatpass').value;
    
    // Validate username
    if (username.length < 3 || username.length > 20) {
        alert('Tên đăng nhập phải từ 3-20 ký tự');
        return false;
    }
    
    if (!/^[a-zA-Z0-9_]+$/.test(username)) {
        alert('Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới');
        return false;
    }
    
    // Validate password
    if (password.length < 6) {
        alert('Mật khẩu phải có ít nhất 6 ký tự');
        return false;
    }
    
    // Validate password match
    if (password !== repassword) {
        alert('Mật khẩu nhắc lại không khớp');
        return false;
    }
    
    return true;
}
</script>
</body>
</html>