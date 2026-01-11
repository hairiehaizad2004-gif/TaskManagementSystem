package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagement.dao.TaskDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to toggle task status between Completed and Pending
 * URL Pattern: /toggleTaskStatus
 */
@WebServlet(name = "ToggleTaskStatusServlet", urlPatterns = {"/toggleTaskStatus"})
public class ToggleTaskStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            // Get task ID from request
            String taskIdStr = request.getParameter("taskId");
            
            if (taskIdStr != null && !taskIdStr.trim().isEmpty()) {
                int taskId = Integer.parseInt(taskIdStr);
                
                // Toggle the task status
                TaskDAO dao = new TaskDAO();
                boolean success = dao.toggleTaskStatus(taskId);
                
                if (success) {
                    System.out.println("Task status toggled successfully: ID=" + taskId);
                } else {
                    System.err.println("Failed to toggle task status: ID=" + taskId);
                }
            }
            
            // Redirect back to dashboard
            response.sendRedirect("dashboard");
            
        } catch (NumberFormatException e) {
            System.err.println("Invalid task ID: " + e.getMessage());
            response.sendRedirect("dashboard");
        } catch (Exception e) {
            System.err.println("Error toggling task status: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("dashboard");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to POST
        doPost(request, response);
    }

    @Override
    public String getServletInfo() {
        return "ToggleTaskStatusServlet - Toggles task between Completed and Pending";
    }
}