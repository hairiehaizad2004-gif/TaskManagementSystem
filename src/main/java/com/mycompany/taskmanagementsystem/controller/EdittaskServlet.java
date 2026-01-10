package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagementsystem.model.Task;
import com.mycompany.taskmanagementsystem.util.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

@WebServlet(name = "EditTaskServlet", urlPatterns = {"/EditTaskServlet"})
public class EdittaskServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get task ID from parameter
        String taskIdStr = request.getParameter("id");
        
        if (taskIdStr == null || taskIdStr.isEmpty()) {
            response.sendRedirect("dashboard");
            return;
        }
        
        try {
            int taskId = Integer.parseInt(taskIdStr);
            
            // Fetch task from database
            Task task = getTaskById(taskId);
            
            if (task != null) {
                // Set task as request attribute
                request.setAttribute("task", task);
                // Forward to edit page
                request.getRequestDispatcher("edittask.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Task not found");
                response.sendRedirect("dashboard");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form parameters
        String taskIdStr = request.getParameter("taskId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        String taskDateStr = request.getParameter("taskDate");
        
        try {
            int taskId = Integer.parseInt(taskIdStr);
            Date taskDate = Date.valueOf(taskDateStr);
            
            // Update task in database
            boolean success = updateTask(taskId, title, description, category, priority, status, taskDate);
            
            if (success) {
                // Redirect back to dashboard with success message
                response.sendRedirect("dashboard");
            } else {
                request.setAttribute("errorMessage", "Failed to update task");
                request.getRequestDispatcher("edittask.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("edittask.jsp").forward(request, response);
        }
    }
    
    /**
     * Fetch a task by ID from the database
     */
    private Task getTaskById(int taskId) {
        Task task = null;
        String sql = "SELECT * FROM APP.TASKS WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                task = new Task();
                task.setId(rs.getInt("TASK_ID"));
                task.setTitle(rs.getString("TITLE"));
                task.setDescription(rs.getString("DESCRIPTION"));
                task.setCategory(rs.getString("CATEGORY"));
                task.setPriority(rs.getString("PRIORITY"));
                task.setStatus(rs.getString("STATUS"));
                task.setTaskDate(rs.getDate("DUE_DATE"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return task;
    }
    
    /**
     * Update a task in the database
     */
    private boolean updateTask(int taskId, String title, String description, 
                               String category, String priority, String status, Date taskDate) {
        String sql = "UPDATE APP.TASKS SET TITLE = ?, DESCRIPTION = ?, CATEGORY = ?, " +
                     "PRIORITY = ?, STATUS = ?, DUE_DATE = ? WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setString(4, priority);
            ps.setString(5, status);
            ps.setDate(6, taskDate);
            ps.setInt(7, taskId);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}