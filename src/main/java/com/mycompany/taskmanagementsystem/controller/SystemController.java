/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagementsystem.model.Task;
import com.mycompany.taskmanagementsystem.util.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SystemController", urlPatterns = {"/dashboard"})
public class SystemController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Task> individualTasks = new ArrayList<>();
        List<Task> groupTasks = new ArrayList<>();

        // Logic from Class Diagram: generateTaskList()
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM tasks"; 
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setTitle(rs.getString("title"));
                task.setCategory(rs.getString("category"));
                task.setPriority(rs.getString("priority"));
                
                // Sort tasks into UI buckets
                if ("Individual".equalsIgnoreCase(task.getCategory())) {
                    individualTasks.add(task);
                } else {
                    groupTasks.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Pass data to the View (dashboard.jsp)
        request.setAttribute("individualTasks", individualTasks);
        request.setAttribute("groupTasks", groupTasks);
        
        // Forward to the JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Get data from the form
    String title = request.getParameter("title");
    String category = request.getParameter("category");
    String priority = request.getParameter("priority");

    // Logic from Class Diagram: save(data)
    try (Connection conn = Database.getConnection()) {
        String sql = "INSERT INTO tasks (task_id, title, category, priority) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        
        // Generate a simple ID (e.g., using timestamp)
        ps.setString(1, "T-" + System.currentTimeMillis());
        ps.setString(2, title);
        ps.setString(3, category);
        ps.setString(4, priority);
        
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // After saving, redirect back to the dashboard to see the new list
    response.sendRedirect("dashboard");
}
}