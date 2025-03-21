<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Categories</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/category.css">
</head>
<body>
    <%@ include file="/WEB-INF/layout/header.jsp"%>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-2">
                <h4>Categories</h4>
                <form id="categoryFilterForm" action="CategoryController" method="get">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Fiction" id="categoryFiction" <c:if test="${selectedCategories.contains('Fiction')}">checked</c:if>>
                        <label class="form-check-label" for="categoryFiction">Fiction</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Coming-of-age" id="categoryComingOfAge" <c:if test="${selectedCategories.contains('Coming-of-age')}">checked</c:if>>
                        <label class="form-check-label" for="categoryComingOfAge">Coming-of-age</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Surrealism" id="categorySurrealism" <c:if test="${selectedCategories.contains('Surrealism')}">checked</c:if>>
                        <label class="form-check-label" for="categorySurrealism">Surrealism</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Sci-fi" id="categorySciFi" <c:if test="${selectedCategories.contains('Sci-fi')}">checked</c:if>>
                        <label class="form-check-label" for="categorySciFi">Sci-fi</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Historical" id="categoryHistorical" <c:if test="${selectedCategories.contains('Historical')}">checked</c:if>>
                        <label class="form-check-label" for="categoryHistorical">Historical</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Dystopian" id="categoryDystopian" <c:if test="${selectedCategories.contains('Dystopian')}">checked</c:if>>
                        <label class="form-check-label" for="categoryDystopian">Dystopian</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Romance" id="categoryRomance" <c:if test="${selectedCategories.contains('Romance')}">checked</c:if>>
                        <label class="form-check-label" for="categoryRomance">Romance</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Philosophy" id="categoryPhilosophy" <c:if test="${selectedCategories.contains('Philosophy')}">checked</c:if>>
                        <label class="form-check-label" for="categoryPhilosophy">Philosophy</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Fantasy" id="categoryFantasy" <c:if test="${selectedCategories.contains('Fantasy')}">checked</c:if>>
                        <label class="form-check-label" for="categoryFantasy">Fantasy</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Children Fiction" id="categoryChildrenFiction" <c:if test="${selectedCategories.contains('Children Fiction')}">checked</c:if>>
                        <label class="form-check-label" for="categoryChildrenFiction">Children Fiction</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="selectedCategories" value="Non-fiction" id="categoryNonFiction" <c:if test="${selectedCategories.contains('Non-fiction')}">checked</c:if>>
                        <label class="form-check-label" for="categoryNonFiction">Non-fiction</label>
                    </div>
                    <button type="submit" class="btn btn-primary mt-2">Filter</button>
                    <div class="mt-3">
                        <label for="priceSort">Sort by Price:</label>
                        <select name="priceSort" id="priceSort" class="form-control">
                            <option value="none">None</option>
                            <option value="asc" <c:if test="${priceSort == 'asc'}">selected</c:if>>Low to High</option>
                            <option value="desc" <c:if test="${priceSort == 'desc'}">selected</c:if>>High to Low</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="col-md-8">
                <h2>All Books</h2>
                <div class="row">
                    <c:forEach var="book" items="${bookList}">
                        <div class="col-md-4 mb-4">
                            <div class="card book-card h-100">
                                <img src="<c:url value='/books/${book.bookID}.jpg' />" class="card-img-top" alt="${book.title}">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${book.title}</h5>
                                    <p class="card-text">Author: ${book.authorName}</p>
                                    <p class="card-text">Price: <fmt:formatNumber value="${book.price}" type="currency" currencySymbol="$"/></p>
                                    <div class="d-flex justify-content-between mt-auto">
                                        <a href="<c:url value='/ViewDetailController?id=${book.bookID}' />" class="btn btn-primary">View Details</a>
                                        <button class="btn btn-success">Add to Cart</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/layout/footer.jsp"%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>