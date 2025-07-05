/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.account;
import entity.product;
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
@WebServlet(name = "EditproductControl2", urlPatterns = {"/EditproductControl2"})
public class EditproductControl2 extends HttpServlet {

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
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String price = request.getParameter("price");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String cateID = request.getParameter("category");
      
        DAO dao = new DAO();
        // Lấy thông tin cũ của sản phẩm
        product oldProduct = dao.getProductByid(id);
        if (name == null || name.trim().isEmpty()) name = oldProduct.getName();
        if (image == null || image.trim().isEmpty()) image = oldProduct.getImage();
        if (title == null || title.trim().isEmpty()) title = oldProduct.getTitle();
        if (description == null || description.trim().isEmpty()) description = oldProduct.getDescription();
        if (cateID == null || cateID.trim().isEmpty()) cateID = oldProduct.getCateID();
        // Chỉ update các trường khác, KHÔNG update giá gốc
        dao.updateProductInfoWithoutPrice(name, image, title, description, cateID, id);
        // Nếu có giá mới, chỉ insert vào price_table
        if (price != null && !price.trim().isEmpty()) {
            try {
                double newPrice = Double.parseDouble(price);
                dao.insertPriceTable(Integer.parseInt(id), newPrice);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        request.setAttribute("message", "Đã chỉnh sửa sản phẩm thành công!");
        request.getRequestDispatcher("ProductmanagementControl").forward(request, response);
        
        
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
