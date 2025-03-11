<%-- 
    Document   : bookManagement
    Created on : Mar 9, 2025, 4:43:36 PM
    Author     : ACER
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sách</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
</head>
<body>
        <div class="container-fluid">
            <div class="row bg-light">
                <div class="col-12 text-center">
                    <h1>Book Store</h1>
                </div>
                <div>
                    <h3>Welcome hehe ${userInfo.userName}</h3>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Published Year</th>
                                <th>Price</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${bookList}">
                                <tr>
                                    <td>${book.bookID}</td>
                                    <td>${book.title}</td>
                                    <td>${book.authorName}</td>
                                    <td>${book.publishedYear}</td>
                                    <td>${book.price}</td>
                                    <td> <a href="" class="btn" data-bs-toggle="modal" data-bs-target="#updateModal">Update</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="row bg-light">
                <div class="col-12 text-center">
                    @copyright By Group 7
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>