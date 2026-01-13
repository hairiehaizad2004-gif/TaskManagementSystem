/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.controller;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import com.mycompany.taskmanagement.dao.TaskDAO;
import com.mycompany.taskmanagementsystem.model.Task; // Ensure path is correct
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/exportTasks")
public class ExportTasksServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("clientId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int clientId = (int) session.getAttribute("clientId");
        TaskDAO dao = new TaskDAO();
        
        // Fetch organized data using your existing DAO method
        // Note: passing null for filters to get ALL tasks for the report
        List<Task> allTasks = dao.getFilteredTasks(clientId, null, null, "priority");

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=My_Task_Report.pdf");

        try (Document document = new Document(PageSize.A4)) {
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Add Title
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Paragraph title = new Paragraph("Task Management System - Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);

            // Create Table with 5 columns
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);

            // Add Table Headers
            String[] headers = {"Title", "Category", "Priority", "Status", "Due Date"};
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header));
                cell.setBackgroundColor(java.awt.Color.LIGHT_GRAY);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
            }

            // Populate Table Rows
            for (Task t : allTasks) {
                table.addCell(t.getTitle());
                table.addCell(t.getCategory());
                table.addCell(t.getPriority());
                table.addCell(t.getStatus());
                table.addCell(t.getDueDate().toString());
            }

            document.add(table);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}