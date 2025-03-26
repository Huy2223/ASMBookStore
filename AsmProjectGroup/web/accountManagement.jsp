<%-- 
    Document   : accountManagement
    Created on : Mar 24, 2025, 11:50:13 PM
    Author     : dangn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account Mangement</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
        <style>
            html, body {
                height: 100%;
                margin: 0;
            }

            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .container-fluid {
                flex: 1;
                padding-top: 0.5px;
            }

            footer {
                width: 100%;
                background-color: #d74b1b;
                padding: 20px 0;
                margin-top: auto;
            }
        </style>
    </head>
    <body>

        <%@ include file="/WEB-INF/layout/header.jsp" %>

        <div class="container-fluid">

            <div class="row no-gutters">

                <div class="col-12">

                    <div class="table-responsive">

                        <table class="table table-bordered table-hover table-striped">

                            <thead class="table-dark text-center">

                                <tr>

                                    <th>AccountID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Order</th>
                                    <th>Actions</th>
                                </tr>

                            </thead>

                            <tbody>

                                <c:forEach var="account" items="${accountList}" varStatus="loop">

                                    <tr>

                                        <td class="text-center">${account.accountID}</td>

                                        <td>${account.userName}</td>

                                        <td>${account.email}</td>

                                        <td>${account.role}</td>
                                        <td class="text-center">${orderCounts[account.accountID]}</td>

                                        <td class="text-center">
                                            <a href="MainController?action=showUpdateFormAccount&accountId=${account.accountID}" class="btn btn-primary btn-sm">Update</a>
                                            <a href="MainController?action=deleteAccount&accountId=${account.accountID}" class="btn btn-primary btn-sm">Delete</a>
                                        </td>
                                    </tr>

                                </c:forEach>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>         

        </div>

        <%@ include file="/WEB-INF/layout/footer.jsp"%>
<div class="modal fade" id="deleteErrorModal" tabindex="-1" role="dialog" aria-labelledby="deleteErrorModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteErrorModalLabel">Deny Deletion</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <c:if test="${not empty deleteError}">
                            ${deleteError}
                        </c:if>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            <c:if test="${not empty deleteError}">
                $(document).ready(function() {
                    $('#deleteErrorModal').modal('show');
                });
            </c:if>
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
