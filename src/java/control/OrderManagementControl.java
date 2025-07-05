/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.account;
import entity.invoice;
import entity.userinfor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "OrderManagementControl", urlPatterns = {"/OrderManagementControl"})
public class OrderManagementControl extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        account acc = (account) session.getAttribute("accountss");
        
        // Kiểm tra quyền admin
        if (acc == null || acc.getIsAdmin() != 1) {
            response.sendRedirect("IndexControl");
            return;
        }
        
        String action = request.getParameter("action");
        DAO dao = new DAO();
        
        if ("confirm".equals(action)) {
            // Xác nhận đơn hàng
            String invoiceIdStr = request.getParameter("invoiceId");
            if (invoiceIdStr != null) {
                try {
                    int invoiceId = Integer.parseInt(invoiceIdStr);
                    dao.updateInvoiceStatus(invoiceId, "đã xác nhận");
                    request.setAttribute("message", "Đã xác nhận đơn hàng #" + invoiceId);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID đơn hàng không hợp lệ!");
                }
            }
        } else if ("cancel".equals(action)) {
            // Hủy đơn hàng
            String invoiceIdStr = request.getParameter("invoiceId");
            if (invoiceIdStr != null) {
                try {
                    int invoiceId = Integer.parseInt(invoiceIdStr);
                    dao.updateInvoiceStatus(invoiceId, "đã hủy");
                    request.setAttribute("message", "Đã hủy đơn hàng #" + invoiceId);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID đơn hàng không hợp lệ!");
                }
            }
        }
        
        // Lấy danh sách đơn hàng
        String statusFilter = request.getParameter("status");
        List<invoice> invoiceList;
        
        if (statusFilter != null && !statusFilter.isEmpty()) {
            invoiceList = dao.getInvoicesByStatus(statusFilter);
        } else {
            invoiceList = dao.getAllInvoiceWithUserInfo();
        }
        
        request.setAttribute("invoiceList", invoiceList);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("dao", dao); // Thêm dao vào request để JSP có thể sử dụng
        request.getRequestDispatcher("order-management.jsp").forward(request, response);
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