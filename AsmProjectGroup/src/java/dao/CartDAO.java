/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author ACER
 */
import dto.Book;
import dto.Cart;
import dto.CartDetail;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CartDAO {
    // Key lưu trữ giỏ hàng trong session
    private static final String CART_SESSION_KEY = "shopping_cart";
    
    // Lấy giỏ hàng từ session, nếu chưa có thì tạo mới
    public static Cart getCartFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute(CART_SESSION_KEY);
        
        if (cart == null) {
            cart = new Cart();
            session.setAttribute(CART_SESSION_KEY, cart);
        }
        
        return cart;
    }
    
    // Lưu giỏ hàng vào session
    public static void setCartInSession(HttpServletRequest request, Cart cart) {
        HttpSession session = request.getSession();
        session.setAttribute(CART_SESSION_KEY, cart);
    }
    
    // Xóa giỏ hàng khỏi session
    public static void removeCartFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute(CART_SESSION_KEY);
    }
    
    // Kiểm tra xem giỏ hàng có tồn tại trong session không
    public static boolean isCartInSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(CART_SESSION_KEY) != null;
    }
    
    // Tính toán số lượng sản phẩm trong giỏ hàng (để hiển thị badge)
    public static float getCartTotalMoney(HttpServletRequest request) {
        if (isCartInSession(request)) {
            Cart cart = getCartFromSession(request);
            return cart.getTotal();
        }
        return 0;
    }
       
}