<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=EB+Garamond:ital,wght@0,400..800;1,400..800&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<footer class="py-3 text-white" style="background-color: #D64D17;">
    <div class="container">
        <div class="row align-items-center justify-content-around"> <div class="col-md-6 text-center text-md-left">
                <div class="d-inline-block"> <img src="<c:url value='/books/kitten.png' />" alt="Logo" class="img-fluid" style="max-height: 170px; width: auto; margin-left: -50px;">                  
                    <p class="mt-3">
                        <i class="bi bi-geo-alt mr-2"></i> 395/13 TL28 Street, Thanh Loc Ward, District 12, Ho Chi Minh City 
                    </p>
                    <p><i class="bi bi-phone mr-2"></i> 096 7074 354</p>
                </div>
            </div>
            <div class="col-md-3 text-center text-md-left">
                <span class="font-weight-bold d-block mb-2" style="margin-top: 50px;">SHORTCUTS</span>   
                <div class="list-shortcut">
                    <div class="custom-order-list"> <c:if test="${empty userInfo}">
                            <a href="<%= request.getContextPath()%>/auth/login.jsp" class="d-block text-white">Login</a>
                        </c:if>
                        <c:if test="${not empty userInfo}">
                            <a href="<%= request.getContextPath()%>/MainController?action=popList" class="d-block text-white">Home Page</a>
                        </c:if>
                        <a href="<%= request.getContextPath()%>/MainController?action=categoryList" class="d-block text-white">Category</a>
                        <a href="<%= request.getContextPath()%>/MainController?action=bestSellerList" class="d-block text-white">Best Seller</a>
                        <a href="<%= request.getContextPath()%>/MainController?action=newArrivalList" class="d-block text-white">New Arrival</a>
                    </div>
                </div>

            </div>
            <div class="col-md-3 text-center stayconnect">
                <span class="font-weight-bold d-block mb-2">STAY CONNECT</span>
                <div class="mt-3">
                    <a href="https://www.facebook.com/profile.php?id=61574766410039" class="mx-2" target="_blank"><img src="<c:url value='/books/facebook.png' />" alt="Facebook" style="height: 30px;"></a>
                    <a href="https://www.instagram.com/_felinefolios_?igsh=cjBpN3NpdDc0eXVw" class="mx-2" target="_blank"><img src="<c:url value='/books/instagram-removebg.png' />" alt="Instagram" style="height: 23px;"></a>
                </div>
                <div class="mt-3 payment-icons">
                    <img src="<c:url value='/books/visa.png' />" alt="Visa" style="height: 25px; border-radius: 3px;">
                    <img src="<c:url value='/books/mastercard.png' />" alt="Mastercard" style="height: 25px; background-color: white; border-radius: 3px;">
                    <img src="<c:url value='/books/amex.png' />" alt="Amex" style="height: 25px; border-radius: 3px;">
                    <img src="<c:url value='/books/paypal.png' />" alt="Paypal" style="height: 25px; width: 37px; border-radius: 3px;">                  
                </div>
            </div>
        </div>
                <hr/>
        <div class="text-center mt-4"> <p style="font-size: 1em; color: white;">&copy; 2025 Feline Folios Book Store. All rights reserved</p>
    </div>
    </div>
</footer>