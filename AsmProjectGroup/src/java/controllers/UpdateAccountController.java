package controllers;

import dao.AccountDAO;
import dao.BookDAO;
import dto.Account;
import dto.Book;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateAccountController", urlPatterns = {"/UpdateAccountController"})
public class UpdateAccountController extends HttpServlet {

    String url;

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
                        url = "MainController?action=accountManagement";
                        break;
                    case "resetPassword":
                        resetPassword(request, response);
                        url = "MainController?action=login";
                        break;
                }
            }
        } catch (Exception e) {
            log("Error in UpdateController: " + e.getMessage());
            request.setAttribute("error", "An error occurred.");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        AccountDAO accountDAO = new AccountDAO();
        Account account = null;
        try {
            // Fetch the account by email
            account = accountDAO.getAccountByEmail(email);
            String errorMessage = "Email is incorrect or does not exist";
            if (account != null) {
                account.setPassword(newPassword);
                accountDAO.updatePassword(account);
            } else {
                request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("auth/forgotPassword.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("errorMessage", "Error during login. Please try again.");
            request.getRequestDispatcher("auth/forgotPassword.jsp").forward(request, response); // Ensure error page is shown
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
