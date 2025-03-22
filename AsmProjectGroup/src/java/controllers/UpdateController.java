/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controllers;

import dao.BookDAO;
import dto.Book;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name="UpdateController", urlPatterns={"/UpdateController"})
public class UpdateController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     private static final String UPDATE_BOOK_JSP = "updateBook.jsp";
    private static final String BOOK_MANAGEMENT_PAGE = "MainController?action=bookManagement";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = BOOK_MANAGEMENT_PAGE;

         try {
            String action = request.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "showUpdateForm":
                        showUpdateForm(request, response);
                        return; // return so that the request does not forward to bookManagement
                    case "updateBook":
                        updateBook(request, response);
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

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        BookDAO bookDAO = new BookDAO();
        Book book = bookDAO.getBookById(bookId);

        if (book != null) {
            request.setAttribute("bookToUpdate", book);
            request.getRequestDispatcher(UPDATE_BOOK_JSP).forward(request, response);
        } else {
            request.setAttribute("error", "Book not found");
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String title = request.getParameter("title");
            int authorId = Integer.parseInt(request.getParameter("authorId"));
            int publishedYear = Integer.parseInt(request.getParameter("publishedYear"));
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");

            Book book = new Book();
            book.setBookID(bookId);
            book.setTitle(title);
            book.setAuthorID(authorId);
            book.setPublishedYear(publishedYear);
            book.setPrice(price);
            book.setDescription(description);

            BookDAO bookDAO = new BookDAO();
            boolean updated = bookDAO.updateBook(book);

            if (updated) {
                request.setAttribute("message", "Book updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update book.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid data format.");
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
