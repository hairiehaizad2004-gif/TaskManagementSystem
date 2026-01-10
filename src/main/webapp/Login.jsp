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
    <style>
            body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
            .login-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 350px; }
            h2 { text-align: center; color: #333; }
            input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
            button { width: 100%; padding: 10px; background-color: #6a1b9a; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
            button:hover { background-color: #4a148c; }
            .login-link { text-align: center; margin-top: 15px; font-size: 14px; }
            .login-link a { color: #6a1b9a; text-decoration: none; }
        </style>
    <body>
        <div class="login-container">
        <h2>Task Management System Login</h2>
        
        <%-- Display error message if login fails --%>
        <p style="color:red;">${errorMessage}</p>

        <form action="LoginServlet" method="POST">
            <label>Username:</label><br>
            <input type="text" name="username" required><br><br>
            
            <label>Password:</label><br>
            <input type="password" name="password" required><br><br>
            
            <input type="submit" value="Login">
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </form>
        </div>
    </body>
</html>