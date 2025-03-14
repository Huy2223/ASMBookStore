<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Tindex.css">

    </head>

    <body class="">
        <%@ include file="/WEB-INF/layout/header.jsp"%>

        <section class="container my-3">
            <div class=" text-center py-5">
                <img class="bookListImg img-thumbnail" 
                     src="<c:url value="/books/photo-background.jpg" />" 
                     alt="Book Image"  />
            </div>
        </section>

        <section class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h5>NEW ARRIVAL</h5>
            </div>
            <div class="slider-container">
                <div class="slider">
                    <c:forEach var="book" items="${newArrivalBooks}">
                        <div class="card">
                            <img class="bookListImg img-thumbnail"
                                 src="<c:url value="/books/${book.bookID}.jpg" />"
                                 alt="Book Image" />
                            <div class="card-body">
                                <h5 class="card-title">${book.title}</h5>
                                <p class="card-price font-weight-bold">
                                    <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/>
                                </p>
                                <div class="card-buttons">
                                    <button class="btn btn-add">Add to Cart</button>
                                    <a href="#" class="btn btn-view">View More</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </section>

        <section class="container my-4">
            <div class="d-flex justify-content-between align-items-center">
                <h5>BEST SELLER</h5>
                <a href="#">SEE MORE</a>
            </div>
            <div class="row">
                <c:forEach var="book" items="${bestSellers}">
                    <div class="col"><div class="border p-4">${book}</div></div>
                    </c:forEach>
            </div>
        </section>

        <section class="container my-4">
            <h5>CATEGORY</h5>
            <div class="row">
                <c:forEach var="category" items="${categories}">
                    <div class="col"><div class="border p-4">${category}</div></div>
                    </c:forEach>
            </div>
        </section>

        <section class="container my-4 text-center py-4 border">
            <h5>TÁC GIẢ NỔI BẬT</h5>
            <p>SHORT PORTFOLIO VỀ TÁC GIẢ</p>
        </section>

        <section class="container my-4">
            <div class="row">
                <c:forEach var="author" items="${featuredAuthors}">
                    <div class="col"><div class="border p-5">${author}</div></div>
                    </c:forEach>
            </div>
        </section>

        <footer class="bg-light py-3 mt-4">
            <div class="container d-flex justify-content-between">
                <div>LOGO COPYRIGHT</div>
                <div>CONTACT</div>
                <div>ĐĂNG KÍ NHẬN TIN<br>email</div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/js/main.js"></script>
    </body>


</html>