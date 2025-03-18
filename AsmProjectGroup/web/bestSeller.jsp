<%-- 
    Document   : bestSeller
    Created on : Mar 18, 2025, 11:19:47 AM
    Author     : ACER
--%>

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
                
                <div class="col-md-12">
                    <div><h2 style="text-align: center;">All Best Seller Books</h2></div>
                    <div class="row">
                        <c:forEach var="book" items="${bestSellerBooks}">
                            <div class="col-md-3 mb-3 ">
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
