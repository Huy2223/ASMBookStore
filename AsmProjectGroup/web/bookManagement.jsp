<%-- 
    Document   : bookManagement
    Created on : Mar 9, 2025, 4:43:36 PM
    Author     : ACER
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sách</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp" %>
        <div class="container-fluid">


            <div class="row">
                <div class="col-12">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Published Year</th>
                                <th>Price</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${bookList}" varStatus="loop">
                                <tr>
                                    <td class="image-cell" style="text-align: center;">
                                        <img class="bookListImg" src="<c:url value="/books/${book.bookID}.jpg" />"  height="200px" /></td>
                                    <td>${book.bookID}</td>
                                    <td>${book.title}</td>
                                    <td>${book.authorName}</td>
                                    <td>${book.publishedYear}</td>
                                    <td><fmt:formatNumber value="${book.price}" type="currency" /></td>
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


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>