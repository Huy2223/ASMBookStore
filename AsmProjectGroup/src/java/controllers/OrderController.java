package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OrderDAO;
import dto.Cart;
import dto.CartDetail;
import dto.Order;
import dto.OrderDetail;
import dto.Book;
import javax.servlet.annotation.WebServlet;
import utils.DBUtils; // Import lớp DBUtils

@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int accountId = (int) session.getAttribute("accountId");
        Cart cart = dao.CartDAO.getCartFromSession(request);

        if (cart == null || cart.getCartDetails() == null || cart.getCartDetails().isEmpty()) {
            response.sendRedirect("cart.jsp?empty=true");
            return;
        }

        Connection conn = null;

        try {
            conn = DBUtils.makeConnection();
            if (conn == null) {
                throw new SQLException("Failed to connect to the database.");
            }
            conn.setAutoCommit(false);

            OrderDAO orderDAO = new OrderDAO(conn);

            Order order = new Order();
            order.setAccountId(accountId);
            order.setCreateDate(new Date());
            order.setStatus(true);
            order.setTotal(cart.getTotalAmount());

            List<OrderDetail> orderDetails = new ArrayList<>();
            for (CartDetail cartDetail : cart.getCartDetails()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setBookId(cartDetail.getBook().getBookID());
                orderDetail.setUnitPrice((float) cartDetail.getBook().getPrice());
                orderDetail.setQuantity(cartDetail.getQuantity());
                orderDetails.add(orderDetail);
            }

            order.setOrderDetails(orderDetails);

            if (orderDAO.createOrder(order)) {
                conn.commit();
                dao.CartDAO.removeCartFromSession(request);

                // Gửi về cart.jsp và truyền cờ success để hiện modal
                request.setAttribute("orderSuccess", true);
                request.getRequestDispatcher("cart.jsp").forward(request, response);

            } else {
                conn.rollback();
                request.setAttribute("errorMessage", "Error placing order");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e2) {
                    e2.printStackTrace();
                }
            }
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
