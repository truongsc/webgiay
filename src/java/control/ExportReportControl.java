package control;

import dao.DAO;
import java.io.IOException;
import java.io.OutputStream;
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
@WebServlet(name = "ExportReportControl", urlPatterns = {"/ExportReportControl"})
public class ExportReportControl extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String format = req.getParameter("format"); // "excel" hoặc "word"
            DAO dao = new DAO();
            
            // Lấy dữ liệu báo cáo
            int ordersToday = dao.getOrdersToday();
            double revenueMonth = dao.getRevenueThisMonth();
            List<Object[]> rev7 = dao.getRevenueLast7Days();
            int newUsersToday = dao.getNewUsersToday();
            int feedback7Days = dao.getFeedbackLast7Days();
            double avgRating = dao.getAvgRating();
            List<Object[]> top5 = dao.getTopProducts(5);
            List<Object[]> lowStock = dao.getLowStock();
            
            if ("excel".equals(format)) {
                exportToExcel(resp, ordersToday, revenueMonth, rev7, newUsersToday, 
                             feedback7Days, avgRating, top5, lowStock);
            } else if ("word".equals(format)) {
                exportToWord(resp, ordersToday, revenueMonth, rev7, newUsersToday, 
                            feedback7Days, avgRating, top5, lowStock);
            }
            
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void exportToExcel(HttpServletResponse resp, int ordersToday, double revenueMonth,
                              List<Object[]> rev7, int newUsersToday, int feedback7Days,
                              double avgRating, List<Object[]> top5, List<Object[]> lowStock) 
            throws IOException {
        
        resp.setContentType("application/vnd.ms-excel");
        resp.setHeader("Content-Disposition", "attachment; filename=bao_cao_thong_ke.xls");
        
        StringBuilder sb = new StringBuilder();
        sb.append("<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'>");
        sb.append("<head>");
        sb.append("<meta charset='UTF-8'>");
        sb.append("<!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>Báo cáo thống kê</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->");
        sb.append("</head>");
        sb.append("<body>");
        sb.append("<table border='1'>");
        
        // Tiêu đề
        sb.append("<tr><td colspan='4' style='font-size: 18px; font-weight: bold; text-align: center; background-color: #004080; color: white;'>BÁO CÁO THỐNG KÊ</td></tr>");
        sb.append("<tr><td colspan='4' style='text-align: center;'>Ngày xuất báo cáo: ").append(java.time.LocalDate.now()).append("</td></tr>");
        sb.append("<tr><td colspan='4'></td></tr>");
        
        // Thống kê tổng quan
        sb.append("<tr><td colspan='4' style='font-weight: bold; background-color: #f0f0f0;'>THỐNG KÊ TỔNG QUAN</td></tr>");
        sb.append("<tr><td><strong>Chỉ số</strong></td><td><strong>Giá trị</strong></td><td><strong>Chỉ số</strong></td><td><strong>Giá trị</strong></td></tr>");
        sb.append("<tr><td>Đơn hàng hôm nay</td><td>").append(ordersToday).append("</td><td>Khách hàng mới hôm nay</td><td>").append(newUsersToday).append("</td></tr>");
        sb.append("<tr><td>Doanh thu tháng</td><td>").append(String.format("%.0f", revenueMonth)).append("k₫</td><td>Feedback 7 ngày</td><td>").append(feedback7Days).append("</td></tr>");
        sb.append("<tr><td>Đánh giá trung bình</td><td>").append(String.format("%.1f", avgRating)).append("/5</td><td></td><td></td></tr>");
        sb.append("<tr><td colspan='4'></td></tr>");
        
        // Doanh thu 7 ngày
        sb.append("<tr><td colspan='4' style='font-weight: bold; background-color: #f0f0f0;'>DOANH THU 7 NGÀY GẦN NHẤT</td></tr>");
        sb.append("<tr><td><strong>Ngày</strong></td><td><strong>Doanh thu (₫)</strong></td><td></td><td></td></tr>");
        for (Object[] row : rev7) {
            sb.append("<tr><td>").append(row[0]).append("</td><td>").append(row[1]).append("</td><td></td><td></td></tr>");
        }
        sb.append("<tr><td colspan='4'></td></tr>");
        
        // Top 5 sản phẩm bán chạy
        sb.append("<tr><td colspan='4' style='font-weight: bold; background-color: #f0f0f0;'>TOP 5 SẢN PHẨM BÁN CHẠY</td></tr>");
        sb.append("<tr><td><strong>STT</strong></td><td><strong>Tên sản phẩm</strong></td><td><strong>Số lượng bán</strong></td><td></td></tr>");
        int stt = 1;
        for (Object[] row : top5) {
            sb.append("<tr><td>").append(stt++).append("</td><td>").append(row[0]).append("</td><td>").append(row[1]).append("</td><td></td></tr>");
        }
        sb.append("<tr><td colspan='4'></td></tr>");
        
        // Sản phẩm tồn kho thấp
        sb.append("<tr><td colspan='4' style='font-weight: bold; background-color: #f0f0f0;'>SẢN PHẨM TỒN KHO THẤP (&lt; 10)</td></tr>");
        sb.append("<tr><td><strong>ID</strong></td><td><strong>Tên sản phẩm</strong></td><td><strong>Tồn kho</strong></td><td></td></tr>");
        for (Object[] row : lowStock) {
            sb.append("<tr><td>").append(row[0]).append("</td><td>").append(row[1]).append("</td><td>").append(row[2]).append("</td><td></td></tr>");
        }
        
        sb.append("</table>");
        sb.append("</body>");
        sb.append("</html>");
        
        try (OutputStream out = resp.getOutputStream()) {
            out.write(sb.toString().getBytes("UTF-8"));
        }
    }
    
    private void exportToWord(HttpServletResponse resp, int ordersToday, double revenueMonth,
                             List<Object[]> rev7, int newUsersToday, int feedback7Days,
                             double avgRating, List<Object[]> top5, List<Object[]> lowStock) 
            throws IOException {
        
        resp.setContentType("application/msword");
        resp.setHeader("Content-Disposition", "attachment; filename=bao_cao_thong_ke.doc");
        
        StringBuilder sb = new StringBuilder();
        sb.append("<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>");
        sb.append("<head>");
        sb.append("<meta charset='UTF-8'>");
        sb.append("<!--[if gte mso 9]><xml><w:WordDocument><w:View>Print</w:View><w:Zoom>100</w:Zoom></w:WordDocument></xml><![endif]-->");
        sb.append("<style>");
        sb.append("table { border-collapse: collapse; width: 100%; }");
        sb.append("td, th { border: 1px solid black; padding: 8px; text-align: left; }");
        sb.append("th { background-color: #f2f2f2; }");
        sb.append(".title { font-size: 18px; font-weight: bold; text-align: center; background-color: #004080; color: white; }");
        sb.append(".section { font-weight: bold; background-color: #f0f0f0; }");
        sb.append("</style>");
        sb.append("</head>");
        sb.append("<body>");
        
        // Tiêu đề
        sb.append("<table>");
        sb.append("<tr><td colspan='4' class='title'>BÁO CÁO THỐNG KÊ</td></tr>");
        sb.append("<tr><td colspan='4' style='text-align: center;'>Ngày xuất báo cáo: ").append(java.time.LocalDate.now()).append("</td></tr>");
        sb.append("<tr><td colspan='4' style='height: 20px;'></td></tr>");
        
        // Thống kê tổng quan
        sb.append("<tr><td colspan='4' class='section'>THỐNG KÊ TỔNG QUAN</td></tr>");
        sb.append("<tr><td><strong>Chỉ số</strong></td><td><strong>Giá trị</strong></td><td><strong>Chỉ số</strong></td><td><strong>Giá trị</strong></td></tr>");
        sb.append("<tr><td>Đơn hàng hôm nay</td><td>").append(ordersToday).append("</td><td>Khách hàng mới hôm nay</td><td>").append(newUsersToday).append("</td></tr>");
        sb.append("<tr><td>Doanh thu tháng</td><td>").append(String.format("%.0f", revenueMonth)).append("k₫</td><td>Feedback 7 ngày</td><td>").append(feedback7Days).append("</td></tr>");
        sb.append("<tr><td>Đánh giá trung bình</td><td>").append(String.format("%.1f", avgRating)).append("/5</td><td></td><td></td></tr>");
        sb.append("<tr><td colspan='4' style='height: 20px;'></td></tr>");
        
        // Doanh thu 7 ngày
        sb.append("<tr><td colspan='4' class='section'>DOANH THU 7 NGÀY GẦN NHẤT</td></tr>");
        sb.append("<tr><td><strong>Ngày</strong></td><td><strong>Doanh thu (₫)</strong></td><td></td><td></td></tr>");
        for (Object[] row : rev7) {
            sb.append("<tr><td>").append(row[0]).append("</td><td>").append(row[1]).append("</td><td></td><td></td></tr>");
        }
        sb.append("<tr><td colspan='4' style='height: 20px;'></td></tr>");
        
        // Top 5 sản phẩm bán chạy
        sb.append("<tr><td colspan='4' class='section'>TOP 5 SẢN PHẨM BÁN CHẠY</td></tr>");
        sb.append("<tr><td><strong>STT</strong></td><td><strong>Tên sản phẩm</strong></td><td><strong>Số lượng bán</strong></td><td></td></tr>");
        int stt = 1;
        for (Object[] row : top5) {
            sb.append("<tr><td>").append(stt++).append("</td><td>").append(row[0]).append("</td><td>").append(row[1]).append("</td><td></td></tr>");
        }
        sb.append("<tr><td colspan='4' style='height: 20px;'></td></tr>");
        
        // Sản phẩm tồn kho thấp
        sb.append("<tr><td colspan='4' class='section'>SẢN PHẨM TỒN KHO THẤP (&lt; 10)</td></tr>");
        sb.append("<tr><td><strong>ID</strong></td><td><strong>Tên sản phẩm</strong></td><td><strong>Tồn kho</strong></td><td></td></tr>");
        for (Object[] row : lowStock) {
            sb.append("<tr><td>").append(row[0]).append("</td><td>").append(row[1]).append("</td><td>").append(row[2]).append("</td><td></td></tr>");
        }
        
        sb.append("</table>");
        sb.append("</body>");
        sb.append("</html>");
        
        try (OutputStream out = resp.getOutputStream()) {
            out.write(sb.toString().getBytes("UTF-8"));
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
} 