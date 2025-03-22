<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Store</title>

        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

        <section class="my-6"> 
            <div class="text-center " style="width: 100%; ">
                <img src="<c:url value="/books/photo-background.jpg" />"
                     alt="Book Image" style="width: 100%; display: block; height: 800px;"/>
            </div>
        </section>

        <section class="container">
            <div class="d-flex justify-content-between align-items-center mb-2">
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

                                <c:if test="${not empty sessionScope.userInfo}">
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookID" value="${book.bookID}">
                                        <input type="hidden" name="title" value="${book.title}">
                                        <input type="hidden" name="author" value="${book.authorName}">
                                        <input type="hidden" name="price" value="${book.price}">
                                        <input type="hidden" name="quantity" value="1">
                                        <input type="hidden" name="returnUrl" value="MainListController">
                                        <button type="submit" class="btn btn-success btn-add-custom">
                                            <i class="fas fa-cart-plus"></i> Add
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${empty sessionScope.userInfo}">
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

                                <c:if test="${not empty sessionScope.userInfo}">
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookID" value="${book.bookID}">
                                        <input type="hidden" name="title" value="${book.title}">
                                        <input type="hidden" name="author" value="${book.authorName}">
                                        <input type="hidden" name="price" value="${book.price}">
                                        <input type="hidden" name="quantity" value="1">
                                        <input type="hidden" name="returnUrl" value="MainListController">
                                        <button type="submit" class="btn btn-success btn-add-custom">
                                            <i class="fas fa-cart-plus"></i> Add
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${empty sessionScope.userInfo}">
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
            <div class="row justify-content-center" style="padding: 80px;">
                <c:forEach var="book" items="${authorBook}">
                    <div class="col-md-4 mb-4">
                        <div class="card" style="height: 650px;">
                            <img class="card-img-top featured-author-book-image"
                                 style="max-height: 450px;"
                                 src="<c:url value='/books/${book.bookID}.jpg' />"
                                 alt="${book.title}" />
                            <div class="card-body text-center featured-author-book-details">
                                <h5 class="card-title featured-author-book-title"
                                    title="${book.title}">${book.title}</h5>
                                <p class="card-text featured-author-book-price">
                                    <fmt:formatNumber value="${book.price}" type="currency"
                                                      currencySymbol="$"/>
                                </p>

                                <c:if test="${not empty sessionScope.userInfo}">
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookID" value="${book.bookID}">
                                        <input type="hidden" name="title" value="${book.title}">
                                        <input type="hidden" name="author" value="${book.authorName}">
                                        <input type="hidden" name="price" value="${book.price}">
                                        <input type="hidden" name="quantity" value="1">
                                        <input type="hidden" name="returnUrl" value="MainListController">
                                        <button type="submit" class="btn btn-success btn-add-custom">
                                            <i class="fas fa-cart-plus"></i> Add
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${empty sessionScope.userInfo}">
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
                    </div>
                </c:forEach>
            </div>
        </section>

        <%@ include file="/WEB-INF/layout/footer.jsp"%>





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
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                const addToCartButtons = document.querySelectorAll(".btn-add-custom");

                addToCartButtons.forEach(button => {
                    button.addEventListener("click", function (event) {
                        let isUserLoggedIn = ${not empty sessionScope.userInfo};
                        if (!isUserLoggedIn) {
                            event.preventDefault();
                            $('#loginModal').modal('show');
                        }
                    });
                });
            });
        </script>
        <script src="<c:url value='/js/newArrivalSlider.js'/>"></script>
        <script src="<c:url value='/js/bestSellerSlider.js'/>"></script>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/js/newArrivalSlider.js'/>"></script>
    <script src="<c:url value='/js/bestSellerSlider.js'/>"></script>

</body>
</html>