// Lấy input date
const dateInput = document.getElementById('date');

// Lấy ngày tháng hiện tại theo múi giờ địa phương
const currentDate = new Date();

// Format ngày theo định dạng YYYY-MM-DD
const year = currentDate.getFullYear();
const month = String(currentDate.getMonth() + 1).padStart(2, '0'); // getMonth() trả về 0-11
const day = String(currentDate.getDate()).padStart(2, '0');

const formattedDate = `${year}-${month}-${day}`;

// Gán giá trị ngày hiện tại vào input hidden
dateInput.value = formattedDate;

// Log để debug
console.log('Current date set:', formattedDate);
console.log('Date input value:', dateInput.value);