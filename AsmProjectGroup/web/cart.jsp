<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Shopping Cart</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="...your-integrity-hash..." crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }
            .container {
                flex: 1;
            }
            .cart-footer {
                background-color: #f4f4f4;
                text-align: center;
                padding: 10px 0;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            .quantity-update-container {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .quantity-update-container input[type="number"] {
        width: 100%; /* Chiều rộng cố định cho input */
    }

    .quantity-update-container .btn-primary {
        width: 100%; /* Giữ nguyên chiều rộng của button */
    }
        </style>
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp"%>

        <div class="container mt-5">
            <h2>Your Shopping Cart</h2>
            <c:if test="${not empty sessionScope.shopping_cart.carts}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Book Image</th>
                            <th>Book Title</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.shopping_cart.carts}">
                            <tr>
                                <td>
                                    <c:if test="${not empty item.book}">
                                        <img src="<c:url value='/books/${item.book.bookID}.jpg' />"
                                             alt="${item.book.title}" width="80" height="100"/>
                                    </c:if>
                                </td>
                                <td><c:if test="${not empty item.book}">${item.book.title}</c:if></td>
                                    <td>
                                    <c:if test="${not empty item.book}">
                                        <fmt:formatNumber value="${item.book.price}" type="currency" currencySymbol="$"/>
                                    </c:if>
                                </td>

                                <td>
                                    <div class="quantity-update-container">
                                        <form action="<c:url value='/CartServlet' />" method="post">
                                            <input type="number" name="quantity[${item.book.bookID}]" 
                                                   value="${item.quantity}" min="1" class="form-control" style="width: 60px;">
                                            <input type="hidden" name="action" value="update">
                                            <button type="submit" class="btn btn-primary btn-sm"><i class="fa-solid fa-arrow-rotate-right"></i></button>
                                        </form>
                                    </div>
                                </td>


                                <td>
                                    <c:if test="${not empty item.book}">
                                        <fmt:formatNumber value="${item.book.price * item.quantity}" type="currency" currencySymbol="$"/>
                                    </c:if>
                                </td>

                                <td>
                                    <form action="<c:url value='/CartServlet' />" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="bookID" value="${item.book.bookID}">
                                        <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                    </form>
                                </td>




                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-right"><strong>Grand Total:</strong></td>
                            <td><fmt:formatNumber value="${sessionScope.shopping_cart.totalAmount}" type="currency" currencySymbol="$"/></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>   

                <div class="d-flex justify-content-end" style="padding: 20px">                 
                    <c:if test="${not empty sessionScope.shopping_cart.carts}">
                        <form action="<c:url value='/OrderController' />" method="post">
                            <button type="submit" class="btn btn-success">Buy</button>
                        </form>                    
                    </c:if>
                </div>
            </c:if>


            <c:if test="${empty sessionScope.shopping_cart.carts}">
                <p>Your cart is empty.</p>
            </c:if>

            <c:if test="${not empty userInfo && userInfo.role == 'CUSTOMER'}">
                <a href="<%= request.getContextPath()%>/MainController?action=orderUser" class="btn btn-primary ml-2">Order History</a>
            </c:if>

        </div>

        <!-- Success Modal -->
        <div class="modal fade" id="orderSuccessModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="successModalLabel">Order Placed Successfully!</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Thank you for your purchase! Your order has been placed successfully.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/layout/footer.jsp"%>

        <!-- JS libraries -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Trigger modal if success -->
        <c:if test="${requestScope.orderSuccess == true}">
            <script>
                $(document).ready(function () {
                    $('#orderSuccessModal').modal('show');
                });
            </script>
        </c:if>

    </body>
</html>
