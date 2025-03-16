<%-- 
    Document   : viewDetail
    Created on : Mar 16, 2025, 12:22:20 PM
    Author     : ACER
--%>

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
            <div class="book-container">
                <img class="book-image" src="<c:url value='/books/${book.bookID}.jpg' />" alt="${book.title}" />
                <div class="book-details">
                    <h2>${book.title}</h2>
                    <p><strong>Author:</strong> ${book.authorName}</p>
                    <p><strong>Category:</strong> ${book.categories}</p>
                    <p><strong>Published Year:</strong> ${book.publishedYear}</p>
                    <p><strong>Price:</strong> <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/></p>
                    <p><strong>Description:</strong> ${book.description}</p>
                    <button class="btn btn-add">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </div>
            </div>
        </section>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>