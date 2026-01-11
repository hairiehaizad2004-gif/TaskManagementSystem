package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagement.dao.TaskDAO;
import com.mycompany.taskmanagementsystem.model.Task;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateTaskServlet", urlPatterns = {"/updateTask"})
public class UpdateTaskServlet extends HttpServlet {

    // 1. SHOW THE EDIT PAGE
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session check (matching your dashboardServlet pattern)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            // Get the ID from the URL (dashboard.jsp)
            String idStr = request.getParameter("id");
            if(idStr != null) {
                int id = Integer.parseInt(idStr);
                
                TaskDAO dao = new TaskDAO();
                Task existingTask = dao.getTaskById(id);
                
                // Put the task object into the request so the JSP can read it
                request.setAttribute("task", existingTask);
                
                // Open the Update Page
                request.getRequestDispatcher("UpdateTask.jsp").forward(request, response);
            } else {
                response.sendRedirect("dashboard");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard");
        }
    }

    // 2. SAVE THE CHANGES
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Session check (matching your dashboardServlet pattern)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        try {
            // Get data from the form
            int id = Integer.parseInt(request.getParameter("taskId")); // Hidden field
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String priority = request.getParameter("priority");
            Date dueDate = Date.valueOf(request.getParameter("dueDate"));

            // Create Task object
            Task task = new Task();
            task.setTaskId(id);
            task.setTitle(title);
            task.setDescription(description);
            task.setCategory(category);
            task.setPriority(priority);
            task.setDueDate(dueDate);

            // Update Database
            TaskDAO dao = new TaskDAO();
            dao.updateTask(task);

            // Go back to Dashboard
            response.sendRedirect("dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            // Optional: redirect to an error page
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}