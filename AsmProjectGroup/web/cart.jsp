<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Shopping Cart</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            /* Đảm bảo body và html chiếm toàn bộ chiều cao */
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            /* Đảm bảo container chính chiếm hết chiều cao còn lại */
            .container {
                flex: 1;
            }

            /* Đặt footer ở dưới cùng */
            .cart-footer {
                background-color: #f4f4f4; /* Màu nền tùy chỉnh */
                text-align: center;
                padding: 10px 0;
                position: relative;
                bottom: 0;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp"%>

        <div class="container mt-5">
            <h2>Your Shopping Cart</h2>
            <c:if test="${not empty sessionScope.shopping_cart.carts}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Book Image</th>
                            <th>Book Title</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.shopping_cart.carts}">
                            <tr>
                                <td>
                                    <c:if test="${not empty item.book}">
                                        <img src="<c:url value='/books/${item.book.bookID}.jpg' />" 
                                             alt="${item.book.title}" width="80" height="100"/>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${not empty item.book}">
                                        ${item.book.title}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${not empty item.book}">
                                        <fmt:formatNumber value="${item.book.price}" type="currency" currencySymbol="$"/>
                                    </c:if>
                                </td>
                                <td>${item.quantity}</td>
                                <td>
                                    <c:if test="${not empty item.book}">
                                        <fmt:formatNumber value="${item.book.price * item.quantity}" type="currency" currencySymbol="$"/>
                                    </c:if>
                                </td>
                                <td>
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="bookID" value="${item.book.bookID}">
                                        <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Grand Total:</strong></td>
                            <td><fmt:formatNumber value="${sessionScope.shopping_cart.totalAmount}" type="currency" currencySymbol="$"/></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
                <form action="<c:url value='/OrderServlet' />" method="post">
                    <button type="submit" class="btn btn-success">Checkout</button>
                </form>
            </c:if>
            <c:if test="${empty sessionScope.shopping_cart.carts}">
                <p>Your cart is empty.</p>
            </c:if>
        </div>
        <%@ include file="/WEB-INF/layout/footer.jsp"%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>