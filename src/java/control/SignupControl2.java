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

/**
 *
 * @author Chi Tien
 */
@WebServlet(name = "SignupControl2", urlPatterns = {"/SignupControl2"})
public class SignupControl2 extends HttpServlet {

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
        
        // Check if step 1 was completed
        String signupUsername = (String) session.getAttribute("signup_username");
        String signupPassword = (String) session.getAttribute("signup_password");
        String signupStep = (String) session.getAttribute("signup_step");
        
        if (signupUsername == null || signupPassword == null || !"1".equals(signupStep)) {
            // Step 1 not completed, redirect to signup
            request.setAttribute("error", "Vui lòng hoàn tất bước 1 trước!");
            response.sendRedirect("signup.jsp");
            return;
        }
        
        // Get form data
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
        String address = request.getParameter("address");
        
        // Validate required fields
        if (name == null || age == null || email == null || phonenumber == null || address == null ||
            name.trim().isEmpty() || age.trim().isEmpty() || email.trim().isEmpty() || 
            phonenumber.trim().isEmpty() || address.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("signup2.jsp").forward(request, response);
            return;
        }
        
        DAO dao = new DAO();
        
        try {
            // Create complete user (account + userinfo) in a single transaction
            boolean success = dao.createCompleteUser(signupUsername, signupPassword, name, age, email, phonenumber, address);
            
            if (success) {
                // Get the newly created account
                account newAccount = dao.login(signupUsername, signupPassword);
                
                if (newAccount != null) {
                    // Set session for logged-in user
                    session.setAttribute("accountss", newAccount);
                    
                    // Clear signup session data
                    session.removeAttribute("signup_username");
                    session.removeAttribute("signup_password");
                    session.removeAttribute("signup_step");
                    
                    // Success message and redirect
                    request.setAttribute("message", "Đăng ký thành công!");
                    request.getRequestDispatcher("IndexControl").forward(request, response);
                } else {
                    // This shouldn't happen, but handle it
                    request.setAttribute("error", "Có lỗi xảy ra khi đăng nhập sau khi tạo tài khoản!");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);
                }
            } else {
                // Account creation failed
                request.setAttribute("error", "Có lỗi xảy ra khi tạo tài khoản! Vui lòng thử lại.");
                request.getRequestDispatcher("signup2.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Handle any database errors
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("signup2.jsp").forward(request, response);
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
