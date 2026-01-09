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
import java.sql.Date;

@WebServlet(name = "addtaskservlet", urlPatterns = {"/addtaskservlet"})
public class addtaskservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get data from the addTask.jsp form fields
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String priority = request.getParameter("priority");
        String dateString = request.getParameter("taskDate");
        
        //convert string to date
        java.sql.Date sqlDate = java.sql.Date.valueOf(dateString);

        // 2. Insert into Database
        try (Connection conn = Database.getConnection()) {
            // task_id is usually a Primary Key, we generate a unique one here
            String sql = "INSERT INTO APP.TASKS (TASK_ID, TITLE, CATEGORY, PRIORITY, TASK_DATE) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "T-" + System.currentTimeMillis()); 
            ps.setString(2, title);
            ps.setString(3, category);
            ps.setString(4, priority);
            ps.setDate(5, sqlDate);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 3. Redirect back to the dashboard to see the new task
        response.sendRedirect("dashboard");
    }
}