package controllers;

import dao.AccountDAO;
import dto.Account;
import dto.Book;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookDAO;
import java.util.ArrayList;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AccountDAO accountDAO = new AccountDAO();
        Account account = null;
        try {
            // Fetch the account by email
            account = accountDAO.getAccountByEmail(email);

            String url = "auth/login.jsp"; // Default to login page
            String errorMessage = "Incorrect Email or Password";

            if (account != null) {
                // Verify the password (replace with proper hashing later)
                if (account.getPassword().equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userInfo", account);
                    session.setAttribute("accountId", account.getAccountID());

                    if ("ADMIN".equals(account.getRole())) {
                        url = "BookListController";
                    } else if ("CUSTOMER".equals(account.getRole())) {
                        BookDAO bookDAO = new BookDAO();
                        List<Book> books = bookDAO.getAllBooksWithAuthors();
                        List<Book> newArrivalBooks = new ArrayList<>();
                        List<Book> bestSellerBooks = new ArrayList<>();
                        List<Book> topRatedBooks = new ArrayList<>();
                        List<Book> featuredAuthorBooks = new ArrayList<>();
                        for (Book book : books) {
                            if (book.getBookID() == 1 || book.getBookID() == 2 || book.getBookID() == 5) {
                                featuredAuthorBooks.add(book);
                            }
                            if (book.getBookID() >= 16 && book.getBookID() <= 25) {
                                newArrivalBooks.add(book);
                            } else if (book.getBookID() >= 6 && book.getBookID() <= 15) {
                                bestSellerBooks.add(book);
                            } else if (book.getBookID() >= 11 && book.getBookID() <= 15) {
                                topRatedBooks.add(book);
                            }
                        }
                        request.setAttribute("authorBook", featuredAuthorBooks);
                        request.setAttribute("newArrivalBooks", newArrivalBooks);
                        request.setAttribute("bestSellerBooks", bestSellerBooks);
                        request.setAttribute("topRatedBooks", topRatedBooks);
                        url = "main.jsp";
                    } else {
                        errorMessage = "Unknown role";
                        request.setAttribute("errorMessage", errorMessage);
                    }
                } else {
                    request.setAttribute("errorMessage", errorMessage);
                }
            } else {
                request.setAttribute("errorMessage", errorMessage);
            }

            request.getRequestDispatcher(url).forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("errorMessage", "Error during login. Please try again.");
            request.getRequestDispatcher("auth/login.jsp").forward(request, response); // Ensure error page is shown
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
    }
}
