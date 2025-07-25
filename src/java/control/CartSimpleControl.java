package control;

import dao.DAO;
import entity.account;
import entity.cart;
import entity.product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@WebServlet(name = "CartSimpleControl", urlPatterns = {"/CartSimpleControl"})
public class CartSimpleControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            System.out.println("CartSimpleControl - Starting process");
            
            HttpSession session = request.getSession();
            account a = (account) session.getAttribute("accountss");
            
            System.out.println("CartSimpleControl - Account: " + (a != null ? "Logged in (ID: " + a.getId() + ")" : "Not logged in"));
            
            DAO dao = new DAO();
            List<product> list1 = dao.getAllProduct();
            List<cart> list2;
            
            if (a == null) {
                // Chưa đăng nhập, lấy giỏ hàng từ session
                System.out.println("CartSimpleControl - Getting guest cart from session");
                list2 = (List<cart>) session.getAttribute("cart_guest");
                if (list2 == null) {
                    list2 = new ArrayList<>();
                    System.out.println("CartSimpleControl - Created new empty guest cart");
                } else {
                    System.out.println("CartSimpleControl - Found " + list2.size() + " items in guest cart");
                }
            } else {
                // Đã đăng nhập, lấy giỏ hàng từ database
                System.out.println("CartSimpleControl - Getting cart from database for user ID: " + a.getId());
                int id = a.getId();
                list2 = dao.getCartByAccountID(id);
                System.out.println("CartSimpleControl - Found " + (list2 != null ? list2.size() : 0) + " items in database cart");
            }
            
            request.setAttribute("list1", list1);
            request.setAttribute("list2", list2);
            
            System.out.println("CartSimpleControl - Forwarding to cart-simple.jsp");
            request.getRequestDispatcher("cart-simple.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in CartSimpleControl: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("ShopControl");
        }
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

    @Override
    public String getServletInfo() {
        return "Cart Simple Control";
    }
} 