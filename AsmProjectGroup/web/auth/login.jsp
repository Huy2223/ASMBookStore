<%-- 
    Document   : login
    Created on : Mar 7, 2025, 6:41:36 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login Page</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="login-page d-flex justify-content-center align-items-center vh-100">
        <div class="container login-container">
            <div class="row justify-content-center">
                      <div class="col-md-6">
                    <div class="card p-4 shadow-lg rounded-3">
                        <h3 class="login text-center mb-4">Login</h3>
                        <form action="<%= request.getContextPath() %>/MainController" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember Me</label>
                            </div>

                            <div class="d-grid mb-3">`
                                <button type="submit" value="login" name="action" class="btn btn-primary">Login</button>
                            </div>
                            ${errorMessage}

                            <div class="text-center">
                                <span>Don't have an account?</span>
                                <a href="<%= request.getContextPath() %>/auth/register.jsp" class="btn btn-outline-secondary ms-2">Sign Up</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>
