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
    public List<CartDetail> carts = new ArrayList<>();

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
        return carts;
    }

    // Thêm sản phẩm vào giỏ hàng
    public void addItem(Book book, int quantity) {

        // Kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng
        for (CartDetail item : carts) {
            if (item.getBook().getBookID() == book.getBookID()) {
                // Nếu đã tồn tại, tăng số lượng
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }

        // Nếu chưa tồn tại, thêm mục mới vào giỏ hàng
        CartDetail newItem = new CartDetail(book, quantity);
        carts.add(newItem);
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    public void updateItem(int bookID, int quantity) {
        for (CartDetail item : carts) {
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
    public void removeItem(int bookID) {
        Iterator<CartDetail> iterator = carts.iterator();
        while (iterator.hasNext()) {
            CartDetail item = iterator.next();
            if (item.getBook().getBookID() == bookID) {
                iterator.remove();
                break;
            }
        }
    }

    // Xóa tất cả sản phẩm khỏi giỏ hàng
    public void clear() {
        carts.clear();
    }

    // Tính tổng tiền cho tất cả sản phẩm trong giỏ hàng
    public float getTotalAmount() {
        float total = 0;
        for (CartDetail item : carts) {
            total += (item.getBook().getPrice() * item.getQuantity());
        }
        return total;
    }

    // Lấy tổng số lượng sản phẩm trong giỏ hàng
    public int getTotalItems() {
        int count = 0;
        for (CartDetail item : carts) {
            count += item.getQuantity();
        }
        return count;
    }

    // Kiểm tra giỏ hàng rỗng
    public boolean isEmpty() {
        return carts.isEmpty();
    }

    // Kiểm tra sản phẩm có tồn tại trong giỏ hàng
    public boolean containsProduct(int bookID) {
        for (CartDetail item : carts) {
            if (item.getBook().getBookID() == bookID) {
                return true;
            }
        }
        return false;
    }

    // Lấy một mục giỏ hàng từ ID sản phẩm
    public CartDetail getItemByProductId(int bookID) {
        for (CartDetail item : carts) {
            if (item.getBook().getBookID() == bookID) {
                return item;
            }
        }
        return null;
    }
}
