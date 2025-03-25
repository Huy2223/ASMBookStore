<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Account</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/update.css">
        <style>
            body {
                background-image: url('<%=request.getContextPath()%>/books/update-background.jpg'); 
                background-size: cover; /* Đảm bảo hình ảnh phủ đầy màn hình */
                background-repeat: no-repeat;
                background-attachment: fixed; /* Giữ hình nền cố định */
            }     
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Update Account</h1>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <form action="MainController" method="post">
                <input type="hidden" name="action" value="updateAccount">
                <input type="hidden" name="accountId" value="${accountToUpdate.accountID}">
                <input type="hidden" name="password" value="${accountToUpdate.password}">

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="userName">Username:</label>
                            <input type="text" class="form-control" id="userName" name="userName" value="${accountToUpdate.userName}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="authorId">Account ID:</label>
                            <input type="number" class="form-control" id="accountId" name="accountId" value="${accountToUpdate.accountID}" readonly="">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="${accountToUpdate.email}" readonly="">
                </div>

                <div class="form-group">
                    <label for="role">Role:</label>
                    <select class="form-control" id="role" name="role" required>
                        <option value="ADMIN" ${accountToUpdate.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                        <option value="CUSTOMER" ${accountToUpdate.role == 'CUSTOMER' ? 'selected' : ''}>CUSTOMER</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Update Account</button>
                <a href="MainController?action=accountManagement" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>   
    </body>
</html>
