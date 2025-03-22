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
import java.sql.SQLException;
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
}

