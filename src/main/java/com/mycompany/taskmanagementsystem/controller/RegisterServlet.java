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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        
        String user = request.getParameter("username");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        String sql = "INSERT INTO APP.CLIENTS (USERNAME, PASSWORD, EMAIL) VALUES (?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, email);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                // Success! Send them to login
                response.sendRedirect("Login.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}