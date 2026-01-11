/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.taskmanagementsystem.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.mycompany.taskmanagement.dao.TaskDAO;
import com.mycompany.taskmanagementsystem.model.Task;
import java.util.*;

/**
 *
 * @author Muhamad Zulhairie
 */
@WebServlet(name = "Dashboard2Servlet", urlPatterns = {"/dashboard2"})
public class Dashboard2Servlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int clientId = (int) session.getAttribute("clientId");
        TaskDAO dao = new TaskDAO();
        
        // Use your existing method to get all tasks
        List<Task> allTasks = dao.getTasksByOwner(clientId);
        
        // Filter the list into two parts
        List<Task> pendingTasks = new ArrayList<>();
        List<Task> completedTasks = new ArrayList<>();
        
        for (Task t : allTasks) {
            if ("Completed".equalsIgnoreCase(t.getStatus())) {
                completedTasks.add(t);
            } else {
                pendingTasks.add(t);
            }
        }
        
        // Set attributes for the JSP
        request.setAttribute("pendingTasks", pendingTasks);
        request.setAttribute("completedTasks", completedTasks);
        
        request.getRequestDispatcher("dashboard2.jsp").forward(request, response);
    }
}
