/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Chi Tien
 */
@WebServlet(name = "LoginControl", urlPatterns = {"/LoginControl"})
public class LoginControl extends HttpServlet {

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
        
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        
        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Username: " + user);
        System.out.println("Password: " + pass);
        
        // Validation
        if (user == null || user.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            System.out.println("Login failed: Empty username or password");
            request.setAttribute("mess", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try {
            DAO dao = new DAO();
            account a = dao.login(user.trim(), pass.trim());
            
            if (a == null) {
                System.out.println("Login failed: Invalid credentials");
                request.setAttribute("mess", "Sai tên đăng nhập hoặc mật khẩu");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                System.out.println("Login successful for user: " + user + " (ID: " + a.getId() + ")");
            HttpSession session = request.getSession();
            session.setAttribute("accountss", a);
                
            // Nếu có giỏ hàng tạm thì chuyển vào DB
            List<entity.cart> cartList = (List<entity.cart>) session.getAttribute("cart_guest");
                if (cartList != null && !cartList.isEmpty()) {
                    System.out.println("Transferring " + cartList.size() + " items from guest cart");
                DAO dao2 = new DAO();
                for (entity.cart item : cartList) {
                        dao2.insertProductToCart(String.valueOf(a.getId()), 
                                               String.valueOf(item.getProductID()), 
                                               String.valueOf(item.getAmount()), 
                                               item.getColor(), 
                                               String.valueOf(item.getSize()));
                }
                session.removeAttribute("cart_guest");
            }
                
                // Redirect based on user role
                if (a.getIsAdmin() == 1) {
                    System.out.println("Redirecting admin to admin panel");
                    response.sendRedirect("DashboardControl");
                } else {
                    System.out.println("Redirecting user to shop");
                    response.sendRedirect("ShopControl");
                }
            }
        } catch (Exception e) {
            System.out.println("Login error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("mess", "Lỗi hệ thống, vui lòng thử lại sau");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
        return "Short description";
    }// </editor-fold>

}
