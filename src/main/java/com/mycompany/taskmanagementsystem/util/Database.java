/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    public static Connection getConnection() throws SQLException {
    try {
        // Change from com.mysql.cj.jdbc.Driver to Derby Client Driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        
        // This URL must match your Services tab exactly
        String url = "jdbc:derby://localhost:1527/TaskManagementSystem";
        String user = "app"; // Check if your DB uses a specific user
        String pass = "app"; 
        
        return DriverManager.getConnection(url, user, pass);
    } catch (ClassNotFoundException e) {
        throw new SQLException("Derby Driver not found", e);
    }
}
}