package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagement.dao.ClientDAO; // You'll create this next
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Retrieve data from the request parameters
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // 2. Database Validation using ClientDAO
        ClientDAO clientDao = new ClientDAO();
        int clientId = clientDao.getClientId(user, pass);

        if (clientId != -1) {
            // 3. Login Success: Create a session
            HttpSession session = request.getSession();
            
            session.setAttribute("clientId", clientId);
            // Set "username" to match what DashboardServlet expects
            session.setAttribute("username", user);
            
            
            // Redirect to the Dashboard Servlet (not the JSP directly)
            response.sendRedirect("dashboard");
            
        } else {
            // 4. Login Failed
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}