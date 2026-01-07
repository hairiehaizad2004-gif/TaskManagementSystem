<%-- 
    Document   : Login
    Created on : 7 Jan 2026, 2:58:45 pm
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TMS - Login</title>
        <meta charset="UTF-8">
    </head>
    <body>
        <h2>Task Management System Login</h2>
        
        <%-- Display error message if login fails --%>
        <p style="color:red;">${errorMessage}</p>

        <form action="LoginServlet" method="POST">
            <label>Username:</label><br>
            <input type="text" name="username" required><br><br>
            
            <label>Password:</label><br>
            <input type="password" name="password" required><br><br>
            
            <input type="submit" value="Login">
        </form>
    </body>
</html>