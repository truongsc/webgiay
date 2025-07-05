package control;

import dao.DAO;
import entity.invoice;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminStatisticsControl", urlPatterns = {"/AdminStatisticsControl"})
public class AdminStatisticsControl extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAO dao = new DAO();
        List<invoice> confirmedInvoices = dao.getConfirmedInvoices();
        int totalRevenue = dao.getTotalRevenue();
        request.setAttribute("confirmedInvoices", confirmedInvoices);
        request.setAttribute("totalRevenue", totalRevenue);
        request.getRequestDispatcher("admin-statistics.jsp").forward(request, response);
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
        return "Admin Statistics Control";
    }
} 