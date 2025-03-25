package controllers;

import dao.AccountDAO;
import dao.BookDAO;
import dto.Account;
import dto.Book;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateAccountController", urlPatterns = {"/UpdateAccountController"})
public class UpdateAccountController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String action = request.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "showUpdateFormAccount":
                        showUpdateFormAccount(request, response);
                        return; // return so that the request does not forward to bookManagement
                    case "updateAccount":
                        updateAccount(request, response);
                        break;
                    case "resetPassword":
                        updateAccount(request, response);
                        
                        return;
                }
            }
        } catch (Exception e) {
            log("Error in UpdateController: " + e.getMessage());
            request.setAttribute("error", "An error occurred.");
        } finally {
            request.getRequestDispatcher("MainController?action=accountManagement").forward(request, response);
        }
    }

    private void showUpdateFormAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccountById(accountId);

        if (account != null) {
            request.setAttribute("accountToUpdate", account);
            request.getRequestDispatcher("updateAccount.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Account does not exist!!!");
        }
    }

    private void updateAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        try {
            int accountId = Integer.parseInt(request.getParameter("accountId"));
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String userName = request.getParameter("userName");
            String role = request.getParameter("role");

            Account account = new Account();
            account.setAccountID(accountId);
            account.setEmail(email);
            account.setPassword(password);
            account.setUserName(userName);
            account.setRole(role);

            AccountDAO accountDAO = new AccountDAO();
            boolean updated = accountDAO.update(account);

            if (updated) {
                request.setAttribute("message", "Account updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update account.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid data format.");
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
