<%-- 
    Document   : Dashboard
    Created on : 7 Jan 2026, 3:00:52 pm
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TMS - Dashboard</title>
    </head>
    <body>
        <%
            // Basic Session Security Check
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        
        <h1>Welcome, ${user}!</h1>
        <p>This is your Task Management Dashboard.</p>
        
        <a href="LogoutServlet">Logout</a>
    </body>
</html>