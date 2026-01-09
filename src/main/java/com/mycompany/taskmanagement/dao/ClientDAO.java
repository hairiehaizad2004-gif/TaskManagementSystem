/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagement.dao;

/**
 *
 * @author Muhamad Zulhairie
 */

import com.mycompany.taskmanagementsystem.util.Database;
import java.sql.*;

public class ClientDAO {
    
    // Method to validate a client during login
    public boolean validateClient(String username, String password) {
        boolean isValid = false;
        String sql = "SELECT * FROM APP.CLIENTS WHERE USERNAME = ? AND PASSWORD = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                isValid = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isValid;
    }
}