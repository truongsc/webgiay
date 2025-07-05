<%-- 
    Document   : signup2
    Created on : Dec 3, 2024, 9:39:58 PM
    Author     : Chi Tien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Check if step 1 was completed
    String signupUsername = (String) session.getAttribute("signup_username");
    String signupStep = (String) session.getAttribute("signup_step");
    
    if (signupUsername == null || !"1".equals(signupStep)) {
        // Redirect to step 1 if not completed
        response.sendRedirect("signup.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>
    Thông tin cá nhân - Bước 2
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
        .success-message {
            color: #28a745;
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
        .input-group {
            position: relative;
            margin-bottom: 15px;
        }
        .input-group .fa {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 10;
        }
        .fa-check { color: #28a745; }
        .fa-times { color: #dc3545; }
    </style>
</head>

<body style="">

<div class="form" id="signup-form">
   <form action="SignupControl2" method="post" class="form-signup" onsubmit="return validateUserInfoForm()">
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center">Thông tin cá nhân</h1>               
                
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                <% } %>
                
                <p class="text-muted text-center">
                    <small>Bước 2/2 - Tài khoản: <strong><%= session.getAttribute("signup_username") %></strong></small>
                </p>
                
                <div class="input-group">
                    <input name="name" type="text" id="name" class="form-control" placeholder="Họ và tên" required="" autofocus="" maxlength="50">
                    <i class="fa fa-user" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); color: #ccc;"></i>
                </div>
                <div class="error-message" id="name-error"></div>
                
                <div class="input-group">
                    <input name="age" type="number" id="age" class="form-control" placeholder="Tuổi" required autofocus="" min="16" max="100">
                    <i class="fa fa-calendar" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); color: #ccc;"></i>
                </div>
                <div class="error-message" id="age-error"></div>
                
                <div class="input-group">
                    <input name="email" type="email" id="email" class="form-control" placeholder="Email (example@email.com)" required autofocus="" maxlength="100">
                    <i class="fa fa-envelope" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); color: #ccc;"></i>
                </div>
                <div class="error-message" id="email-error"></div>
                <div class="success-message" id="email-success"></div>
                
                <div class="input-group">
                    <input name="phonenumber" type="tel" id="phonenumber" class="form-control" placeholder="Số điện thoại (0xxxxxxxxx)" required autofocus="" maxlength="11">
                    <i class="fa fa-phone" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); color: #ccc;"></i>
                </div>
                <div class="error-message" id="phone-error"></div>
                <div class="success-message" id="phone-success"></div>
                
                <div class="input-group">
                    <input name="address" type="text" id="address" class="form-control" placeholder="Địa chỉ" required autofocus="" maxlength="200">
                    <i class="fa fa-map-marker" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); color: #ccc;"></i>
                </div>
                <div class="error-message" id="address-error"></div>

                <button class="btn btn-primary btn-block" type="submit" id="complete-btn"><i class="fas fa-user-plus"></i>Hoàn tất đăng ký</button>
                
                <hr>
                <a href="login.jsp" id="cancel_signup"><i class="fas fa-angle-left"></i>Quay lại</a>
            </form>

