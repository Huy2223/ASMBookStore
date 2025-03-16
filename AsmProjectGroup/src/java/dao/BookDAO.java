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

    public List<Book> getBooksByCategory(int startId, int endId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT Books.BookID, Books.Title, Books.AuthorID, Authors.Name AS AuthorName, Books.PublishedYear, Books.Price, Books.Description "
                + "FROM Books "
                + "INNER JOIN Authors ON Books.AuthorID = Authors.AuthorID "
                + "WHERE Books.BookID BETWEEN ? AND ?";

        try (Connection connection = DBUtils.makeConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, startId);
            preparedStatement.setInt(2, endId);
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
                + "GROUP BY b.BookID, b.Title, b.AuthorID, a.Name, b.PublishedYear, b.Price, b.Description;";

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
                book.setPublishedYear(resultSet.getInt("PublisherYear"));
                book.setPrice(resultSet.getDouble("Price"));
                book.setDescription(resultSet.getString("Description"));
                book.setCategories(resultSet.getString("Categories"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return book;
    }
}
