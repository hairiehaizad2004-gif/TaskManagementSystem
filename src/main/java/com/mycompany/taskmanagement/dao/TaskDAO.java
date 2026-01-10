/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Muhamad Zulhairie
 */
package com.mycompany.taskmanagement.dao;

import com.mycompany.taskmanagementsystem.model.Task;
import com.mycompany.taskmanagementsystem.util.Database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Task operations.
 * Maps database records from APP.TASKS to Task model objects.
 */
public class TaskDAO {

    public List<Task> getTasksByOwner(int clientId) {
        List<Task> tasks = new ArrayList<>();
        // Querying the APP.TASKS table for a specific client
        String sql = "SELECT * FROM APP.TASKS WHERE CLIENT_ID = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, clientId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                
                // Retrieving all fields as defined in your Class Diagram
                task.setTaskId(rs.getInt("TASK_ID"));
                task.setTitle(rs.getString("TITLE"));
                task.setDescription(rs.getString("DESCRIPTION"));
                task.setCategory(rs.getString("CATEGORY"));
                task.setPriority(rs.getString("PRIORITY"));
                
                // Using setDueDate to store the java.sql.Date for JSP formatting
                task.setDueDate(rs.getDate("DUE_DATE"));
                
                tasks.add(task);
            }
        } catch (SQLException e) {
            // Logs database connection or query errors
            e.printStackTrace();
        }
        return tasks;
    }
}