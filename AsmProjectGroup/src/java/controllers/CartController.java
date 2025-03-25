/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.CartDAO;
import dto.Book;
import dto.Cart;
import dto.CartDetail;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 *
 * @author ACER
 */
@WebServlet(name = "CartController", urlPatterns = {"/CartServlet"})
public class CartController extends HttpServlet {

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

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addToCart(request, response);
        } else if ("update".equals(action)) {
         updateCart(request, response);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response);
        } else {
            Cart cart = CartDAO.getCartFromSession(request);
            if (cart == null) {
                cart = new Cart();
                CartDAO.setCartInSession(request, cart);
            }
            response.sendRedirect("cart.jsp");
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        float price = Float.parseFloat(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String returnUrl = request.getParameter("returnUrl");

        Book book = new Book();
        book.setBookID(bookID);
        book.setTitle(title);
        book.setAuthorName(author);
        book.setPrice(price);

        Cart cart = CartDAO.getCartFromSession(request);
        cart.addItem(book, quantity);
        CartDAO.setCartInSession(request, cart);

        // Lấy filter để redirect giữ nguyên trạng thái
        String[] selectedCategories = request.getParameterValues("selectedCategories");
        String priceSort = request.getParameter("priceSort");

        StringBuilder url = new StringBuilder(returnUrl + "?");

        if (selectedCategories != null) {
            for (String category : selectedCategories) {
                url.append("selectedCategories=").append(URLEncoder.encode(category, "UTF-8")).append("&");
            }
        }

        if (priceSort != null && !priceSort.isEmpty()) {
            url.append("priceSort=").append(URLEncoder.encode(priceSort, "UTF-8"));
        }

        // Xoá dấu & cuối nếu có
        if (url.charAt(url.length() - 1) == '&') {
            url.setLength(url.length() - 1);
        }

        response.sendRedirect(url.toString());
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookID = Integer.parseInt(request.getParameter("bookID"));

        Cart cart = CartDAO.getCartFromSession(request);
        cart.removeItem(bookID);
        CartDAO.setCartInSession(request, cart);

        response.sendRedirect("cart.jsp");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cart cart = CartDAO.getCartFromSession(request);

        for (CartDetail item : cart.getCartDetails()) {
            try {
                // Tạo tên tham số dựa trên bookID
                String quantityParamName = "quantity[" + item.getBook().getBookID() + "]";
                // Lấy giá trị số lượng từ request
                int quantity = Integer.parseInt(request.getParameter(quantityParamName));

                // Cập nhật số lượng trong giỏ hàng
                cart.updateItem(item.getBook().getBookID(), quantity);
            } catch (NumberFormatException e) {
                // Xử lý ngoại lệ nếu quantity không phải là số
                e.printStackTrace(); // In lỗi ra console để debug, bạn có thể xử lý khác
            }
        }

        CartDAO.setCartInSession(request, cart);
        response.sendRedirect("cart.jsp");
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
