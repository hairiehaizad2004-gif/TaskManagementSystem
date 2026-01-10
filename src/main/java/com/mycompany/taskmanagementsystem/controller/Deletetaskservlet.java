package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagementsystem.util.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "DeleteTaskServlet", urlPatterns = {"/DeleteTaskServlet"})
public class Deletetaskservlet extends HttpServlet {

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
            
            // Delete task from database
            boolean success = deleteTask(taskId);
            
            if (success) {
                // Redirect back to dashboard
                response.sendRedirect("dashboard");
            } else {
                // Could set an error message here
                response.sendRedirect("dashboard");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard");
        }
    }
    
    /**
     * Delete a task from the database
     */
    private boolean deleteTask(int taskId) {
        String sql = "DELETE FROM APP.TASKS WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, taskId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}