package com.mycompany.taskmanagement.dao;

import com.mycompany.taskmanagementsystem.model.Task;
import com.mycompany.taskmanagementsystem.util.Database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Task operations
 * ENHANCED: Added toggle status method
 */
public class TaskDAO {

    /**
     * Get all tasks for a specific client
     */
    public List<Task> getTasksByOwner(int clientID) {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT * FROM APP.TASKS WHERE CLIENT_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, clientID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Task t = new Task();
                t.setTaskId(rs.getInt("TASK_ID"));
                t.setTitle(rs.getString("TITLE"));
                t.setDescription(rs.getString("DESCRIPTION"));
                t.setCategory(rs.getString("CATEGORY"));
                t.setPriority(rs.getString("PRIORITY"));
                t.setStatus(rs.getString("STATUS"));
                t.setDueDate(rs.getDate("DUE_DATE")); 
                list.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * Get a single task by ID
     */
    public Task getTaskById(int taskId) {
        Task task = null;
        String sql = "SELECT * FROM APP.TASKS WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                task = new Task();
                task.setTaskId(rs.getInt("TASK_ID"));
                task.setTitle(rs.getString("TITLE"));
                task.setDescription(rs.getString("DESCRIPTION"));
                task.setCategory(rs.getString("CATEGORY"));
                task.setPriority(rs.getString("PRIORITY"));
                task.setStatus(rs.getString("STATUS"));
                task.setDueDate(rs.getDate("DUE_DATE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return task;
    }
    
    /**
     * Update task details
     * Use case: UPDATE TASK DETAILS
     */
    public boolean updateTask(Task task) {
        String sql = "UPDATE APP.TASKS SET TITLE = ?, DESCRIPTION = ?, CATEGORY = ?, PRIORITY = ?, DUE_DATE = ? WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, task.getTitle());
            ps.setString(2, task.getDescription());
            ps.setString(3, task.getCategory());
            ps.setString(4, task.getPriority());
            ps.setDate(5, task.getDueDate());
            ps.setInt(6, task.getTaskId());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Mark task as completed
     * Use case: MARK COMPLETED TASK
     */
    public boolean markTaskAsCompleted(int taskId) {
        String sql = "UPDATE APP.TASKS SET STATUS = 'Completed' WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, taskId);
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Mark task as incomplete (reopen task)
     * NEW METHOD: Allows users to unmark completed tasks
     */
    public boolean markTaskAsIncomplete(int taskId) {
        String sql = "UPDATE APP.TASKS SET STATUS = 'Pending' WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, taskId);
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Toggle task status between Completed and Pending
     * NEW METHOD: Smart toggle based on current status
     */
    public boolean toggleTaskStatus(int taskId) {
        // First, get current status
        Task task = getTaskById(taskId);
        if (task == null) return false;
        
        // Toggle based on current status
        if ("Completed".equals(task.getStatus())) {
            return markTaskAsIncomplete(taskId);
        } else {
            return markTaskAsCompleted(taskId);
        }
    }
    
    public List<Task> getFilteredTasks(int clientId, String category, String sortBy) {
        List<Task> tasks = new ArrayList<>(); // Using his naming "tasks" internally
        StringBuilder sql = new StringBuilder("SELECT * FROM APP.TASKS WHERE CLIENT_ID = ?");

        // Apply your Category filter
        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND CATEGORY = '").append(category).append("'");
        }

        // Apply your Sort logic
        if (sortBy != null && sortBy.equals("due_date")) {
            sql.append(" ORDER BY DUE_DATE ASC");
        } else {
            sql.append(" ORDER BY CASE WHEN PRIORITY = 'High' THEN 1 WHEN PRIORITY = 'Medium' THEN 2 ELSE 3 END ASC");
        }

        try (Connection conn = com.mycompany.taskmanagementsystem.util.Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            ps.setInt(1, clientId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("TASK_ID")); // Matches Task.java
                task.setTitle(rs.getString("TITLE"));
                task.setDescription(rs.getString("DESCRIPTION"));
                task.setCategory(rs.getString("CATEGORY"));
                task.setPriority(rs.getString("PRIORITY"));
                task.setDueDate(rs.getDate("DUE_DATE"));
                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks; // Returns the list named 'tasks'
    }

    
    /**
     * Delete a task
     */
    public boolean deleteTask(int taskId) {
        String sql = "DELETE FROM APP.TASKS WHERE TASK_ID = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, taskId);
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
