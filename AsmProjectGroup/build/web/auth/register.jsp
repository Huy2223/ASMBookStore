<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Register</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .register-container {
                background-color: rgba(255, 255, 255, 0.6); /* Reduced opacity for more transparency */
                border: 1px solid rgba(0, 0, 0, 0.1);
                backdrop-filter: blur(10px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                padding: 20px;
                border-radius: 10px;
                width: 105%; /* Set a fixed width (adjust as needed) */
                margin: 0 auto; /* Center the container horizontally */
            }



            .text-center.mt-3 a {
                font-size:1.1rem;/* Target the link within the container */
                text-decoration: none; /* Remove underline */
            }
        </style>
    </head>
    <body class="register-page d-flex justify-content-center align-items-center vh-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="register-container">
                        <h3 class="text-center mb-4">Create an Account</h3>


                        <form action="<%=request.getContextPath()%>/RegisterController" method="post" id="registerForm">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Enter your name" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                            </div>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">${errorMessage}</div>
                            </c:if>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>
                            </div>
                            <c:if test="${not empty errorMessagePassword}">
                                <div class="alert alert-danger">${errorMessagePassword}</div>
                            </c:if>
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary">Register</button>
                            </div>
                            <div class="text-center mt-3">

                                <a href="<%= request.getContextPath()%>/auth/login.jsp" class="btn btn-link">Already have an account?</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>