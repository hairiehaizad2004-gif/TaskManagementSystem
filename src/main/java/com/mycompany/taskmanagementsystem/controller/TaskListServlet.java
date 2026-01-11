/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagement.dao.TaskDAO;
import com.mycompany.taskmanagementsystem.model.Task;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to handle displaying, filtering, and sorting the Task List.
 */
@WebServlet(name = "TaskListServlet", urlPatterns = {"/tasklist"})
public class TaskListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Check Authentication (Security)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            // Redirect to login if user session is invalid or missing
            response.sendRedirect("Login.jsp");
            return;
        }

        // 2. Retrieve User ID and Filter Parameters from the request
        int clientId = (int) session.getAttribute("clientId");
        String category = request.getParameter("category"); // From the dropdown in tasklist.jsp
        String sortBy = request.getParameter("sortBy");     // From the dropdown in tasklist.jsp

        // 3. Fetch data from the DAO using the filtered method
        TaskDAO taskDAO = new TaskDAO();
        List<Task> taskList = taskDAO.getFilteredTasks(clientId, category, sortBy);

        // 4. Set the data as a request attribute for the JSP to read
        request.setAttribute("tasksList", taskList);

        // 5. Forward the request to the tasklist.jsp page
        request.getRequestDispatcher("tasklist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST requests back to the GET handler
        doGet(request, response);
    }
}
