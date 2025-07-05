/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.account;
import entity.cart;
import entity.product;
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
@WebServlet(name = "CartControl", urlPatterns = {"/CartControl"})
public class CartControl extends HttpServlet {

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
        
        try {
            System.out.println("CartControl - Starting process");
            
            HttpSession session = request.getSession();
            account a = (account) session.getAttribute("accountss");
            
            System.out.println("CartControl - Account: " + (a != null ? "Logged in (ID: " + a.getId() + ")" : "Not logged in"));
            
            DAO dao = new DAO();
            List<product> list1 = dao.getAllProduct();
            List<cart> list2;
            
            if (a == null) {
                // Chưa đăng nhập, lấy giỏ hàng từ session
                System.out.println("CartControl - Getting guest cart from session");
                list2 = (List<cart>) session.getAttribute("cart_guest");
                if (list2 == null) {
                    list2 = new ArrayList<>();
                    System.out.println("CartControl - Created new empty guest cart");
                } else {
                    System.out.println("CartControl - Found " + list2.size() + " items in guest cart");
                }
            } else {
                // Đã đăng nhập, lấy giỏ hàng từ database
                System.out.println("CartControl - Getting cart from database for user ID: " + a.getId());
                int id = a.getId();
                list2 = dao.getCartByAccountID(id);
                System.out.println("CartControl - Found " + (list2 != null ? list2.size() : 0) + " items in database cart");
            }
            
            // Lấy giá mới nhất cho từng sản phẩm
            java.util.HashMap<Integer, Double> latestPriceMap = new java.util.HashMap<>();
            for (product p : list1) {
                Double latest = dao.getLatestPriceByProductId(p.getId());
                if (latest != null) latestPriceMap.put(p.getId(), latest);
            }
            request.setAttribute("latestPriceMap", latestPriceMap);
            
            request.setAttribute("list1", list1);
            request.setAttribute("list2", list2);
            
            System.out.println("CartControl - Forwarding to cart.jsp");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in CartControl: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải giỏ hàng: " + e.getMessage());
            response.sendRedirect("ShopControl");
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
