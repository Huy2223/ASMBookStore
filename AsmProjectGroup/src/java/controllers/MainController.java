/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hd
 */
public class MainController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            String action = request.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "login":
                        url = "LoginController";
                        break;
                    case "register":
                        url = "RegisterController";
                        break;
                    case "popList":
                        url = "MainListController";
                        break;
                    case "categoryList":
                        url = "CategoryController";
                        break;
                    case "bestSellerList":
                        url = "BestSellerController";
                        break;
                    case "newArrivalList":
                        url = "NewArrivalController";
                        break;
                    case "logout":
                        url = "LogoutController";
                        break;
                    case "showUpdateForm":
                        url = "UpdateController";
                        break;
                    case "updateBook":
                        url = "UpdateController";
                        break;
                    case "bookManagement":
                        url = "BookListController";
                        break;
                    case "orderUser":
                        url = "OrderHistoryController";
                        break;
                    case "orderAdmin":
                        url = "OrderStatisticsController";
                        break;
                    case "search":
                        url = "SearchController";
                        break;
                    case "accountManagement":
                        url = "AccountController";
                        break;
                    case "showUpdateFormAccount":
                        url = "UpdateAccountController";
                        break;
                    case "updateAccount":
                        url = "UpdateAccountController";
                        break;
                    case "deleteAccount":
                        url = "DeleteAccountController";
                        break;
                }
            }

        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
