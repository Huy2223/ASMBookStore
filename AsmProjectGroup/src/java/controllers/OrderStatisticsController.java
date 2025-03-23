package controllers;

import dao.OrderDAO;
import dto.Order;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;

@WebServlet(name = "OrderStatisticsController", urlPatterns = {"/OrderStatisticsController"})
public class OrderStatisticsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountIdStr = request.getParameter("accountId");
        String filterType = request.getParameter("filterType");
        String filterValue = request.getParameter("filterValue");
        Connection conn = null;

        try {
            conn = DBUtils.makeConnection();
            OrderDAO orderDAO = new OrderDAO(conn);
            List<Order> orderList;
            float totalAmount = 0;

            if (accountIdStr != null && !accountIdStr.isEmpty()) {
                int accountId = Integer.parseInt(accountIdStr);
                orderList = orderDAO.getOrdersByAccountIdForAdmin(accountId);
                request.setAttribute("adminViewForAccount", true);
            } else if (filterType != null && filterValue != null && !filterType.isEmpty() && !filterValue.isEmpty()) {
                orderList = orderDAO.getAllOrders(filterType, filterValue);
            } else if (filterType != null && filterType.equals("") && filterValue != null && !filterValue.isEmpty()) {
                // Nếu filterType là "All" và filterValue có giá trị, lọc theo ngày tháng
                orderList = orderDAO.getAllOrders("day", filterValue); // Lọc theo ngày mặc định
            } else {
                orderList = orderDAO.getAllOrders();
            }

            // Calculate total amount
            if (orderList != null && !orderList.isEmpty()) {
                for (Order order : orderList) {
                    totalAmount += order.getTotal();
                }
            }

            request.setAttribute("orderList", orderList);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("filterType", filterType);
            request.setAttribute("filterValue", filterValue);

            request.getRequestDispatcher("orderStatistics.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle error
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}