package control;

import dao.DAO;
import entity.account;
import entity.feedback;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "FeedbackControl", urlPatterns = {"/FeedbackControl"})
public class FeedbackControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        account acc = (account) session.getAttribute("accountss");
        
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        DAO dao = new DAO();
        
        if ("submit".equals(action)) {
            // Xử lý submit feedback
            String invoiceIdStr = request.getParameter("invoiceId");
            String content = request.getParameter("content");
            String ratingStr = request.getParameter("rating");
            String isEdit = request.getParameter("isEdit");
            
            System.out.println("=== DEBUG FEEDBACK SUBMIT ===");
            System.out.println("invoiceId: " + invoiceIdStr);
            System.out.println("content: " + content);
            System.out.println("rating: " + ratingStr);
            System.out.println("isEdit: " + isEdit);
            System.out.println("userId: " + acc.getId());
            
            if (invoiceIdStr != null && content != null && ratingStr != null) {
                try {
                    int invoiceId = Integer.parseInt(invoiceIdStr);
                    int rating = Integer.parseInt(ratingStr);
                    
                    System.out.println("Parsed - invoiceId: " + invoiceId + ", rating: " + rating);
                    
                    // Kiểm tra đã feedback chưa
                    feedback existingFeedback = dao.getFeedbackByInvoiceId(invoiceId);
                    System.out.println("Existing feedback: " + (existingFeedback != null ? existingFeedback.toString() : "null"));
                    
                    if ("true".equals(isEdit) && existingFeedback != null) {
                        // Cập nhật feedback
                        System.out.println("Updating feedback...");
                        dao.updateFeedback(existingFeedback.getId(), content, rating);
                        request.setAttribute("message", "Cập nhật đánh giá thành công!");
                        System.out.println("Feedback updated successfully!");
                    } else if (existingFeedback == null) {
                        // Tạo feedback mới
                        System.out.println("Inserting new feedback...");
                        dao.insertFeedback(acc.getId(), invoiceId, content, rating);
                        request.setAttribute("message", "Cảm ơn bạn đã đánh giá sản phẩm!");
                        System.out.println("New feedback inserted successfully!");
                    } else {
                        System.out.println("Feedback already exists!");
                        request.setAttribute("error", "Bạn đã đánh giá đơn hàng này rồi!");
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Number format error: " + e.getMessage());
                    request.setAttribute("error", "Dữ liệu không hợp lệ!");
                } catch (Exception e) {
                    System.out.println("General error: " + e.getMessage());
                    e.printStackTrace();
                    request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                }
            } else {
                System.out.println("Missing parameters!");
                request.setAttribute("error", "Thiếu thông tin cần thiết!");
            }
            request.getRequestDispatcher("PaymentHistoryControl").forward(request, response);
        } else if ("edit".equals(action)) {
            // Hiển thị form sửa đánh giá
            String invoiceIdStr = request.getParameter("invoiceId");
            if (invoiceIdStr != null) {
                try {
                    int invoiceId = Integer.parseInt(invoiceIdStr);
                    feedback existingFeedback = dao.getFeedbackByInvoiceId(invoiceId);
                    if (existingFeedback != null) {
                        request.setAttribute("invoiceId", invoiceId);
                        request.setAttribute("existingFeedback", existingFeedback);
                        request.setAttribute("isEdit", true);
                        request.getRequestDispatcher("feedback.jsp").forward(request, response);
                        return;
                    } else {
                        request.setAttribute("error", "Không tìm thấy đánh giá để sửa!");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID đơn hàng không hợp lệ!");
                }
            }
            request.getRequestDispatcher("PaymentHistoryControl").forward(request, response);
        } else {
            // Hiển thị form feedback
            String invoiceIdStr = request.getParameter("invoiceId");
            if (invoiceIdStr != null) {
                try {
                    int invoiceId = Integer.parseInt(invoiceIdStr);
                    // Kiểm tra đã feedback chưa
                    feedback existingFeedback = dao.getFeedbackByInvoiceId(invoiceId);
                    if (existingFeedback != null) {
                        request.setAttribute("error", "Bạn đã đánh giá đơn hàng này rồi!");
                        request.getRequestDispatcher("PaymentHistoryControl").forward(request, response);
                        return;
                    }
                    request.setAttribute("invoiceId", invoiceId);
                    request.getRequestDispatcher("feedback.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID đơn hàng không hợp lệ!");
                    request.getRequestDispatcher("PaymentHistoryControl").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("PaymentHistoryControl").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Feedback Control Servlet";
    }
} 