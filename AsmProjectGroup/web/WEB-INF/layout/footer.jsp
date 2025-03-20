<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
<footer class="py-5" style="background-color: #D64D17; color: white;"> 
    <div class="container d-flex justify-content-between">
        <div class="d-flex flex-column">
            <img src="<c:url value='/books/kitten.png' />" alt="Logo" style="height: 120px; width: 50%">
            <span>&copy; Copyright by Group 7</span>
            <p class="mt-3">
                <i class="bi bi-geo-alt mr-2"></i> 395/13 TL28 Thạnh Lộc Q.12 TP.HCM
            </p>
            <p><i class="bi bi-phone mr-2"></i> 096 7074 354</p>
        </div>
        <div class="d-flex flex-column">
            <span style="font-weight: bold; margin-bottom: 5px;">CUSTOMIZED ORDER</span>
            <c:if test="${empty userInfo}">
                <a href="<%= request.getContextPath()%>/auth/login.jsp" style="color: white; text-decoration: none; margin-bottom: 5px;">Login</a>
            </c:if>
            <c:if test="${not empty userInfo}">
                <a href="<%= request.getContextPath()%>/MainController?action=popList" style="color: white; text-decoration: none; margin-bottom: 5px;">Homepage</a>
            </c:if>
            <a href="<%= request.getContextPath()%>/MainController?action=categoryList" style="color: white; text-decoration: none; margin-bottom: 5px;">Category</a>
            <a href="<%= request.getContextPath()%>/MainController?action=bestSellerList" style="color: white; text-decoration: none; margin-bottom: 5px;">Best Seller</a>
        </div>
        <div class="d-flex flex-column align-items-center">
            <span>STAY CONNECT</span>
            <div class="d-flex mt-3">
                <a href="#" class="mx-2"><img src="<c:url value='/books/facebook.png' />" alt="Facebook" style="height: 30px;"></a>
                <a href="#" class="mx-2"><img src="<c:url value='/books/instagram.png' />" alt="Instagram" style="height: 30px;"></a>
            </div>
            <div class="d-flex mt-3">
                <img src="<c:url value='/books/visa.png' />" alt="Visa" style="height: 25px; margin-right: 5px;">
                <img src="<c:url value='/books/mastercard.png' />" alt="Mastercard" style="height: 25px; margin-right: 5px;">
                <img src="<c:url value='/books/amex.png' />" alt="Amex" style="height: 25px; margin-right: 5px;">
                <img src="<c:url value='/books/paypal.png' />" alt="Paypal" style="height: 25px; margin-right: 5px;">
                <img src="<c:url value='/images/bitcoin.png' />" alt="Bitcoin" style="height: 25px;">
            </div>
        </div>
    </div>
</footer>