</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const nameInput = document.getElementById('name');
    const ageInput = document.getElementById('age');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phonenumber');
    const addressInput = document.getElementById('address');
    
    // Name validation
    nameInput.addEventListener('input', function() {
        validateName();
    });
    
    // Age validation
    ageInput.addEventListener('input', function() {
        validateAge();
    });
    
    // Email validation
    emailInput.addEventListener('input', function() {
        validateEmail();
    });
    
    // Phone validation
    phoneInput.addEventListener('input', function() {
        validatePhone();
    });
    
    // Address validation
    addressInput.addEventListener('input', function() {
        validateAddress();
    });
    
    function validateName() {
        const name = nameInput.value.trim();
        const errorElement = document.getElementById('name-error');
        
        if (name.length < 2) {
            showError(nameInput, errorElement, 'Họ tên phải có ít nhất 2 ký tự');
            return false;
        } else if (name.length > 50) {
            showError(nameInput, errorElement, 'Họ tên không được quá 50 ký tự');
            return false;
        } else if (!/^[a-zA-ZÀ-ỹ\s]+$/.test(name)) {
            showError(nameInput, errorElement, 'Họ tên chỉ được chứa chữ cái và khoảng trắng');
            return false;
        } else {
            showSuccess(nameInput, errorElement);
            return true;
        }
    }
    
    function validateAge() {
        const age = parseInt(ageInput.value);
        const errorElement = document.getElementById('age-error');
        
        if (isNaN(age) || age < 16) {
            showError(ageInput, errorElement, 'Tuổi phải từ 16 trở lên');
            return false;
        } else if (age > 100) {
            showError(ageInput, errorElement, 'Tuổi không được quá 100');
            return false;
        } else {
            showSuccess(ageInput, errorElement);
            return true;
        }
    }
    
    function validateEmail() {
        const email = emailInput.value.trim();
        const errorElement = document.getElementById('email-error');
        const successElement = document.getElementById('email-success');
        
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        
        if (!email) {
            showError(emailInput, errorElement, 'Email là bắt buộc');
            return false;
        } else if (!emailRegex.test(email)) {
            showError(emailInput, errorElement, 'Email không đúng định dạng (example@email.com)');
            return false;
        } else {
            showSuccess(emailInput, errorElement, successElement, 'Email hợp lệ');
            return true;
        }
    }
    
    function validatePhone() {
        const phone = phoneInput.value.trim();
        const errorElement = document.getElementById('phone-error');
        const successElement = document.getElementById('phone-success');
        
        // Vietnamese phone number regex
        const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
        
        if (!phone) {
            showError(phoneInput, errorElement, 'Số điện thoại là bắt buộc');
            return false;
        } else if (!phoneRegex.test(phone)) {
            showError(phoneInput, errorElement, 'Số điện thoại không đúng định dạng (0xxxxxxxxx - 10 số)');
            return false;
        } else {
            showSuccess(phoneInput, errorElement, successElement, 'Số điện thoại hợp lệ');
            return true;
        }
    }
    
    function validateAddress() {
        const address = addressInput.value.trim();
        const errorElement = document.getElementById('address-error');
        
        if (address.length < 5) {
            showError(addressInput, errorElement, 'Địa chỉ phải có ít nhất 5 ký tự');
            return false;
        } else if (address.length > 200) {
            showError(addressInput, errorElement, 'Địa chỉ không được quá 200 ký tự');
            return false;
        } else {
            showSuccess(addressInput, errorElement);
            return true;
        }
    }
    
    function showError(input, errorElement, message) {
        input.classList.remove('is-valid');
        input.classList.add('is-invalid');
        errorElement.textContent = message;
        errorElement.style.display = 'block';
        
        // Hide success message if exists
        const successElement = input.parentNode.parentNode.querySelector('.success-message');
        if (successElement) {
            successElement.style.display = 'none';
        }
    }
    
    function showSuccess(input, errorElement, successElement = null, message = '') {
        input.classList.remove('is-invalid');
        input.classList.add('is-valid');
        errorElement.style.display = 'none';
        
        if (successElement && message) {
            successElement.textContent = message;
            successElement.style.display = 'block';
        }
    }
});

function validateUserInfoForm() {
    const name = document.getElementById('name').value.trim();
    const age = parseInt(document.getElementById('age').value);
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('phonenumber').value.trim();
    const address = document.getElementById('address').value.trim();
    
    // Validate name
    if (name.length < 2 || name.length > 50) {
        alert('Họ tên phải từ 2-50 ký tự');
        return false;
    }
    
    if (!/^[a-zA-ZÀ-ỹ\s]+$/.test(name)) {
        alert('Họ tên chỉ được chứa chữ cái và khoảng trắng');
        return false;
    }
    
    // Validate age
    if (isNaN(age) || age < 16 || age > 100) {
        alert('Tuổi phải từ 16 đến 100');
        return false;
    }
    
    // Validate email
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(email)) {
        alert('Email không đúng định dạng (example@email.com)');
        return false;
    }
    
    // Validate phone
    const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
    if (!phoneRegex.test(phone)) {
        alert('Số điện thoại không đúng định dạng (0xxxxxxxxx - 10 số)');
        return false;
    }
    
    // Validate address
    if (address.length < 5 || address.length > 200) {
        alert('Địa chỉ phải từ 5-200 ký tự');
        return false;
    }
    
    return true;
}
</script>
</body>
</html>