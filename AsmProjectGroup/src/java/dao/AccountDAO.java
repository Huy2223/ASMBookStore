/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author ACER
 */
public class AccountDAO {

    public List<Account> select() throws SQLException, ClassNotFoundException {
        List<Account> list = null;
        //tạo kết nối db
        Connection con = DBUtils.makeConnection();
        //tạo đối tượng stm và thực hiện lệnh select
        Statement stm = con.createStatement();

        ResultSet rs = stm.executeQuery("select * from Accounts");
        list = new ArrayList<>();
        while (rs.next()) {
            //đọc dòng hiện hành vào đối tượng toy
            Account account = new Account();
            account.setAccountID(rs.getInt("accountID"));
            account.setUserName(rs.getString("userName"));
            account.setPassword(rs.getString("password"));
            account.setEmail(rs.getString("email"));
            account.setRole(rs.getString("role"));
            //thêm toy vào list
            list.add(account);
        }
        //đóng kết nối db
        con.close();
        return list;
    }

    public boolean createAccount(String username, String password, String email) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO Accounts (Username, Password, Email, Role) VALUES (?, ?, ?, 'CUSTOMER')";

        try (Connection conn = DBUtils.makeConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;
        }
    }

    public Account getAccountByEmail(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM Accounts WHERE Email = ?";
        try (Connection conn = DBUtils.makeConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAccountID(rs.getInt("accountID"));
                account.setUserName(rs.getString("userName"));
                account.setPassword(rs.getString("password"));
                account.setEmail(rs.getString("email"));
                account.setRole(rs.getString("role"));
                return account;
            }
        }
        return null;
    }

    public Account getAccountById(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM Accounts WHERE AccountID = ?";
        try (Connection conn = DBUtils.makeConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAccountID(rs.getInt("accountID"));
                account.setUserName(rs.getString("userName"));
                account.setPassword(rs.getString("password"));
                account.setEmail(rs.getString("email"));
                account.setRole(rs.getString("role"));
                return account;
            }
        }
        return null;
    }

    public void remove(int id) throws SQLException, ClassNotFoundException {
        Connection con = DBUtils.makeConnection();
        PreparedStatement stm = con.prepareStatement("delete from Accounts where AccountID = ?");
        stm.setInt(1, id);
        stm.executeUpdate();
        con.close();
    }

    public boolean update(Account account) throws SQLException {
        String sql = "UPDATE Accounts SET Username = ?,  Role = ? WHERE AccountID = ?";
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.makeConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, account.getUserName());
                ptm.setString(2, account.getRole());
                ptm.setInt(3, account.getAccountID()); 
                check = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {

        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean updatePassword(Account account) throws SQLException {
        String sql = "UPDATE Accounts SET Password = ? WHERE Email = ?";
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.makeConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, account.getPassword());
                ptm.setString(2, account.getEmail());
                check = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {

        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

}
