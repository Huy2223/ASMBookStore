package dto;

import dto.Book;

public class OrderDetail {
    private int bookId;
    private float unitPrice;
    private int quantity;
    private Book book;

    public OrderDetail() {
    }

    public OrderDetail(int bookId, float unitPrice, int quantity, Book book) {
        this.bookId = bookId;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.book = book;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}