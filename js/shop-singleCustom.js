/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

        $('#carousel-related-product').slick({
            infinite: true,
            arrows: false,
            slidesToShow: 4,
            slidesToScroll: 3,
            dots: true,
            responsive: [{
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 3
                    }
                }
            ]
        });

    function selectSize(size) {
        document.getElementById("size").value = size;
    }
    function selectColor(color) {
        document.getElementById("color").value = color;
    }
    
    document.addEventListener("DOMContentLoaded", function () {
    const varValue = document.getElementById("var-value");
    const amountInput = document.getElementById("amount");

    // Hàm cập nhật giá trị input ẩn dựa trên giá trị hiển thị
    function updateAmount() {
        amountInput.value = varValue.textContent; // Đồng bộ giá trị
    }

    // Hàm giảm số lượng
    window.decreaseQuantity = function () {
        let quantity = parseInt(varValue.textContent, 10);
        if (quantity > 1) { // Đảm bảo không giảm dưới 1
            quantity--;
            varValue.textContent = quantity;
            updateAmount();
        }
    };

    // Hàm tăng số lượng
    window.increaseQuantity = function () {
        let quantity = parseInt(varValue.textContent, 10);
        quantity++;
        varValue.textContent = quantity;
        updateAmount();
    };
    });
 

 
    
