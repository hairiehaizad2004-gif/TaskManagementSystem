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
        
        // 1. Get the Client ID from the Session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Assuming clientId was stored as an Integer during Login
        int clientId = (int) session.getAttribute("clientId");

        // 2. Get Task details from the form
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priority = request.getParameter("priority");
        String dateStr = request.getParameter("taskDate"); // renamed to match your variable below

        // 3. SQL String (Only 6 columns, TASK_ID is omitted because it's Auto-Increment)
        String sql = "INSERT INTO APP.TASKS (TITLE, DESCRIPTION, CATEGORY, PRIORITY, DUE_DATE, CLIENT_ID) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Fix: ps.setX(index, value) must match the order in the SQL string above
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setString(4, priority);
            
            // Fix: Convert the String from the HTML date input to a SQL Date
            if (dateStr != null && !dateStr.isEmpty()) {
                ps.setDate(5, java.sql.Date.valueOf(dateStr));
            } else {
                ps.setNull(5, java.sql.Types.DATE);
            }
            
            ps.setInt(6, clientId);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("dashboard"); // Ensure this matches your dashboard file name
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Invalid Date Format: " + dateStr);
        }
    }
}