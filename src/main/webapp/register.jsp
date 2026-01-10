<%-- 
    Document   : register
    Created on : 10 Jan 2026, 11:00:27 am
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Client Registration</title>
        <style>
            body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
            .register-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 350px; }
            h2 { text-align: center; color: #333; }
            input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
            button { width: 100%; padding: 10px; background-color: #6a1b9a; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
            button:hover { background-color: #4a148c; }
            .login-link { text-align: center; margin-top: 15px; font-size: 14px; }
            .login-link a { color: #6a1b9a; text-decoration: none; }
        </style>
    </head>
    <body>
        <div class="register-container">
            <h2>Create Account</h2>
            <form action="RegisterServlet" method="POST">
                <label>Username</label>
                <input type="text" name="username" placeholder="Choose a username" required>
                
                <label>Email</label>
                <input type="email" name="email" placeholder="example@mail.com" required>
                
                <label>Password</label>
                <input type="password" name="password" placeholder="Create a password" required>
                
                <button type="submit">Register</button>
            </form>
            <div class="login-link">
                Already have an account? <a href="Login.jsp">Login here</a>
            </div>
        </div>
    </body>
</html>