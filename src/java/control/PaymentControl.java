/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.account;
import entity.cart;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author Chi Tien
 */
@WebServlet(name = "PaymentControl", urlPatterns = {"/PaymentControl"})
public class PaymentControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        DAO dao = new DAO();
        HttpSession session = request.getSession();
        entity.account a = (entity.account) session.getAttribute("accountss");
        if (a == null) {
            // Chưa đăng nhập, chuyển hướng sang trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Nếu có giỏ hàng tạm thì chuyển vào DB
        List<cart> cartList = (List<cart>) session.getAttribute("cart_guest");
        if (cartList != null) {
            for (cart item : cartList) {
                dao.insertProductToCart(String.valueOf(a.getId()), String.valueOf(item.getProductID()), String.valueOf(item.getAmount()), item.getColor(), String.valueOf(item.getSize()));
            }
            session.removeAttribute("cart_guest");
        }
        
        int uid = a.getId();    
        String date = request.getParameter("date");
        String description = request.getParameter("description");
        String totalPrice = request.getParameter("totalPrice");
        
        // LUÔN tạo ngày hiện tại từ server để đảm bảo chính xác
        java.util.Date now = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");

        date = sdf.format(now);
        System.out.println("PaymentControl - Using server date: " + date);
        
        // Log ngày từ form để debug (nếu có)
        String formDate = request.getParameter("date");
        if (formDate != null && !formDate.trim().isEmpty()) {
            System.out.println("PaymentControl - Form date (ignored): " + formDate);
        }
        
        // Lấy selectedItems từ session thay vì request parameter
        String selectedItemsJson = (String) session.getAttribute("selectedItems");
        System.out.println("PaymentControl - Selected items from session: " + selectedItemsJson);
        
        // Thông tin người nhận hàng
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String receiverAddress = request.getParameter("receiverAddress");
        String receiverCity = request.getParameter("receiverCity");
        String receiverDistrict = request.getParameter("receiverDistrict");
        String receiverNote = request.getParameter("receiverNote");
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Kiểm tra dữ liệu đầu vào
        if (totalPrice == null || totalPrice.trim().isEmpty()) {
            request.setAttribute("error", "Dữ liệu đơn hàng không hợp lệ!");
            response.sendRedirect("CartControl");
            return;
        }
        
        // Kiểm tra selectedItems
        if (selectedItemsJson == null || selectedItemsJson.trim().isEmpty()) {
            request.setAttribute("error", "Không có sản phẩm nào được chọn!");
            response.sendRedirect("CartControl");
            return;
        }
        
        // Kiểm tra thông tin người nhận
        if (receiverName == null || receiverName.trim().isEmpty() ||
            receiverPhone == null || receiverPhone.trim().isEmpty() ||
            receiverAddress == null || receiverAddress.trim().isEmpty() ||
            receiverCity == null || receiverCity.trim().isEmpty() ||
            receiverDistrict == null || receiverDistrict.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin người nhận hàng!");
            response.sendRedirect("checkout.jsp");
            return;
        }
        
        try {
            // Parse selected items từ JSON
            List<cart> selectedItems = new ArrayList<>();
            
            if (selectedItemsJson != null && !selectedItemsJson.equals("all")) {
                // Parse selected items từ JSON
                selectedItems = parseSelectedItems(selectedItemsJson);
                System.out.println("PaymentControl - Parsed " + selectedItems.size() + " items from JSON");
            } else {
                // Nếu là "all", lấy tất cả sản phẩm trong giỏ hàng
                selectedItems = dao.getCartByAccountID(uid);
                System.out.println("PaymentControl - Using all cart items: " + selectedItems.size());
            }
            
            if (selectedItems.isEmpty()) {
                request.setAttribute("error", "Không có sản phẩm nào được chọn!");
                response.sendRedirect("CartControl");
                return;
            }
            
            // Tạo mô tả đơn hàng với thông tin người nhận
            String fullDescription = description + "\n\n" +
                                   "Thông tin người nhận:\n" +
                                   "- Họ tên: " + receiverName + "\n" +
                                   "- SĐT: " + receiverPhone + "\n" +
                                   "- Địa chỉ: " + receiverAddress + "\n" +
                                   "- Tỉnh/TP: " + receiverCity + "\n" +
                                   "- Quận/Huyện: " + receiverDistrict + "\n" +
                                   "- Ghi chú: " + (receiverNote != null ? receiverNote : "Không có") + "\n" +
                                   "- Phương thức thanh toán: " + getPaymentMethodName(paymentMethod);
            
            System.out.println("PaymentControl - Creating invoice with description: " + fullDescription);
            
            // Create invoice
            dao.insertInvoice(uid, date, fullDescription, totalPrice);
            int invoiceID = dao.getLatestInvoiceId(uid);
            
            System.out.println("PaymentControl - Created invoice with ID: " + invoiceID);
            
            // Add selected items to invoice_detail and decrease stock
            for (cart item : selectedItems) {
                System.out.println("PaymentControl - Processing item: ProductID=" + item.getProductID() + 
                                 ", Amount=" + item.getAmount() + ", Color=" + item.getColor() + 
                                 ", Size=" + item.getSize());
                
                // Check stock availability before processing
                if (!dao.isStockAvailable(item.getProductID(), item.getSize(), item.getAmount())) {
                    request.setAttribute("error", "Sản phẩm ID " + item.getProductID() + " size " + item.getSize() + " không đủ hàng trong kho!");
                    response.sendRedirect("CartControl");
                    return;
                }
                
                // Decrease stock
                boolean stockUpdated = dao.decreaseStock(item.getProductID(), item.getSize(), item.getAmount());
                if (!stockUpdated) {
                    request.setAttribute("error", "Không thể cập nhật kho cho sản phẩm ID " + item.getProductID());
                    response.sendRedirect("CartControl");
                    return;
                }
                
                // Insert invoice detail
                dao.insertInvoiceDetail(invoiceID, item.getProductID(), item.getAmount());
                
                // Update product overall stock
                dao.updateProductStock(item.getProductID());
            }
            
            // Remove only selected items from cart
            for (cart item : selectedItems) {
                dao.deleteCart(uid, String.valueOf(item.getProductID()), String.valueOf(item.getAmount()), item.getColor(), String.valueOf(item.getSize()));
            }
            
            // Clear selectedItems from session
            session.removeAttribute("selectedItems");
            
            System.out.println("PaymentControl - Order completed successfully. Invoice ID: " + invoiceID);
            
            request.setAttribute("message", "Đặt hàng thành công! " + selectedItems.size() + " sản phẩm đã được đặt hàng.");
            response.sendRedirect("OrderSuccessControl");
            
        } catch (Exception e) {
            System.out.println("PaymentControl - Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage());
            response.sendRedirect("CartControl");
        }
    }
    
    // Helper method to get payment method name
    private String getPaymentMethodName(String method) {
        switch (method) {
            case "cod":
                return "Thanh toán khi nhận hàng (COD)";
            case "bank":
                return "Chuyển khoản ngân hàng";
            case "momo":
                return "Ví MoMo";
            default:
                return "Chưa xác định";
        }
    }

    // Helper method to parse selected items JSON manually
    private List<cart> parseSelectedItems(String jsonString) {
        List<cart> items = new ArrayList<>();
        
        try {
            // Remove outer brackets and split by objects
            jsonString = jsonString.trim();
            if (jsonString.startsWith("[")) {
                jsonString = jsonString.substring(1);
            }
            if (jsonString.endsWith("]")) {
                jsonString = jsonString.substring(0, jsonString.length() - 1);
            }
            
            // Split by },{
            String[] objects = jsonString.split("\\},\\{");
            
            for (String obj : objects) {
                // Clean up object string
                obj = obj.replace("{", "").replace("}", "");
                
                // Parse key-value pairs
                String[] pairs = obj.split(",");
                String productId = "", amount = "", color = "", size = "";
                
                for (String pair : pairs) {
                    String[] keyValue = pair.split(":");
                    if (keyValue.length == 2) {
                        String key = keyValue[0].trim().replace("\"", "");
                        String value = keyValue[1].trim().replace("\"", "");
                        
                        switch (key) {
                            case "productId":
                                productId = value;
                                break;
                            case "amount":
                                amount = value;
                                break;
                            case "color":
                                color = value;
                                break;
                            case "size":
                                size = value;
                                break;
                        }
                    }
                }
                
                // Create cart item if all required fields are present
                if (!productId.isEmpty() && !amount.isEmpty() && !color.isEmpty() && !size.isEmpty()) {
                    cart item = new cart();
                    item.setProductID(Integer.parseInt(productId));
                    item.setAmount(Integer.parseInt(amount));
                    item.setColor(color);
                    item.setSize(Integer.parseInt(size));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            System.err.println("Error parsing selected items: " + e.getMessage());
        }
        
        return items;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
