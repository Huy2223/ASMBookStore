/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author ACER
 */
public class Cart {

    private int cartID;
    private int accountID;
    private boolean status;
    private float total;
    public List<CartDetail> cartDetails = new ArrayList<>();

    public Cart() {
    }

    public Cart(int cartID, int accountID, boolean status, float total) {
        this.cartID = cartID;
        this.accountID = accountID;
        this.status = status;
        this.total = total;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }
    public List<CartDetail> getCarts() {
        return cartDetails;
    }

    // Thêm sản phẩm vào giỏ hàng
    public void addItem(Book book, int quantity) {
        for (CartDetail detail : cartDetails) {
            if (detail.getBook().getBookID() == book.getBookID()) {
                detail.setQuantity(detail.getQuantity() + quantity);
                return;
            }
        }
        cartDetails.add(new CartDetail(book, quantity));
    }

    public void removeItem(int bookID) {
        cartDetails.removeIf(detail -> detail.getBook().getBookID() == bookID);
    }

    public List<CartDetail> getCartDetails() {
        return cartDetails;
    }

    public int getTotalItems() {
        int total = 0;
        for (CartDetail detail : cartDetails) {
            total += detail.getQuantity();
        }
        return total;
    }

    public float getTotalAmount() {
        float total = 0;
        for (CartDetail detail : cartDetails) {
            total += detail.getBook().getPrice() * detail.getQuantity();
        }
        return total;
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    public void updateItem(int bookID, int quantity) {
        for (CartDetail item : cartDetails) {
            if (item.getBook().getBookID() == bookID) {
                item.setQuantity(quantity);
                if (quantity <= 0) {
                    removeItem(bookID);
                }
                break;
            }
        }
    }

    // Xóa một sản phẩm khỏi giỏ hàng
    

    // Xóa tất cả sản phẩm khỏi giỏ hàng
    public void clear() {
        cartDetails.clear();
    }

    // Tính tổng tiền cho tất cả sản phẩm trong giỏ hàng
    

    // Kiểm tra giỏ hàng rỗng
    public boolean isEmpty() {
        return cartDetails.isEmpty();
    }

    // Kiểm tra sản phẩm có tồn tại trong giỏ hàng
    public boolean containsProduct(int bookID) {
        for (CartDetail item : cartDetails) {
            if (item.getBook().getBookID() == bookID) {
                return true;
            }
        }
        return false;
    }

    // Lấy một mục giỏ hàng từ ID sản phẩm
    public CartDetail getItemByProductId(int bookID) {
        for (CartDetail item : cartDetails) {
            if (item.getBook().getBookID() == bookID) {
                return item;
            }
        }
        return null;
    }

 
    
}
