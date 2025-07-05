/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.account;
import entity.cart;
import java.io.IOException;
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
@WebServlet(name = "CheckoutControl", urlPatterns = {"/CheckoutControl"})
public class CheckoutControl extends HttpServlet {

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
        
        try {
            System.out.println("CheckoutControl - Starting process");
            
            HttpSession session = request.getSession();
            entity.account a = (entity.account) session.getAttribute("accountss");
            
            if (a == null) {
                // Chưa đăng nhập, chuyển hướng sang trang đăng nhập
                System.out.println("CheckoutControl - User not logged in, redirecting to login");
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Lấy dữ liệu selectedItems từ request
            String selectedItemsParam = request.getParameter("selectedItems");
            System.out.println("CheckoutControl - Selected items parameter: " + selectedItemsParam);
            
            if (selectedItemsParam == null || selectedItemsParam.trim().isEmpty()) {
                System.out.println("CheckoutControl - No selected items, redirecting to cart");
                request.setAttribute("error", "Không có sản phẩm nào được chọn!");
                response.sendRedirect("CartControl");
                return;
            }
            
            // Lưu selectedItems vào session để sử dụng ở checkout.jsp
            session.setAttribute("selectedItems", selectedItemsParam);
            System.out.println("CheckoutControl - Saved selectedItems to session");
            
            // Lấy thông tin user
            DAO dao = new DAO();
            entity.userinfor userInfo = dao.getUserinforByuid(String.valueOf(a.getId()));
            
            if (userInfo != null) {
                request.setAttribute("userInfo", userInfo);
                System.out.println("CheckoutControl - Found user info for ID: " + a.getId());
            } else {
                System.out.println("CheckoutControl - No user info found for ID: " + a.getId());
            }
            
            // Chuyển đến trang checkout
            System.out.println("CheckoutControl - Forwarding to checkout.jsp");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in CheckoutControl: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("CartControl");
        }
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
        return "Checkout Control";
    }// </editor-fold>

} 