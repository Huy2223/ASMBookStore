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
    String sql = "SELECT Books.BookID, Books.Title, Books.AuthorID, Authors.Name AS AuthorName, Books.ISBN, Books.PublishedYear, Books.Price " +
                 "FROM Books " +
                 "INNER JOIN Authors ON Books.AuthorID = Authors.AuthorID";

    try (Connection connection = DBUtils.makeConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(sql);
         ResultSet resultSet = preparedStatement.executeQuery()) {

        while (resultSet.next()) {
            Book book = new Book();
            book.setBookID(resultSet.getInt("BookID"));
            book.setTitle(resultSet.getString("Title"));
            book.setAuthorID(resultSet.getInt("AuthorID")); // Lấy authorID
            book.setAuthorName(resultSet.getString("AuthorName")); // Lấy authorName
            book.setISBN(resultSet.getString("ISBN"));
            book.setPublishedYear(resultSet.getInt("PublishedYear"));
            book.setPrice(resultSet.getDouble("Price"));
            books.add(book);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return books;
}
}
