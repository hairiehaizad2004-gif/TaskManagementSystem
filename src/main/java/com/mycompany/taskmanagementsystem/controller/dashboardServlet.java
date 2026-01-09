package com.mycompany.taskmanagementsystem.controller;

import com.mycompany.taskmanagement.dao.TaskDAO;
import com.mycompany.taskmanagementsystem.model.Task;
import java.io.IOException;
import java.util.*;
import java.time.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "dashboardServlet", urlPatterns = {"/dashboardServlet"}) // This is the URL you will type in your browser
public class dashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Get Month/Year from URL parameters (defaults to current date)
        LocalDate now = LocalDate.now();
        int month = (request.getParameter("month") != null) ? Integer.parseInt(request.getParameter("month")) : now.getMonthValue();
        int year = (request.getParameter("year") != null) ? Integer.parseInt(request.getParameter("year")) : now.getYear();

        // Logic to handle month jumping (e.g., clicking '>' on December)
        if (month > 12) { month = 1; year++; }
        if (month < 1) { month = 12; year--; }

        // 2. Calendar Calculations
        YearMonth yearMonth = YearMonth.of(year, month);
        int daysInMonth = yearMonth.lengthOfMonth();
        
        // Find which day of the week the 1st starts on (1=Mon, 7=Sun)
        int startDay = LocalDate.of(year, month, 1).getDayOfWeek().getValue();
        // Adjust if your JSP calendar starts on Sunday
        if (startDay == 7) startDay = 1; else startDay++; 

        // 3. Fetch Tasks from Derby
        TaskDAO dao = new TaskDAO();
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("username");
        List<Task> tasks = dao.getTasksByOwner(user);

        // 4. Set Attributes for dashboard.jsp
        request.setAttribute("taskList", tasks); 
        request.setAttribute("calendarTasks", tasks); 
        request.setAttribute("daysInMonth", daysInMonth);
        request.setAttribute("startDay", startDay);
        request.setAttribute("monthName", yearMonth.getMonth().name());
        request.setAttribute("currentMonth", month);
        request.setAttribute("currentYear", year);

        // 5. GO TO THE JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}