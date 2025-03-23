<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Order Statistics</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="//code.jqueryui.com/1.12.1/themes/base/jquery-ui.css">
</head>
<body class="page">
<%@ include file="/WEB-INF/layout/header.jsp" %>
<div class="container mt-4">
    <h1>Order Statistics</h1>

    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Filter Options</h5>
            <form action="OrderStatisticsController" method="get" class="form-inline">
                <label for="accountId" class="mr-2">Account ID:</label>
                <input type="number" id="accountId" name="accountId" value="${param.accountId}"
                       class="form-control mr-2">

                <label for="filterType" class="mr-2">Filter By:</label>
                <select name="filterType" id="filterType" class="form-control mr-2">
                    <option value="">All</option>
                    <option value="day">Day</option>
                    <option value="month">Month</option>
                    <option value="year">Year</option>
                </select>
                <label for="filterValue" class="mr-2">Select Date/Month/Year:</label>
                <input type="text" name="filterValue" id="filterValue" placeholder="Select Date/Month/Year"
                       class="form-control mr-2">

                <button type="submit" class="btn btn-primary">View Statistics for Account</button>
            </form>
        </div>
    </div>

    <c:if test="${not empty orderList}">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Order List</h5>
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Account ID</th>
                        <th>Order Date</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.accountId}</td>
                            <td><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatNumber value="${order.total}" type="currency"/></td>
                            <td>${order.status ? 'Completed' : 'Pending'}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="3" class="text-right"><strong>Total Amount:</strong></td>
                        <td colspan="2" class="text-center">
                            <fmt:formatNumber value="${totalAmount}" type="currency"/>
                        </td>
                    </tr>
                    </tfoot>
                </table>

                <c:if test="${not empty filterType && not empty filterValue}">
                    <p class="text-center">Filtered by: ${filterType} = ${filterValue}</p>
                </c:if>
            </div>
        </div>
    </c:if>

    <c:if test="${empty orderList}">
        <p class="text-center">No orders found.</p>
    </c:if>
</div>

<%@ include file="/WEB-INF/layout/footer.jsp" %>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jqueryui.com/1.12.1/jquery-ui.js"></script>
<script>
    $(function () {
        $('#filterType').change(function () {
            let filterType = $(this).val();
            let filterValue = $('#filterValue');

            if (filterType === 'day') {
                filterValue.datepicker({ dateFormat: 'yy-mm-dd' }).datepicker('show');
            } else if (filterType === 'month') {
                filterValue.datepicker({ dateFormat: 'yy-mm' }).datepicker('show');
            } else if (filterType === 'year') {
                filterValue.datepicker({ dateFormat: 'yy' }).datepicker('show');
            } else {
                filterValue.datepicker('destroy').val('');
            }
        });
    });
</script>

</body>
</html>