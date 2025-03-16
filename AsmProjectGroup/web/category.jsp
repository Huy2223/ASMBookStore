<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Book Categories</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/category.css">
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp"%>

        <div class="container mt-4">
            <div class="row">
                <div class="col-md-2">
                    <h4>Categories</h4>
                    <form id="categoryFilterForm" action="CategoryController" method="get">
                        <c:forEach var="category" items="${categories}">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="selectedCategories" value="${category.categoryID}" id="category${category.categoryID}" <c:if test="${selectedCategories.contains(category.categoryID)}">checked</c:if>>
                                <label class="form-check-label" for="category${category.categoryID}">
                                    ${category.categoryName}
                                </label>
                            </div>
                        </c:forEach>
                        <button type="submit" class="btn btn-primary mt-2">Filter</button>
                    </form>
                </div>
                <div class="col-md-8">
                    <h2>All Books</h2>
                    <div class="row">
                        <c:forEach var="book" items="${bookList}">
                            <div class="col-md-4 mb-4">
                                <div class="card book-card h-100">
                                    <img src="<c:url value='/books/${book.bookID}.jpg' />" class="card-img-top" alt="${book.title}">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${book.title}</h5>
                                        <p class="card-text">Author: ${book.authorName}</p>
                                        <p class="card-text">Price: <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/></p>
                                        <div class="d-flex justify-content-between mt-auto">
                                            <a href="<c:url value='/ViewDetailController?id=${book.bookID}' />" class="btn btn-primary">View Details</a>
                                            <button class="btn btn-success">Add to Cart</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>