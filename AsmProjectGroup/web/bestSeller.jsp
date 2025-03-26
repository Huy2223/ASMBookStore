<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Best Seller Books</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/category.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <style>
            .button-margin-4px {
                margin-right: 4px;
            }
            .d-flex.justify-content-center.mt-auto {
                display: flex;
                justify-content: center;
                align-items: center; /* căn giữa theo chiều dọc */
                margin-top: auto;
                gap: 4px; /* khoảng cách giữa các phần tử flex box*/
            }
        </style>
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp"%>

        <div class="container mt-4">
            <div class="row">
                <div class="col-md-12">
                    <div style="text-align: center;"><h2>All Best Seller Books</h2></div>
                    <div class="row">
                        <c:forEach var="book" items="${bestSellerBooks}">
                            <div class="col-md-3 mb-3">
                                <div class="card book-card h-100" style="padding: 6px;">
                                    <img src="<c:url value='/books/${book.bookID}.jpg' />" class="card-img-top" alt="${book.title}" style="height: 400px;">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${book.title}</h5>
                                        <p class="card-text">Author: ${book.authorName}</p>
                                        <p class="card-text">Price: <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/></p>
                                        <div class="d-flex justify-content-center mt-auto">
                                            <a href="<c:url value='/ViewDetailController?id=${book.bookID}' />" class="btn btn-primary button-margin-4px" style="margin-right: 0;">View Details</a>

                                            <c:if test="${not empty sessionScope.userInfo}">
                                                <form action="<c:url value='/CartServlet' />" method="post" style="display: inline-block;">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="bookID" value="${book.bookID}">
                                                    <input type="hidden" name="title" value="${book.title}">
                                                    <input type="hidden" name="author" value="${book.authorName}">
                                                    <input type="hidden" name="price" value="${book.price}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <input type="hidden" name="returnUrl" value="BestSellerController">
                                                    <button type="submit" class="btn btn-success btn-add-custom">
                                                        <i class="fas fa-cart-plus"></i> Add
                                                    </button>
                                                </form>
                                            </c:if>

                                            <c:if test="${empty sessionScope.userInfo}">
                                                <button type="button" class="btn btn-warning btn-add-custom" data-toggle="modal" data-target="#loginModal${book.bookID}">
                                                    <i class="fas fa-cart-plus"></i> Add
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/layout/footer.jsp"%>

        <c:forEach var="book" items="${bestSellerBooks}">
            <div class="modal fade" id="loginModal${book.bookID}" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel${book.bookID}" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-warning text-white">
                            <h5 class="modal-title" id="loginModalLabel${book.bookID}">Login Required</h5>
                            <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Please log in to add items to your cart.
                        </div>
                        <div class="modal-footer">
                            <a href="<c:url value='/auth/login.jsp' />" class="btn btn-primary">Login</a>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>