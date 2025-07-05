/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.category;
import entity.invoice_detail;
import entity.product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Chi Tien
 */
@WebServlet(name = "ProductmanagementControl", urlPatterns = {"/ProductmanagementControl"})
public class ProductmanagementControl extends HttpServlet {

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
        DAO dao = new DAO();
        List<product> listp = dao.getAllProduct();
        List<product> listp3sm = dao.getProductSold3Month();
        List<product> listp3mUNs = dao.getProductUNSold3Month();
        List<category> listc = dao.getAllCategory();
        List<invoice_detail> lists = dao.getSOLD();
        // Lấy giá mới nhất cho từng sản phẩm
        HashMap<Integer, Double> latestPriceMap = new HashMap<>();
        for (product p : listp) {
            Double latest = dao.getLatestPriceByProductId(p.getId());
            if (latest != null) latestPriceMap.put(p.getId(), latest);
        }
        request.setAttribute("listp", listp);
        request.setAttribute("listc", listc);
        request.setAttribute("listp3sm", listp3sm);
        request.setAttribute("listp3mUNs", listp3mUNs);
        request.setAttribute("lists", lists);
        request.setAttribute("latestPriceMap", latestPriceMap);
        request.getRequestDispatcher("productmanagement.jsp").forward(request, response);
        
        
        
        
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
