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
                    <a class="nav-link text-white text-center" href="<%= request.getContextPath()%>/MainController?action=popList">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white text-center" href="<%= request.getContextPath()%>/MainController?action=categoryList">Category</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white text-center" href="<%= request.getContextPath()%>/MainController?action=bestSellerList">Best Seller</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white text-center" href="#">New Arrival</a>
                </li>
            </ul>
        </div>
        <div class="d-flex align-items-center">
            <c:if test="${not empty userInfo}">
                <span class="text-white me-3" style="font-size: 1.3rem;">Hello, ${userInfo.userName}</span>
            </c:if>
            <form class="d-flex">
                <input class="form-control me-2" type="search" placeholder="Search books..." aria-label="Search" style="width: 250px; font-size: 1.1rem;">
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
</header>
