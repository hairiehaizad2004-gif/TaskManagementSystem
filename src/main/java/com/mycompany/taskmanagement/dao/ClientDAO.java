package com.mycompany.taskmanagement.dao; // Ensure this matches your project structure

import com.mycompany.taskmanagementsystem.util.Database;
import java.sql.*;

public class ClientDAO {
    
    // Updated Method to return the unique Integer ID
    public int getClientId(String username, String password) {
        int clientId = -1;
        String sql = "SELECT CLIENT_ID FROM APP.CLIENTS WHERE USERNAME = ? AND PASSWORD = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Get the auto-generated integer from Derby
                clientId = rs.getInt("CLIENT_ID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clientId;
    }
}