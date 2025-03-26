<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Forgot Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .resetPassword-page {
                background-image: url('<%= request.getContextPath() %>/books/register-background.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
            }
            .resetPassword-container {
                background-color: rgba(255, 255, 255, 0.8);
                backdrop-filter: blur(5px);
                padding: 30px;
                border-radius: 10px;
                width: 110%;
            }

            .resetPassword-container h3 {
                color: black;
                font-size: 2.5rem;
                font-weight: bold; 
                text-transform: uppercase; 
                letter-spacing: 3px; 
                padding: 10px 20px;
                border-radius: 10px;
                display: inline-block;
                text-align: center;
            }


            .form-label {
                color: black;
            }
        </style>
    </head>
    <body class="resetPassword-page d-flex justify-content-center align-items-center vh-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="resetPassword-container">
                        <h3 class="text-center mb-4 w-100">Reset Password</h3>


                        <form action="<%=request.getContextPath()%>/MainController" method="post" id="resetPasswordForm">

                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                            </div>
                            <p><i><div style="color: red;">${errorMessage}</div></i></p>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="password" name="newPassword" placeholder="Enter your new password" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Re-enter your new password" required>
                            </div>
                            <c:if test="${not empty errorMessagePassword}">
                                <div class="alert alert-danger">${errorMessagePassword}</div>
                            </c:if>
                            <div class="d-grid mb-3">
                                <button type="submit" name="action" value="resetPassword" class="btn btn-primary">Reset Password</button>
                            </div>
                            <div class="d-grid mb-3">
                                <a href="<%= request.getContextPath()%>/auth/login.jsp" class="btn btn-secondary">Cancel</a>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
