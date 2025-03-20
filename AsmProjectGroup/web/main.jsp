<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Store</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Tindex.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </head>
    <body class="">
        <%@ include file="/WEB-INF/layout/header.jsp"%>

        <div class="cart-icon">
            <a href="<c:url value='/cart' />">
                <i class="fas fa-shopping-cart"></i>
            </a>
        </div>

        <div id="loginAlert" class="alert alert-warning alert-dismissible fade show"
             role="alert" style="display: none;">
            You must log in to add items to your cart.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <section class="container my-6">
            <div class="text-center py-3">
                <img class="bookListImg" src="<c:url value="/books/photo-background.jpg" />"
                     alt="Book Image"/>
            </div>
        </section>

        <section class="container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="text-uppercase font-weight-bold">Best Seller</h5>
            </div>
            <div class="slider-container" id="bestSellerSlider">
                <div class="slider best-seller-slider">
                    <c:forEach var="book" items="${bestSellerBooks}">
                        <div class="card">
                            <img class="bookListImg"
                                 src="<c:url value="/books/${book.bookID}.jpg" />"
                                 alt="${book.title}" />
                            <div class="card-body">
                                <h5 class="card-title" title="${book.title}">${book.title}</h5>
                                <p class="card-price">
                                    <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/>
                                </p>

                                <c:if test="${not empty sessionScope.user}">
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookID" value="${book.bookID}">
                                        <input type="hidden" name="title" value="${book.title}">
                                        <input type="hidden" name="author" value="${book.authorName}">
                                        <input type="hidden" name="price" value="${book.price}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-success btn-add-custom">
                                            <i class="fas fa-cart-plus"></i> Add
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${empty sessionScope.user}">
                                    <button type="button" class="btn btn-warning btn-add-custom">
                                        <i class="fas fa-cart-plus"></i> Add
                                    </button>
                                </c:if>

                                <a href="<c:url value='ViewDetailController?id=${book.bookID}' />"
                                   class="view-details-link">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="text-uppercase font-weight-bold">New Arrival</h5>
            </div>
            <div class="slider-container" id="newArrivalSlider">
                <div class="slider new-arrival-slider">
                    <c:forEach var="book" items="${newArrivalBooks}">
                        <div class="card">
                            <img class="bookListImg"
                                 src="<c:url value='/books/${book.bookID}.jpg' />"
                                 alt="${book.title}" />
                            <div class="card-body text-center">
                                <h5 class="card-title" title="${book.title}">${book.title}</h5>
                                <p class="card-price">
                                    <fmt:formatNumber value="${book.price}" type="currency"
                                                      currencySymbol="$"/>
                                </p>

                                <c:if test="${not empty sessionScope.user}">
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookID" value="${book.bookID}">
                                        <input type="hidden" name="title" value="${book.title}">
                                        <input type="hidden" name="author" value="${book.authorName}">
                                        <input type="hidden" name="price" value="${book.price}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-success btn-add-custom">
                                            <i class="fas fa-cart-plus"></i> Add
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${empty sessionScope.user}">
                                    <button type="button" class="btn btn-warning btn-add-custom">
                                        <i class="fas fa-cart-plus"></i> Add
                                    </button>
                                </c:if>

                                <a href="<c:url value='ViewDetailController?id=${book.bookID}' />"
                                   class="view-details-link">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="text-uppercase font-weight-bold featured-author-title">
                    Featured Author
                </h5>
            </div>
            <img src="books/shortP.jpg" alt="Featured Author Image"
                 class="img-fluid mb-3 featured-author-image">
            <div class="row justify-content-center" style="padding: 80px">
                <c:forEach var="book" items="${authorBook}">
                    <div class="col-md-4 mb-4">
                        <div class="card" style="height: 800px;">
                            <img class="card-img-top featured-author-book-image"
                                 style="max-height: 630px;"
                                 src="<c:url value='/books/${book.bookID}.jpg' />"
                                 alt="${book.title}" />
                            <div class="card-body text-center featured-author-book-details">
                                <h5 class="card-title featured-author-book-title"
                                    title="${book.title}">${book.title}</h5>
                                <p class="card-text featured-author-book-price">
                                    <fmt:formatNumber value="${book.price}" type="currency"
                                                      currencySymbol="$"/>
                                </p>

                                <c:if test="${not empty sessionScope.user}">
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookID" value="${book.bookID}">
                                        <input type="hidden" name="title" value="${book.title}">
                                        <input type="hidden" name="author" value="${book.authorName}">
                                        <input type="hidden" name="price" value="${book.price}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-success btn-add-custom">
                                            <i class="fas fa-cart-plus"></i> Add
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${empty sessionScope.user}">
                                    <button type="button" class="btn btn-warning btn-add-custom">
                                        <i class="fas fa-cart-plus"></i> Add
                                    </button>
                                </c:if>

                                <a href="<c:url value='ViewDetailController?id=${book.bookID}' />"
                                   class="btn btn-primary view-details-link featured-author-view-details">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <footer class="py-3 mt-4" style="background-color: #D64D17; color: white;">
            <div class="container d-flex justify-content-between">
                <div>LOGO COPYRIGHT</div>
                <div>CONTACT</div>
                <div>ĐĂNG KÍ NHẬN TIN<br>email</div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<c:url value='/js/newArrivalSlider.js'/>"></script>
        <script src="<c:url value='/js/bestSellerSlider.js'/>"></script>

        <div id="loginAlert" class="alert alert-danger alert-dismissible fade show"
             role="alert" style="display: none;">
            Please login before add to cart.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const addToCartButtons = document.querySelectorAll(".btn-add-custom");

                addToCartButtons.forEach(button => {
                    button.addEventListener("click", function (event) {
                        let isUserLoggedIn = ${not empty sessionScope.user};

                        if (!isUserLoggedIn) {
                            event.preventDefault(); // Ngăn form submit
                            document.getElementById("loginAlert").style.display = "block";
                        }
                    });
                });
            });
        </script>
    </body>
</html>