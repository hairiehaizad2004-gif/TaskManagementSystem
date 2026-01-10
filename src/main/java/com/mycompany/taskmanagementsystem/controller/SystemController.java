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
import java.util.Calendar;
import java.util.Locale;
import java.text.DateFormatSymbols;

@WebServlet(name = "SystemController", urlPatterns = {"/system/dashboard1"})
public class SystemController extends HttpServlet {

  @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // 1. DECLARE LISTS (This fixes the red errors from your screenshot)
    List<Task> individualTasks = new ArrayList<>();
    List<Task> groupTasks = new ArrayList<>();
    List<Task> calendarTasks = new ArrayList<>();

    // Get month and year from URL parameters, default to current
    Calendar cal = Calendar.getInstance();
    int month = (request.getParameter("month") != null) ? Integer.parseInt(request.getParameter("month")) : cal.get(Calendar.MONTH);
    int year = (request.getParameter("year") != null) ? Integer.parseInt(request.getParameter("year")) : cal.get(Calendar.YEAR);

    // Normalize for navigation overflow
    cal.set(Calendar.MONTH, month);
    cal.set(Calendar.YEAR, year);
    cal.set(Calendar.DAY_OF_MONTH, 1);
    
    int currentMonth = cal.get(Calendar.MONTH);
    int currentYear = cal.get(Calendar.YEAR);
    int startDayOfWeek = cal.get(Calendar.DAY_OF_WEEK); 
    int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    String monthName = cal.getDisplayName(Calendar.MONTH, Calendar.LONG, java.util.Locale.ENGLISH);

    // 2. FETCH TASKS (Using DUE_DATE to match your Java DB)
    try (Connection conn = Database.getConnection()) {
        // Changed TASK_DATE to DUE_DATE here
        String sql = "SELECT * FROM APP.TASKS WHERE MONTH(DUE_DATE) = ? AND YEAR(DUE_DATE) = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, currentMonth + 1);
        ps.setInt(2, currentYear);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Task task = new Task();
            task.setTitle(rs.getString("TITLE")); 
            task.setCategory(rs.getString("CATEGORY")); 
            task.setPriority(rs.getString("PRIORITY")); 
            task.setTaskDate(rs.getDate("DUE_DATE")); 

            // Add to the main calendar list
            calendarTasks.add(task);

            // 3. FILL SIDEBAR LISTS
            if ("Individual".equalsIgnoreCase(task.getCategory())) {
                individualTasks.add(task);
            } else if ("Group".equalsIgnoreCase(task.getCategory())) {
                groupTasks.add(task);
            }
        } 
    } catch (SQLException e) { 
        e.printStackTrace(); 
    }

    // 4. PASS ALL LISTS TO JSP
    request.setAttribute("individualTasks", individualTasks);
    request.setAttribute("groupTasks", groupTasks);
    request.setAttribute("calendarTasks", calendarTasks);
    
    request.setAttribute("daysInMonth", daysInMonth);
    request.setAttribute("startDay", startDayOfWeek);
    request.setAttribute("monthName", monthName);
    request.setAttribute("currentMonth", currentMonth);
    request.setAttribute("currentYear", currentYear);

    request.getRequestDispatcher("dashboard.jsp").forward(request, response);
}
}