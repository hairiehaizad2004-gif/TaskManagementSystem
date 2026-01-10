package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagement.dao.TaskDAO;
import com.mycompany.taskmanagementsystem.model.Task;
import java.io.IOException;
import java.util.*;
import java.time.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

// RENAMED to DashboardServlet (Capital D) to match best practices and avoid naming errors
@WebServlet(name = "dashboardServlet", urlPatterns = {"/dashboard"}) 
public class dashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Session & Security Check
        HttpSession session = request.getSession(false); // don't create a new session if one doesn't exist
        
        // Check if the client is logged in by looking for the clientId we stored in LoginServlet
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp"); // If not logged in, send them back to login
            return;
        }

        // 2. Get the Integer Client ID from the session
        int clientId = (int) session.getAttribute("clientId");

        // 3. Calendar Logic (Month/Year Navigation)
        LocalDate now = LocalDate.now();
        int month = (request.getParameter("month") != null) ? Integer.parseInt(request.getParameter("month")) : now.getMonthValue();
        int year = (request.getParameter("year") != null) ? Integer.parseInt(request.getParameter("year")) : now.getYear();

        if (month > 12) { month = 1; year++; }
        if (month < 1) { month = 12; year--; }

        YearMonth yearMonth = YearMonth.of(year, month);
        int daysInMonth = yearMonth.lengthOfMonth();
        int startDay = LocalDate.of(year, month, 1).getDayOfWeek().getValue();
        if (startDay == 7) startDay = 1; else startDay++; 

        // 4. Fetch Tasks ONLY for this Client ID
        TaskDAO dao = new TaskDAO();
        // UPDATED: Now passing the Integer clientId instead of a String username
        List<Task> tasks = dao.getTasksByOwner(clientId); 

        // 5. Set Attributes
        request.setAttribute("taskList", tasks); 
        request.setAttribute("calendarTasks", tasks); 
        request.setAttribute("daysInMonth", daysInMonth);
        request.setAttribute("startDay", startDay);
        request.setAttribute("monthName", yearMonth.getMonth().name());
        request.setAttribute("currentMonth", month);
        request.setAttribute("currentYear", year);

        // 6. Forward to JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}