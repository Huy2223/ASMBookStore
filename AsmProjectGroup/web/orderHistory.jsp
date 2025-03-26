<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <head>
        <title>Order History</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            .total-amount {
                font-size: 1.5rem; 
                color: #007bff; /* Màu xanh dương  */
                text-align: right; 
                margin-top: 20px; 
                padding: 10px;
                border-top: 1px solid #ddd; /* Thêm đường kẻ trên để phân tách */
            }

            .total-amount b {
                font-weight: bold;
            }

            .total-amount span {
                font-weight: bold; 
                color: #28a745; /* Màu xanh lá cây  */
            }
        </style>
    </head>
    <body class="page">
        <%@ include file="/WEB-INF/layout/header.jsp"%>
        <div class="container mt-4">
            <h1>Order History</h1>
            <c:if test="${not empty orderList}">
                <c:forEach var="order" items="${orderList}">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5 class="card-title">Order ID: ${order.orderId}</h5>
                                    <p class="card-text">Order Date: <fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd"/></p>
                                    <p class="card-text">Status: ${order.status ? 'Completed' : 'Pending'}</p>
                                    <p class="card-text">Total: <fmt:formatNumber value="${order.total}" type="currency"/></p>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-start">
                                        <div class="w-25">
                                            <p class="card-text"><b>Books:</b></p>
                                        </div>
                                        <div class="w-75">
                                            <ul class="list-unstyled">
                                                <c:forEach var="detail" items="${order.orderDetails}">
                                                    <li class="row mb-2">
                                                        <div class="col-4">
                                                            <c:if test="${not empty detail.bookId}">
                                                                <img src="<c:url value='/books/${detail.bookId}.jpg' />" class="img-thumbnail" alt="${detail.book.title}" width="100" height="100"/>
                                                            </c:if>
                                                        </div>
                                                        <div class="col-8">
                                                            <p>Book ID: ${detail.bookId}</p>
                                                            <p>Quantity: ${detail.quantity}</p>
                                                            <p>Unit Price: <fmt:formatNumber value="${detail.unitPrice}" type="currency"/></p>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <p class="total-amount">
                    <b>Total Amount:</b> <span><fmt:formatNumber value="${totalAmount}" type="currency"/></span>
                </p>
            </c:if>
            <c:if test="${empty orderList}">
                <p>No orders found.</p>
            </c:if>
        </div>
        <div style="width: 100%">
            <%@ include file="/WEB-INF/layout/footer.jsp"%>
        </div>
    </body>
</html>