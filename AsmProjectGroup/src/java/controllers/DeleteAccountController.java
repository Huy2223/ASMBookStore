
package controllers;

import dao.AccountDAO;
import dao.OrderDAO;
import dto.Account;
import dto.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;

@WebServlet(name = "DeleteAccountController", urlPatterns = {"/DeleteAccountController"})
public class DeleteAccountController extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            Connection conn = DBUtils.makeConnection();
            OrderDAO orderDAO = new OrderDAO(conn);            
            int accountId = Integer.parseInt(request.getParameter("accountId"));
            List<Order> orderList = orderDAO.getOrdersByAccountId(accountId);
            if (orderList.size() > 0) {
                request.setAttribute("deleteError", "DENIED. It has associated orders.");
                //re-render the account list.
                
            } else {
            AccountDAO accountDAO = new AccountDAO();
            accountDAO.remove(accountId);
            }
        } catch (Exception e) {
            log("Error in UpdateController: " + e.getMessage());
            request.setAttribute("error", "An error occurred.");
        } finally {
            request.getRequestDispatcher("MainController?action=accountManagement").forward(request, response);
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
        return "Short description";
    }// </editor-fold>

}
