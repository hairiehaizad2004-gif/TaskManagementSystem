/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagementsystem.util.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

@WebServlet(name = "addtaskservlet", urlPatterns = {"/addtaskservlet"})
public class addtaskservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get the Client ID from the Session (The Foreign Key)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        int clientId = (int) session.getAttribute("clientId");

        // 2. Get Task details from the form
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String dateStr = request.getParameter("taskDate");

        // 3. Insert into database including the CLIENT_ID
        // Generate a unique ID since the database won't do it for VARCHAR
        String uniqueTaskId = java.util.UUID.randomUUID().toString().substring(0, 8); 

        String sql = "INSERT INTO APP.TASKS (TITLE, DESCRIPTION, CATEGORY, PRIORITY, STATUS, DUE_DATE) VALUES (?, ?, ?, ?, ?, ?)";
// No TASK_ID - it's auto-generated! ✅
// Using DUE_DATE instead of TASK_DATE ✅

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, uniqueTaskId); // Send the generated String ID
            ps.setString(2, title);
            ps.setString(3, category);
            ps.setDate(4, java.sql.Date.valueOf(dateStr));
            ps.setInt(5, clientId);
            
            ps.executeUpdate();
            response.sendRedirect("dashboard"); // Send them back to their updated dashboard
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}