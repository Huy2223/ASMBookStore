/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.Order;
import dto.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ACER
 */


public class OrderDAO {

    private Connection conn;

    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean createOrder(Order order) {
        PreparedStatement pstmt = null;

        try {
            // Chuẩn bị truy vấn SQL để tạo order
            String sqlOrder = "INSERT INTO Orders (AccountId, CreateDate, Status, Total) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, order.getAccountId());
            pstmt.setDate(2, new java.sql.Date(order.getCreateDate().getTime()));
            pstmt.setBoolean(3, order.getStatus());
            pstmt.setFloat(4, order.getTotal());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                return false; // Tạo order thất bại
            }

            // Lấy orderId vừa tạo
            java.sql.ResultSet generatedKeys = pstmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                order.setOrderId(generatedKeys.getInt(1));
            } else {
                return false; // Tạo order thất bại, không có orderId được tạo
            }

            // Tạo order details
            if (!createOrderDetails(order.getOrderDetails(), order.getOrderId())) {
                return false; // Tạo order details thất bại
            }

            return true; // Tạo order thành công

        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Tạo order thất bại do lỗi SQL
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException e) { /* Ignored */ }
        }
    }

    public boolean createOrderDetails(List<OrderDetail> orderDetails, int orderId) {
        PreparedStatement pstmt = null;

        try {
            String sqlOrderDetail = "INSERT INTO OrderDetails (OrderId, BookId, UnitPrice, Quantity) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sqlOrderDetail);

            for (OrderDetail orderDetail : orderDetails) {
                pstmt.setInt(1, orderId);
                pstmt.setInt(2, orderDetail.getBookId());
                pstmt.setFloat(3, orderDetail.getUnitPrice());
                pstmt.setInt(4, orderDetail.getQuantity());
                pstmt.addBatch();
            }

            int[] affectedRows = pstmt.executeBatch();
            for (int rows : affectedRows) {
                if (rows == 0) {
                    return false; // Tạo order details thất bại
                }
            }

            return true; // Tạo order details thành công

        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Tạo order details thất bại do lỗi SQL
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException e) { /* Ignored */ }
        }
    }
    
     public List<Order> getOrdersByAccountId(int accountId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE AccountId = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, accountId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderId"));
                order.setAccountId(rs.getInt("AccountId"));
                order.setCreateDate(rs.getDate("CreateDate"));
                order.setStatus(rs.getBoolean("Status"));
                order.setTotal(rs.getFloat("Total"));
                order.setOrderDetails(getOrderDetailsByOrderId(order.getOrderId()));
                orders.add(order);
            }
        }
        return orders;
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws SQLException {
         List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE OrderId = ?";
         try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
             pstmt.setInt(1, orderId);
             ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                 OrderDetail orderDetail = new OrderDetail();
                 orderDetail.setBookId(rs.getInt("BookId"));
                 orderDetail.setUnitPrice(rs.getFloat("UnitPrice"));
                 orderDetail.setQuantity(rs.getInt("Quantity"));
                 orderDetails.add(orderDetail);
            }
        }
        return orderDetails;
    }
    public List<Order> getAllOrders() throws SQLException{
        //admin
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderId"));
                order.setAccountId(rs.getInt("AccountId"));
                order.setCreateDate(rs.getDate("CreateDate"));
                order.setStatus(rs.getBoolean("Status"));
                order.setTotal(rs.getFloat("Total"));
                order.setOrderDetails(getOrderDetailsByOrderId(order.getOrderId()));
                orders.add(order);
            }
        }
        return orders;
    }
    
    
    public List<Order> getAllOrders(String filterType, String filterValue) throws SQLException {
    List<Order> orders = new ArrayList<>();
    String sql = "SELECT * FROM Orders";

    if (filterType != null && filterValue != null && !filterType.isEmpty() && !filterValue.isEmpty()) {
         if (filterType.equals("day")) {
                sql += " WHERE DAY(CreateDate) = ?";
                // Kiểm tra độ dài chuỗi, lấy toàn bộ giá trị nếu nhập theo "dd"
                if (filterValue.length() >= 2) {
                    filterValue = filterValue.substring(0, 2);
                }
            } else if (filterType.equals("month")) {
                sql += " WHERE MONTH(CreateDate) = ?";
                // Kiểm tra độ dài chuỗi, lấy toàn bộ giá trị nếu nhập theo "mm"
                if (filterValue.length() >= 2) {
                    filterValue = filterValue.substring(0, 2);
                }
            } else if (filterType.equals("year")) {
                sql += " WHERE YEAR(CreateDate) = ?";
                // Không cần substring nếu filterValue chỉ chứa năm
            }
    }

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        if (filterType != null && filterValue != null && !filterType.isEmpty() && !filterValue.isEmpty()) {
              pstmt.setInt(1, Integer.parseInt(filterValue)); // Chuyển đổi sang số nguyên
        }

        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Order order = new Order();
            order.setOrderId(rs.getInt("OrderId"));
            order.setAccountId(rs.getInt("AccountId"));
            order.setCreateDate(rs.getDate("CreateDate"));
            order.setStatus(rs.getBoolean("Status"));
            order.setTotal(rs.getFloat("Total"));
            order.setOrderDetails(getOrderDetailsByOrderId(order.getOrderId()));
            orders.add(order);
        }
    }
    return orders;
}

     public List<Order> getOrdersByAccountIdForAdmin(int accountId) throws SQLException {
        //admin
          List<Order> orders = new ArrayList<>();
          String sql = "SELECT * FROM Orders where accountId = ?";
          try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
              pstmt.setInt(1, accountId);
            ResultSet rs = pstmt.executeQuery();
              while (rs.next()) {
                  Order order = new Order();
                  order.setOrderId(rs.getInt("OrderId"));
                  order.setAccountId(rs.getInt("AccountId"));
                  order.setCreateDate(rs.getDate("CreateDate"));
                  order.setStatus(rs.getBoolean("Status"));
                  order.setTotal(rs.getFloat("Total"));
                  order.setOrderDetails(getOrderDetailsByOrderId(order.getOrderId()));
                  orders.add(order);
              }
          }
          return orders;
    }
}

