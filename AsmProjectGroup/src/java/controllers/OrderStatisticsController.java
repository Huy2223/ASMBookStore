package controllers;

import dao.OrderDAO;
import dto.Order;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;
import com.google.gson.Gson;

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
                if (filterType != null && filterValue != null && !filterType.isEmpty() && !filterValue.isEmpty()) {
                    orderList = orderDAO.getAllOrders(filterType, filterValue);
                    orderList.removeIf(order -> order.getAccountId() != accountId);
                } else if (filterType != null && filterType.equals("") && filterValue != null && !filterValue.isEmpty()) {
                    orderList = orderDAO.getAllOrders("day", filterValue);
                    orderList.removeIf(order -> order.getAccountId() != accountId);
                } else {
                    orderList = orderDAO.getOrdersByAccountIdForAdmin(accountId);
                }
            } else if (filterType != null && filterValue != null && !filterType.isEmpty() && !filterValue.isEmpty()) {
                orderList = orderDAO.getAllOrders(filterType, filterValue);
            } else if (filterType != null && filterType.equals("") && filterValue != null && !filterValue.isEmpty()) {
                orderList = orderDAO.getAllOrders("day", filterValue);
            } else {
                orderList = orderDAO.getAllOrders();
            }

            if (orderList != null && !orderList.isEmpty()) {
                for (Order order : orderList) {
                    totalAmount += order.getTotal();
                }
            }

            request.setAttribute("orderList", orderList);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("filterType", filterType);
            request.setAttribute("filterValue", filterValue);

            // Chuẩn bị dữ liệu cho biểu đồ
            Map<String, Double> chartData = prepareChartData(orderList, filterType);
            String chartDataJson = new Gson().toJson(chartData);
            request.setAttribute("chartData", chartDataJson);

            request.getRequestDispatcher("orderStatistics.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
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

    private Map<String, Double> prepareChartData(List<Order> orderList, String filterType) {
        Map<String, Double> chartData = new LinkedHashMap<>();

        if (orderList == null || orderList.isEmpty()) {
            return chartData;
        }

        for (Order order : orderList) {
            String label;
            if (filterType == null || filterType.isEmpty() || filterType.equals("day")) {
                label = new java.sql.Date(order.getCreateDate().getTime()).toString();
            } else if (filterType.equals("month")) {
                label = new java.sql.Date(order.getCreateDate().getTime()).toString().substring(0, 7);
            } else if (filterType.equals("year")) {
                label = new java.sql.Date(order.getCreateDate().getTime()).toString().substring(0, 4);
            } else {
                label = new java.sql.Date(order.getCreateDate().getTime()).toString();
            }

            if (chartData.containsKey(label)) {
                // Chuyển đổi float sang double và cộng vào giá trị hiện có
                chartData.put(label, chartData.get(label) + (double) order.getTotal());
            } else {
                // Chuyển đổi float sang double và đặt giá trị đầu tiên
                chartData.put(label, (double) order.getTotal());
            }
        }
        return chartData;
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