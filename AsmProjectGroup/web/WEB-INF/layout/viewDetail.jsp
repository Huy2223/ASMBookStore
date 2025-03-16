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
                        <button class="btn btn-warning shadow-sm">
                            <i class="fas fa-cart-plus"></i> Add to Cart
                        </button>
                    </td>
                </tr>
            </table>
        </section>
       
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    <footer class="py-3 mt-4" style="background-color: #D64D17; color: white;">
    <div class="container d-flex justify-content-between">
        <div>LOGO COPYRIGHT</div>
        <div>CONTACT</div>
        <div>ĐĂNG KÍ NHẬN TIN<br>email</div>
    </div>
</footer>
</html>