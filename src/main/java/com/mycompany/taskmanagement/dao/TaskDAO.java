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

public class TaskDAO {

    public List<Task> getTasksByOwner(int clientID) {
    List<Task> list = new ArrayList<>();
    String sql = "SELECT * FROM APP.TASKS WHERE OWNER = ?";
    
    try (Connection conn = Database.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, clientID);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Task t = new Task();
            t.setTitle(rs.getString("TITLE"));
            t.setCategory(rs.getString("CATEGORY"));
            // Convert SQL Date to String (YYYY-MM-DD) for the JSP logic
            t.setTaskDate(rs.getDate("TASK_DATE")); 
            list.add(t);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
    }
}