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
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
@WebServlet(name = "BookListController", urlPatterns = {"/BookListController"})
public class BookListController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may us+e following sample code. */
            BookDAO bookDAO = new BookDAO();
            List<Book> books = bookDAO.getAllBooksWithAuthors();
            request.setAttribute("bookList", books);
            List<Book> newArrivalBooks = new ArrayList<>();
            List<Book> bestSellerBooks = new ArrayList<>();
            List<Book> topRatedBooks = new ArrayList<>();
            List<Book> featuredAuthorBooks = new ArrayList<>();
            for (Book book : books) {
                if (book.getBookID() == 1 || book.getBookID() == 2 || book.getBookID() == 5) {
                    featuredAuthorBooks.add(book);
                }
                if (book.getBookID() >= 16 && book.getBookID() <= 20) {
                    newArrivalBooks.add(book);
                } else if (book.getBookID() >= 6 && book.getBookID() <= 10) {
                    bestSellerBooks.add(book);
                } else if (book.getBookID() >= 11 && book.getBookID() <= 15) {
                    topRatedBooks.add(book);
                } 
            }
            request.setAttribute("newArrivalBooks", newArrivalBooks);
            request.setAttribute("bestSellerBooks", bestSellerBooks);
            request.setAttribute("topRatedBooks", topRatedBooks);
            request.setAttribute("authorBook", featuredAuthorBooks);
            request.getRequestDispatcher("bookManagement.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
