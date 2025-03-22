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
                                <div class="card book-card h-100" style="padding: 6px;" >
                                    <img src="<c:url value='/books/${book.bookID}.jpg' />" class="card-img-top" alt="${book.title}" style="height: 400px;">
                                    <div class="card-body d-flex flex-column" style="align-items: center; text-align: center;">
                                        <h5 class="card-title">${book.title}</h5>
                                        <p class="card-text">Author: ${book.authorName}</p>
                                        <p class="card-text">Price: <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$" /></p>
                                        <div class="d-flex flex-column mt-auto" style="width: 100%; align-items: center;">
                                            <div style="display: flex; justify-content: center; gap: 5px;">
                                                <a href="<c:url value='/ViewDetailController?id=${book.bookID}' />" class="btn btn-primary">View Details</a>

                                                <form action="<c:url value='/CartServlet' />" method="post">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="bookID" value="${book.bookID}">
                                                    <input type="hidden" name="title" value="${book.title}">
                                                    <input type="hidden" name="author" value="${book.authorName}">
                                                    <input type="hidden" name="price" value="${book.price}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <input type="hidden" name="returnUrl" value="CategoryController">
                                                    <button type="submit" class="btn btn-success btn-add-custom">
                                                        <i class="fas fa-cart-plus"></i> Add
                                                    </button>
                                                </form>

                                                <c:if test="${empty sessionScope.userInfo}">
                                                    <button type="button" class="btn btn-warning btn-add-custom" data-bs-toggle="modal" data-bs-target="#loginModal">
                                                        <i class="fas fa-shopping-cart"></i> Add
                                                    </button>
                                                </c:if>
                                            </div>
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

        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-white">
                        <h5 class="modal-title" id="loginModalLabel">Login Required</h5>
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

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>