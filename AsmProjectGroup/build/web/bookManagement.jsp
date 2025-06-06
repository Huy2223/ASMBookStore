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
        <title>Book Management</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
    </head>
    <body>
        <%@ include file="/WEB-INF/layout/header.jsp" %>
        <div class="container-fluid">
            <div class="row no-gutters">
                <div class="col-12">
                    <table class="table table-bordered table-hover table-striped table-responsive">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Description</th>
                                <th>Published Year</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${bookList}" varStatus="loop">
                                <tr>
                                    <td class="text-center">${book.bookID}</td>
                                    <td class="image-cell text-center">
                                        <img class="bookListImg img-thumbnail" 
                                             src="<c:url value="/books/${book.bookID}.jpg" />" 
                                             alt="Book Image" />
                                    </td>
                                    <td>${book.title}</td>
                                    <td>${book.authorName}</td>
                                    <td>${book.description}</td>
                                    <td class="text-center">${book.publishedYear}</td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${book.price}" type="currency" />
                                    </td>
                                    <td class="text-center">
                                       <a href="MainController?action=showUpdateForm&bookId=${book.bookID}" class="btn btn-primary btn-sm">Update</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>         
        </div>
         <%@ include file="/WEB-INF/layout/footer.jsp"%>
    </body>
</html>