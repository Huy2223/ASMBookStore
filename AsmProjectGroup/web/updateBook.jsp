<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Book</title>
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
    <h1>Update Book</h1>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <form action="MainController" method="post">
        <input type="hidden" name="action" value="updateBook">
        <input type="hidden" name="bookId" value="${bookToUpdate.bookID}">

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" value="${bookToUpdate.title}" required>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="authorId">Author ID:</label>
                    <input type="number" class="form-control" id="authorId" name="authorId" value="${bookToUpdate.authorID}" required>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="publishedYear">Published Year:</label>
                    <input type="number" class="form-control" id="publishedYear" name="publishedYear" value="${bookToUpdate.publishedYear}" required>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price" value="${bookToUpdate.price}" required>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description" rows="4" required>${bookToUpdate.description}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Book</button>
        <a href="MainController?action=bookManagement" class="btn btn-secondary">Cancel</a>
    </form>
</div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>   
</body>
 
</html>