/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.cart;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Chi Tien
 */
@WebServlet(name = "AddtocartControl", urlPatterns = {"/AddtocartControl"})
public class AddtocartControl extends HttpServlet {

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
            String productid = request.getParameter("pid");
            String accountid = request.getParameter("uid");
            String amount = request.getParameter("amount");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            
            System.out.println("AddtocartControl - Parameters:");
            System.out.println("pid: " + productid);
            System.out.println("uid: " + accountid);
            System.out.println("amount: " + amount);
            System.out.println("color: " + color);
            System.out.println("size: " + size);
            
            // Validation parameters
            if (productid == null || amount == null || color == null || size == null) {
                System.out.println("Error: Missing required parameters");
                response.sendRedirect("ShopControl");
                return;
            }
            
            int checksize = Integer.parseInt(size);
            HttpSession session = request.getSession();
            entity.account acc = (entity.account) session.getAttribute("accountss");
            
            if (acc == null) {
                // Chưa đăng nhập, lưu vào session
                System.out.println("User not logged in, saving to session");
                List<cart> cartList = (List<cart>) session.getAttribute("cart_guest");
                if (cartList == null) cartList = new ArrayList<>();
                
                // Tạo cart tạm (AccountID = 0)
                cart newCart = new cart(0, 0, Integer.parseInt(productid), Integer.parseInt(amount), color, Integer.parseInt(size));
                cartList.add(newCart);
                session.setAttribute("cart_guest", cartList);
                
                System.out.println("Added to guest cart successfully");
                response.sendRedirect("CartControl");
                return;
            }
            
            // Đã đăng nhập, thao tác với database
            System.out.println("User logged in, processing with database");
            DAO dao = new DAO();
            cart c = dao.checkpCartExist(accountid, productid, size, color);
            
            if (c == null) {
                // Sản phẩm chưa có trong giỏ hàng
                System.out.println("Product not in cart, inserting new");
                dao.insertProductToCart(accountid, productid, amount, color, size);
                response.sendRedirect("CartControl");
            } else {
                // Sản phẩm đã có trong giỏ hàng
                if (c.getSize() != checksize || !c.getColor().equals(color)) {
                    // Khác size hoặc màu, thêm mới
                    System.out.println("Different size/color, inserting new");
                    dao.insertProductToCart(accountid, productid, amount, color, size);
                    response.sendRedirect("CartControl");
                } else {
                    // Cùng size và màu, cập nhật số lượng
                    System.out.println("Same size/color, updating amount");
                    dao.updateAmountProductInCart(accountid, productid, size, color, amount);
                    response.sendRedirect("CartControl");
                }
            }
            
        } catch (Exception e) {
            System.out.println("Error in AddtocartControl: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi thêm vào giỏ hàng: " + e.getMessage());
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
