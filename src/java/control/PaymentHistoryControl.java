/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.account;
import entity.category;
import entity.invoice;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Chi Tien
 */
@WebServlet(name = "PaymentHistoryControl", urlPatterns = {"/PaymentHistoryControl"})
public class PaymentHistoryControl extends HttpServlet {

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
        HttpSession session = request.getSession();
        account a = (account) session.getAttribute("accountss");
        
        // Kiểm tra đăng nhập
        if (a == null) {
            // Chưa đăng nhập -> redirect đến trang login
            response.sendRedirect("login.jsp");
            return;
        }
        
        DAO dao = new DAO();
        int uid = a.getId();  
        List<invoice> listi = dao.getInvoicebyID(uid);
        
        System.out.println("=== PAYMENT HISTORY CONTROL ===");
        System.out.println("User ID: " + uid);
        System.out.println("Number of invoices: " + listi.size());
        
        // Lấy danh sách feedback của user này
        List<entity.feedback> feedbackList = dao.getFeedbackByUserId(uid);
        System.out.println("Number of feedbacks: " + feedbackList.size());
        
        // Lấy chi tiết đơn hàng cho mỗi invoice
        Map<Integer, List<entity.invoice_detail>> invoiceDetailsMap = new HashMap<>();
        // Map giá mới nhất cho từng productId
        Map<Integer, Double> latestPriceMap = new HashMap<>();
        for (invoice inv : listi) {
            List<entity.invoice_detail> details = dao.getInvoiceDetailsByInvoiceId(inv.getIvid());
            invoiceDetailsMap.put(inv.getIvid(), details);
            // Lấy giá mới nhất cho từng sản phẩm trong đơn hàng
            for (entity.invoice_detail detail : details) {
                int pid = detail.getProductByProductId().getId();
                if (!latestPriceMap.containsKey(pid)) {
                    Double latest = dao.getLatestPriceByProductId(pid);
                    if (latest != null) latestPriceMap.put(pid, latest);
                }
            }
            System.out.println("Invoice " + inv.getIvid() + " has " + details.size() + " details, status: " + inv.getStatus());
        }

        request.setAttribute("listi", listi);
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("invoiceDetailsMap", invoiceDetailsMap);
        request.setAttribute("latestPriceMap", latestPriceMap);
        request.getRequestDispatcher("payment-history.jsp").forward(request, response);
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
