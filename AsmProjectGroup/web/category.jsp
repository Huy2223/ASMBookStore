<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Categories</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/category.css">
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp" %>

        <div class="container mt-4">
            <div class="row">
                <div class="col-md-2">
                    <h4>Categories</h4>
                    <form id="categoryFilterForm" action="CategoryController" method="get">
                        <c:forEach var="category" items="${['Fiction', 'Coming-of-age', 'Surrealism', 'Sci-fi', 'Historical', 'Dystopian', 'Romance', 'Philosophy', 'Fantasy', 'Children Fiction', 'Non-fiction']}">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="selectedCategories" value="${category}" id="category${category}"
                                       <c:if test="${selectedCategories.contains(category)}">checked</c:if>>
                                <label class="form-check-label" for="category${category}">${category}</label>
                            </div>
                        </c:forEach>

                        <button type="submit" class="btn btn-primary mt-2">Filter</button>

                        <div class="mt-3">
                            <label for="priceSort">Sort by Price:</label>
                            <select name="priceSort" id="priceSort" class="form-control">
                                <option value="none">None</option>
                                <option value="asc" <c:if test="${priceSort == 'asc'}">selected</c:if>>Low to High</option>
                                <option value="desc" <c:if test="${priceSort == 'desc'}">selected</c:if>>High to Low</option>
                                </select>
                            </div>
                        </form>
                    </div>

                    <div class="col-md-10">
                        <h2>All Books</h2>
                        <div class="row">
                        <c:forEach var="book" items="${bookList}">
                            <div class="col-md-4 mb-4">
                                <div class="card book-card h-100">
                                    <img src="<c:url value='/books/${book.bookID}.jpg' />" class="card-img-top" alt="${book.title}">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${book.title}</h5>
                                        <p class="card-text">Author: ${book.authorName}</p>
                                        <p class="card-text">Price: <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$" /></p>
                                        <div class="d-flex justify-content-between mt-auto">
                                            <a href="<c:url value='/ViewDetailController?id=${book.bookID}' />" class="btn btn-primary">View Details</a>

                                            <c:if test="${not empty sessionScope.user}">
                                                <form action="<c:url value='/CartServlet' />" method="post">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="bookID" value="${book.bookID}">
                                                    <input type="hidden" name="title" value="${book.title}">
                                                    <input type="hidden" name="author" value="${book.authorName}">
                                                    <input type="hidden" name="price" value="${book.price}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="btn btn-success btn-add-custom">
                                                        <i class="fas fa-shopping-cart"></i> Add
                                                    </button>
                                                </form>
                                            </c:if>

                                            <c:if test="${empty sessionScope.user}">
                                                <button type="button" class="btn btn-warning btn-add-custom" data-bs-toggle="modal" data-bs-target="#loginModal">
                                                    <i class="fas fa-shopping-cart"></i> Add
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

        <%@ include file="/WEB-INF/layout/footer.jsp" %>

        <!-- Login Modal -->
        <div class="modal fade" id="orderSuccessModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="successModalLabel">Order Placed Successfully!</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Thank you for your purchase! Your order has been placed successfully.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="/WEB-INF/layout/footer.jsp" %>

        <!-- JS libraries -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Trigger modal if success -->
        <c:if test="${requestScope.orderSuccess == true}">
            <script>
                $(document).ready(function () {
                    $('#orderSuccessModal').modal('show');
                });
            </script>
        </c:if>
    </body>
</html>
