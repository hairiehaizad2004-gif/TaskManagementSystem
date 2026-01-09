<%-- 
    Document   : register
    Created on : 9 Jan 2026, 11:10:06 pm
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Client Registration</title>
    <style>
        .reg-container { width: 300px; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px; }
        input { width: 100%; margin-bottom: 10px; padding: 8px; }
        button { width: 100%; background-color: #27ae60; color: white; padding: 10px; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <div class="reg-container">
        <h2>Register Client</h2>
        <form action="RegisterServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Create Account</button>
        </form>
    </div>
</body>
</html>