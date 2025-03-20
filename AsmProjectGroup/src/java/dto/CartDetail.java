/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author ACER
 */
public class CartDetail {
    private Book book;
    private float unitPrice;
    private int quantity;

    public CartDetail() {
    }

    public CartDetail(Book book, float unitPrice, int quantity) {
        this.book = book;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
    }

    public CartDetail(Book book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }
     
    
    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
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

    
    
}
