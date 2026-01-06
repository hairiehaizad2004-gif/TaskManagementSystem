/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.util;

/**
 *
 * @author VICTUS
 */
package com.taskmanagement.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    // These match the 'connectingString' attribute in your class diagram
    private static final String URL = "jdbc:mysql://localhost:3306/faculty_club_db";
    private static final String USER = "root"; 
    private static final String PASS = "yourpassword"; // Replace with your actual password

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver not found", e);
        }
    }
}