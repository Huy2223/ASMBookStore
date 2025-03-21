<%-- 
    Document   : header
    Created on : Mar 12, 2025, 7:42:53 PM
    Author     : ACER
--%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<header class="navbar navbar-expand-lg" style="background-color: #D64D17;">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="<%= request.getContextPath()%>/MainController?action=popList">
            <img src="books/storelogo_cropped.png" width="90%">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav d-flex w-50 justify-content-center" style="gap: 45px; font-size: 1.2rem;">
                <li class="nav-item">
                    <a class="nav-link text-white text-center" href="<%= request.getContextPath()%>/MainController?action=popList" method="post">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white text-center" href="<%= request.getContextPath()%>/MainController?action=categoryList">Category</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white text-center" href="<%= request.getContextPath()%>/MainController?action=bestSellerList">Best Seller</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white text-center" href="<%= request.getContextPath()%>/MainController?action=newArrivalList">New Arrival</a>
                </li>
            </ul>
        </div>
        <div class="d-flex align-items-center">
            <c:if test="${not empty userInfo}">
                <span class="text-white me-3" style="font-size: 1.3rem;">Hello, ${userInfo.userName}</span>
            </c:if>
            <form class="d-flex">
                <input class="form-control me-2" type="search" id="searchInput" placeholder="Search books..." aria-label="Search" style="width: 250px; font-size: 1.1rem;">
                <div id="searchResults" style="position: absolute; background-color: white; border: 1px solid #ccc; width: 250px; display: none; z-index: 1000;"></div>
                <a href="<%= request.getContextPath()%>/cart.jsp" class="btn btn-outline-light">
                    <i class="bi bi-cart"></i>
                </a>
                <c:if test="${not empty userInfo}">
                    <a href="<%= request.getContextPath()%>/MainController?action=logout" class="btn btn-outline-light ms-2">Logout</a>
                </c:if>
                <c:if test="${empty userInfo}">
                    <a href="<%= request.getContextPath()%>/auth/login.jsp" class="btn btn-outline-light ms-2">Login</a>
                </c:if>
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#searchInput').on('input', function () {
                let searchTerm = $(this).val();
                if (searchTerm.length >= 3) {
                    $.ajax({
                        url: '<%= request.getContextPath()%>/SearchServlet',
                        type: 'GET',
                        data: {term: searchTerm},
                        success: function (data) {
                            let resultsHtml = '';
                            data.forEach(function (book) {
                                resultsHtml += '<div class="search-item" data-id="' + book.bookID + '" style="padding: 10px; border-bottom: 1px solid #eee; cursor: pointer;">' + book.title + '</div>';
                            });
                            $('#searchResults').html(resultsHtml).show();
                        }
                    });
                } else {
                    $('#searchResults').hide();
                }
            });

            $(document).on('click', '.search-item', function () {
                let bookId = $(this).data('id');
                window.location.href = '<%= request.getContextPath()%>/ViewDetailController?id=' + bookId;
                $('#searchResults').hide(); // Ẩn kết quả sau khi chọn
            });

            // Ẩn kết quả khi click ra ngoài
            $(document).on('click', function (event) {
                if (!$(event.target).closest('#searchInput, #searchResults').length) {
                    $('#searchResults').hide();
                }
            });
        });
    </script>
</header>
