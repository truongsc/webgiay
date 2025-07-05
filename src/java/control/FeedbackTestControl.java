package control;

import dao.DAO;
import entity.account;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "FeedbackTestControl", urlPatterns = {"/FeedbackTestControl"})
public class FeedbackTestControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h2>Feedback Test Control</h2>");
        
        try {
            HttpSession session = request.getSession();
            account acc = (account) session.getAttribute("accountss");
            
            out.println("<p>Session account: " + (acc != null ? acc.getUser() : "null") + "</p>");
            
            String action = request.getParameter("action");
            String invoiceId = request.getParameter("invoiceId");
            String content = request.getParameter("content");
            String rating = request.getParameter("rating");
            
            out.println("<p>Action: " + action + "</p>");
            out.println("<p>InvoiceId: " + invoiceId + "</p>");
            out.println("<p>Content: " + content + "</p>");
            out.println("<p>Rating: " + rating + "</p>");
            
            if ("submit".equals(action) && acc != null) {
                try {
                    DAO dao = new DAO();
                    
                    out.println("<p>Trying to insert feedback...</p>");
                    dao.insertFeedback(acc.getId(), Integer.parseInt(invoiceId), content, Integer.parseInt(rating));
                    out.println("<p style='color:green'>INSERT SUCCESS!</p>");
                    
                } catch (Exception e) {
                    out.println("<p style='color:red'>INSERT ERROR: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            }
            
            out.println("<hr>");
            out.println("<form method='post'>");
            out.println("<input type='hidden' name='action' value='submit'>");
            out.println("<input type='hidden' name='invoiceId' value='1'>");
            out.println("Content: <input type='text' name='content' value='Test content'><br>");
            out.println("Rating: <input type='number' name='rating' value='5' min='1' max='5'><br>");
            out.println("<button type='submit'>Test Insert</button>");
            out.println("</form>");
            
        } catch (Exception e) {
            out.println("<p style='color:red'>ERROR: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
        
        out.println("</body></html>");
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