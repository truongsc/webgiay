/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "DashboardControl", urlPatterns = {"/DashboardControl"})
public class DashboardControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            DAO dao = new DAO();

            // 1. Đơn hàng hôm nay
            int ordersToday     = dao.getOrdersToday();
            // 2. Doanh thu tháng
            double revenueMonth = dao.getRevenueThisMonth();
            // 3. Doanh thu 7 ngày
            List<Object[]> rev7 = dao.getRevenueLast7Days();
            List<String> revLabels = new ArrayList<>();
            List<String> revData   = new ArrayList<>();
            for (Object[] row : rev7) {
                revLabels.add(row[0].toString());
                revData.  add(row[1].toString());
            }

            // 4. Khách hàng mới hôm nay
            int newUsersToday    = dao.getNewUsersToday();
            // 5. Feedback 7 ngày qua
            int feedback7Days    = dao.getFeedbackLast7Days();
            // 6. Điểm đánh giá trung bình
            double avgRating     = dao.getAvgRating();

            // 7. Top 5 sản phẩm bán chạy
            List<Object[]> top5 = dao.getTopProducts(5);
            List<String> topNames = new ArrayList<>();
            List<Integer> topSold = new ArrayList<>();
            for (Object[] t : top5) {
                topNames.add((String)t[0]);
                topSold.add(((Number)t[1]).intValue());
            }

            // 8. Sản phẩm tồn kho thấp
            List<Object[]> lowStock = dao.getLowStock();
            // Bạn có thể để nguyên List<Object[]> và render trong JSP:
            // r[0]=id, r[1]=name, r[2]=stock

            // Set tất cả lên request
            req.setAttribute("ordersToday",    ordersToday);
            req.setAttribute("revenueMonth",   revenueMonth);
            req.setAttribute("revLabels",      revLabels);
            req.setAttribute("revData",        revData);

            req.setAttribute("newUsersToday",  newUsersToday);
            req.setAttribute("feedback7Days",  feedback7Days);
            req.setAttribute("avgRating",      avgRating);

            req.setAttribute("topNames",       topNames);
            req.setAttribute("topSold",        topSold);

            req.setAttribute("lowStockList",   lowStock);

        } catch (Exception e) {
            throw new ServletException(e);
        }
        // Luôn forward qua dashboard.jsp
        req.getRequestDispatcher("dashboard.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
