<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Book Details</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/viewDetail.css">
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp" %>

        <section class="container mt-5">
            <table class="book-table">
                <tr>
                    <td class="book-image-cell">
                        <img class="book-image" src="<c:url value='/books/${book.bookID}.jpg' />" alt="${book.title}" />
                    </td>
                    <td class="book-details-cell">
                        <h2 class="book-title">${book.title}</h2>
                        <table class="book-info-table">
                            <tr>
                                <td><strong>Author:</strong></td>
                                <td>${book.authorName}</td>
                            </tr>
                            <tr>
                                <td><strong>Category:</strong></td>
                                <td>${book.categories}</td>
                            </tr>
                            <tr>
                                <td><strong>Published Year:</strong></td>
                                <td>${book.publishedYear}</td>
                            </tr>
                            <tr>
                                <td><strong>Price:</strong></td>
                                <td><fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/></td>
                            </tr>
                            <tr>
                                <td><strong>Description:</strong></td>
                                <td>${book.description}</td>
                            </tr>
                        </table>

                        <c:if test="${not empty sessionScope.userInfo}">
                            <form action="<c:url value='/CartServlet' />" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="bookID" value="${book.bookID}">
                                <input type="hidden" name="title" value="${book.title}">
                                <input type="hidden" name="author" value="${book.authorName}">
                                <input type="hidden" name="price" value="${book.price}">
                                <input type="hidden" name="quantity" value="1">
                                <input type="hidden" name="returnUrl" value="${returnUrl}">
                                <button type="submit" class="btn btn-warning shadow-sm">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>
                        </c:if>

                        <c:if test="${empty sessionScope.userInfo}">
                            <button type="button" class="btn btn-warning shadow-sm" id="addToCartBtn">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                        </c:if>
                    </td>
                </tr>
            </table>
        </section>

        <%@ include file="/WEB-INF/layout/footer.jsp" %>

        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="loginModalLabel">Authentication Required</h5>
                    </div>
                    <div class="modal-body">
                        Please login before adding items to your cart.
                    </div>
                    <div class="modal-footer">
                        <a href="<%= request.getContextPath()%>/auth/login.jsp" class="btn btn-primary">Login</a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#addToCartBtn').click(function () {
                    $('#loginModal').modal('show');
                });
            });
        </script>
    </body>
</html>