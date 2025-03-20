<%-- 
    Document   : cart
    Created on : Mar 19, 2025, 8:51:19 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <%@ include file="/WEB-INF/layout/header.jsp"%>

    <div class="container mt-5">
        <h2>Your Shopping Cart</h2>
        <c:choose>
            <c:when test="${not empty sessionScope.cart}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.cart.items}">
                            <tr>
                                <td>${item.book.title}</td>
                                <td>${item.book.authorName}</td>
                                <td><fmt:formatNumber value="${item.book.price}" type="currency" currencySymbol="$"/></td>
                                <td>
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="bookID" value="${item.book.bookID}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1">
                                        <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                    </form>
                                </td>
                                <td><fmt:formatNumber value="${item.book.price * item.quantity}" type="currency" currencySymbol="$"/></td>
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
                </table>
                <form action="<c:url value='/CartServlet' />" method="post">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn btn-warning">Clear Cart</button>
                </form>
            </c:when>
            <c:otherwise>
                <p>Your cart is empty.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="py-3 mt-4" style="background-color: #D64D17; color: white;">
        <div class="container d-flex justify-content-between">
            <div>LOGO COPYRIGHT</div>
            <div>CONTACT</div>
            <div>ĐĂNG KÍ NHẬN TIN<br>email</div>
        </div>
    </footer>
</body>
</html>

