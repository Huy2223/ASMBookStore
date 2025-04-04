/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.Book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author ACER
 */
public class BookDAO {

    public List<Book> getAllBooksWithAuthors() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT Books.BookID, Books.Title, Books.AuthorID, Authors.Name AS AuthorName, Books.PublishedYear, Books.Price, Books.Description "
                + "FROM Books "
                + "INNER JOIN Authors ON Books.AuthorID = Authors.AuthorID";

        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Book book = new Book();
                book.setBookID(resultSet.getInt("BookID"));
                book.setTitle(resultSet.getString("Title"));
                book.setAuthorID(resultSet.getInt("AuthorID"));
                book.setAuthorName(resultSet.getString("AuthorName"));
                book.setPublishedYear(resultSet.getInt("PublishedYear"));
                book.setPrice(resultSet.getDouble("Price"));
                book.setDescription(resultSet.getString("Description"));
                books.add(book);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public List<Book> getBooksByCategory(String categoryName) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, a.Name AS AuthorName "
                + "FROM Books b "
                + "INNER JOIN Authors a ON b.AuthorID = a.AuthorID "
                + "INNER JOIN BookCategories bc ON b.BookID = bc.BookID "
                + "INNER JOIN Categories c ON bc.CategoryID = c.CategoryID "
                + "WHERE c.CategoryName = ?";

        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, categoryName);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Book book = new Book();
                book.setBookID(resultSet.getInt("BookID"));
                book.setTitle(resultSet.getString("Title"));
                book.setAuthorName(resultSet.getString("AuthorName"));
                book.setPublishedYear(resultSet.getInt("PublishedYear"));
                book.setPrice(resultSet.getDouble("Price"));
                book.setDescription(resultSet.getString("Description"));
                books.add(book);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public Book getBookById(int bookId) {
        Book book = null;
        String sql = "SELECT b.BookID, b.Title, b.AuthorID, a.Name AS AuthorName, "
                + "b.PublishedYear, b.Price, b.Description, "
                + "STRING_AGG(c.CategoryName, ', ') AS Categories "
                + "FROM Books b "
                + "INNER JOIN Authors a ON b.AuthorID = a.AuthorID "
                + "LEFT JOIN BookCategories bc ON b.BookID = bc.BookID "
                + "LEFT JOIN Categories c ON bc.CategoryID = c.CategoryID "
                + "WHERE b.BookID = ? "
                + "GROUP BY b.BookID, b.Title, b.AuthorID, a.Name, b.PublishedYear, b.Price, b.Description";

        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, bookId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                book = new Book();
                book.setBookID(resultSet.getInt("BookID"));
                book.setTitle(resultSet.getString("Title"));
                book.setAuthorID(resultSet.getInt("AuthorID"));
                book.setAuthorName(resultSet.getString("AuthorName"));
                book.setPublishedYear(resultSet.getInt("PublishedYear")); // Đã sửa tên cột
                book.setPrice(resultSet.getDouble("Price"));
                book.setDescription(resultSet.getString("Description"));
                book.setCategories(resultSet.getString("Categories"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return book;
    }

    public List<Book> getAllBooksWithCategories(String priceSort) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.BookID, b.Title, b.AuthorID, a.Name AS AuthorName, "
                + "b.PublishedYear, b.Price, b.Description, "
                + "STRING_AGG(c.CategoryName, ', ') AS Categories "
                + "FROM Books b "
                + "INNER JOIN Authors a ON b.AuthorID = a.AuthorID "
                + "LEFT JOIN BookCategories bc ON b.BookID = bc.BookID "
                + "LEFT JOIN Categories c ON bc.CategoryID = c.CategoryID "
                + "GROUP BY b.BookID, b.Title, b.AuthorID, a.Name, b.PublishedYear, b.Price, b.Description";

        // Thêm sắp xếp theo giá nếu cần
        if (priceSort != null && !priceSort.equals("none")) {
            sql += " ORDER BY b.Price " + (priceSort.equals("asc") ? "ASC" : "DESC");
        }

        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Book book = new Book();
                book.setBookID(resultSet.getInt("BookID"));
                book.setTitle(resultSet.getString("Title"));
                book.setAuthorID(resultSet.getInt("AuthorID"));
                book.setAuthorName(resultSet.getString("AuthorName"));
                book.setPublishedYear(resultSet.getInt("PublishedYear"));
                book.setPrice(resultSet.getDouble("Price"));
                book.setDescription(resultSet.getString("Description"));
                book.setCategories(resultSet.getString("Categories"));
                books.add(book);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public List<Book> getBooksByCategory(List<String> categories, String priceSort) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT DISTINCT b.*, a.Name AS AuthorName "
                + "FROM Books b "
                + "INNER JOIN Authors a ON b.AuthorID = a.AuthorID "
                + "INNER JOIN BookCategories bc ON b.BookID = bc.BookID "
                + "INNER JOIN Categories c ON bc.CategoryID = c.CategoryID "
                + "WHERE c.CategoryName IN (";

        // Thêm các category vào truy vấn
        for (int i = 0; i < categories.size(); i++) {
            sql += "?";
            if (i < categories.size() - 1) {
                sql += ",";
            }
        }

        sql += ")";

        // Thêm sắp xếp theo giá nếu cần
        if (priceSort != null && !priceSort.equals("none")) {
            sql += " ORDER BY b.Price " + (priceSort.equals("asc") ? "ASC" : "DESC");
        }

        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // Thiết lập tham số cho category
            for (int i = 0; i < categories.size(); i++) {
                preparedStatement.setString(i + 1, categories.get(i));
            }

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Book book = new Book();
                book.setBookID(resultSet.getInt("BookID"));
                book.setTitle(resultSet.getString("Title"));
                book.setAuthorName(resultSet.getString("AuthorName"));
                book.setPublishedYear(resultSet.getInt("PublishedYear"));
                book.setPrice(resultSet.getDouble("Price"));
                book.setDescription(resultSet.getString("Description"));
                books.add(book);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    public List<Book> searchBooksByTitle(String searchTerm) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT BookID, Title FROM Books WHERE Title LIKE ?";
        try (Connection conn = DBUtils.makeConnection();
                PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, "%" + searchTerm + "%");
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setBookID(rs.getInt("BookID"));
                    book.setTitle(rs.getString("Title"));
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public boolean updateBook(Book book) {
        String sql = "UPDATE Books SET Title = ?, AuthorID = ?, PublishedYear = ?, Price = ?, Description = ? WHERE BookID = ?";
        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, book.getTitle());
            preparedStatement.setInt(2, book.getAuthorID());
            preparedStatement.setInt(3, book.getPublishedYear());
            preparedStatement.setDouble(4, book.getPrice());
            preparedStatement.setString(5, book.getDescription());
            preparedStatement.setInt(6, book.getBookID());

            int rowsUpdated = preparedStatement.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Book> searchBooksByName(String searchName) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.BookID, b.Title, b.AuthorID, a.Name AS AuthorName, "
                + "b.PublishedYear, b.Price, b.Description, "
                + "STRING_AGG(c.CategoryName, ', ') AS Categories "
                + "FROM Books b "
                + "INNER JOIN Authors a ON b.AuthorID = a.AuthorID "
                + "LEFT JOIN BookCategories bc ON b.BookID = bc.BookID "
                + "LEFT JOIN Categories c ON bc.CategoryID = c.CategoryID "
                + "WHERE b.Title LIKE ? OR A.Name like ? "
                + "GROUP BY b.BookID, b.Title, b.AuthorID, a.Name, b.PublishedYear, b.Price, b.Description";

        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, "%" + searchName + "%");
            preparedStatement.setString(2, "%" + searchName + "%");
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Book book = new Book();
                book.setBookID(resultSet.getInt("BookID"));
                book.setTitle(resultSet.getString("Title"));
                book.setAuthorID(resultSet.getInt("AuthorID"));
                book.setAuthorName(resultSet.getString("AuthorName"));
                book.setPublishedYear(resultSet.getInt("PublishedYear"));
                book.setPrice(resultSet.getDouble("Price"));
                book.setDescription(resultSet.getString("Description"));
                book.setCategories(resultSet.getString("Categories"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
}
