package control;

import dao.DAO;
import entity.product;
import entity.size;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "StockManagementControl", urlPatterns = {"/StockManagementControl"})
public class StockManagementControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // Check admin login - Fixed: Changed from "acc" to "accountss"
        HttpSession session = request.getSession();
        if (session.getAttribute("accountss") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        DAO dao = new DAO();
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                showStockList(request, response, dao);
                break;
            case "detail":
                showProductDetail(request, response, dao);
                break;
            case "update":
                updateStock(request, response, dao);
                break;
            case "lowstock":
                showLowStockAlerts(request, response, dao);
                break;
            default:
                showStockList(request, response, dao);
                break;
        }
    }
    
    private void showStockList(HttpServletRequest request, HttpServletResponse response, DAO dao)
            throws ServletException, IOException {
        List<Object[]> stockSummary = dao.getStockSummary();
        request.setAttribute("stockSummary", stockSummary);
        request.getRequestDispatcher("stock-management.jsp").forward(request, response);
    }
    
    private void showProductDetail(HttpServletRequest request, HttpServletResponse response, DAO dao)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null) {
            int productId = Integer.parseInt(productIdStr);
            product p = dao.getProductByid(String.valueOf(productId));
            List<size> sizes = dao.getSizeWithStockByProductId(productId);
            
            request.setAttribute("product", p);
            request.setAttribute("sizes", sizes);
        }
        request.getRequestDispatcher("stock-detail.jsp").forward(request, response);
    }
    
    private void updateStock(HttpServletRequest request, HttpServletResponse response, DAO dao)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int sizeValue = Integer.parseInt(request.getParameter("sizeValue"));
            String updateType = request.getParameter("updateType");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            boolean success = false;
            String message = "";
            
            if ("add".equals(updateType)) {
                success = dao.increaseStock(productId, sizeValue, quantity);
                message = success ? "Đã thêm " + quantity + " sản phẩm vào kho" 
                                 : "Không thể thêm sản phẩm vào kho";
            } else if ("set".equals(updateType)) {
                success = dao.updateSizeStock(productId, sizeValue, quantity);
                message = success ? "Đã cập nhật stock thành " + quantity 
                                 : "Không thể cập nhật stock";
            }
            
            if (success) {
                dao.updateProductStock(productId);
            }
            
            request.setAttribute("message", message);
            request.setAttribute("messageType", success ? "success" : "error");
            
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Dữ liệu không hợp lệ");
            request.setAttribute("messageType", "error");
        }
        
        showProductDetail(request, response, dao);
    }
    
    private void showLowStockAlerts(HttpServletRequest request, HttpServletResponse response, DAO dao)
            throws ServletException, IOException {
        int threshold = 5; // Default threshold
        String thresholdStr = request.getParameter("threshold");
        if (thresholdStr != null) {
            try {
                threshold = Integer.parseInt(thresholdStr);
            } catch (NumberFormatException e) {
                threshold = 5;
            }
        }
        
        List<size> lowStockItems = dao.getLowStockAlerts(threshold);
        request.setAttribute("lowStockItems", lowStockItems);
        request.setAttribute("threshold", threshold);
        request.setAttribute("showLowStockAlert", true);
        // Fixed: Changed from "low-stock-alerts.jsp" to "stock-management.jsp"
        request.getRequestDispatcher("stock-management.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
} 