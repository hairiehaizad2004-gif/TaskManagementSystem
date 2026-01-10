/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author Muhamad Zulhairie
 */
package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagementsystem.util.Database;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// ... (imports remain the same)

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Retrieve parameters
        String user = request.getParameter("username");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        // Basic validation: Check if fields are empty
        if (user == null || user.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            response.sendRedirect("Register.jsp?error=MissingFields");
            return;
        }

        // 2. SQL String - Explicitly listing columns is good practice
        // Note: We DO NOT list CLIENT_ID here because the DB handles it now
        String sql = "INSERT INTO APP.CLIENTS (USERNAME, PASSWORD, EMAIL) VALUES (?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, email);
            
            int result = ps.executeUpdate();
            
            if (result > 0) {
                // Success! Redirect to login
                response.sendRedirect("Login.jsp");
            } else {
                response.getWriter().println("Registration failed. No rows affected.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // This will help you see the exact SQL error in the browser if it fails again
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}