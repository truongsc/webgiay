/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.color;
import entity.product;
import entity.size;
import entity.feedback;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Chi Tien
 */
@WebServlet(name = "ShopSingleControl", urlPatterns = {"/ShopSingleControl"})
public class ShopSingleControl extends HttpServlet {

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
        String id = request.getParameter("pid");
        DAO dao = new DAO();
        product p = dao.getProductByid(id);
        List<size> lists = dao.getSizeWithStockByProductId(Integer.parseInt(id));
        List<color> listc = dao.getColorByid(id);
        
        // Lấy feedback và thống kê rating
        int productId = Integer.parseInt(id);
        List<feedback> feedbacks = dao.getFeedbackByProductId(productId);
        double averageRating = dao.getAverageRatingByProductId(productId);
        int feedbackCount = dao.getFeedbackCountByProductId(productId);
        
        // Lấy giá mới nhất từ price_table
        Double latestPrice = dao.getLatestPriceByProductId(Integer.parseInt(id));
        
        request.setAttribute("p", p);
        request.setAttribute("lists", lists);
        request.setAttribute("listc", listc);
        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("averageRating", averageRating);
        request.setAttribute("feedbackCount", feedbackCount);
        request.setAttribute("latestPrice", latestPrice);
        request.getRequestDispatcher("shop-single.jsp").forward(request, response);
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
