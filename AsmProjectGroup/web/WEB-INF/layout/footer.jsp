<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
<footer class="py-3 mt-4" style="background-color: #D64D17; color: white;">
    <div class="container d-flex justify-content-between">
        <div class="d-flex flex-column align-items-center"> 
            <img src="<c:url value='/books/kitten.png' />" alt="Cat Logo" style="height: 100px;">
            <span>Copyright by Group 7</span>
        </div>
         <div class="d-flex align-items-center">
            <span style="font-weight: bold; margin-right: 15px;">SHORTCUTS:</span>
            <span style="margin-right: 10px;">Search</span>
            <c:if test="${empty userInfo}">
                <a href="<%= request.getContextPath()%>/auth/login.jsp" style="color: white; text-decoration: none; margin-right: 10px;">Login</a>
            </c:if>
            <c:if test="${not empty userInfo}">
                <a href="<%= request.getContextPath()%>/MainController?action=popList" style="color: white; text-decoration: none; margin-right: 10px;">Homepage</a>
            </c:if>
            <span style="margin-right: 10px;">Register</span>
            <span style="margin-right: 10px;">Cart</span>
        </div>
        <div class="d-flex align-items-center">
            <span>ĐĂNG KÍ NHẬN TIN<br>email</span>
        </div>
    </div>
</footer>