  <%-- 
    Document   : Login
    Created on : 7 Jan 2026, 2:58:45 pm
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>TMS - Login</title>
    <meta charset="UTF-8">
    <style>
        :root {
            --primary-purple: #8e8cd8;
            --hover-purple: #7a78c2;
            --bg-light: #f8f9fa;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        body { 
            font-family: 'Segoe UI', Arial, sans-serif; 
            background-color: var(--bg-light); 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }

        .login-container { 
            background: white; 
            padding: 40px; 
            border-radius: 20px; 
            box-shadow: var(--card-shadow); 
            width: 100%;
            max-width: 400px; 
            text-align: center;
        }

        h2 { color: #2d3436; margin-bottom: 5px; font-weight: 700; font-size: 24px; }
        .subtitle { color: #b2bec3; margin-bottom: 30px; font-size: 20px; font-weight: 700; }

        /* Professional Error Message Box */
        .error-msg { 
            background-color: #fff2f2; 
            color: #d63031; 
            padding: 12px; 
            border-radius: 10px; 
            font-size: 13px; 
            margin-bottom: 20px; 
            border: 1px solid #ffeded;
        }

        .form-group { text-align: left; margin-bottom: 20px; }

        label { 
            display: block;
            font-size: 14px; 
            color: #636e72; 
            font-weight: 600; 
            margin-bottom: 8px;
        }

        input[type="text"], input[type="password"] { 
            width: 100%; 
            padding: 12px 15px; 
            border: 1px solid #dfe6e9; 
            border-radius: 10px; 
            box-sizing: border-box; 
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input:focus { border-color: var(--primary-purple); outline: none; box-shadow: 0 0 0 3px rgba(142, 140, 216, 0.1); }

        input[type="submit"] { 
            width: 100%; 
            padding: 14px; 
            background-color: var(--primary-purple); 
            color: white; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            font-size: 16px; 
            font-weight: bold;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        input[type="submit"]:hover { 
            background-color: var(--hover-purple); 
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(142, 140, 216, 0.3);
        }

        .footer-link { text-align: center; margin-top: 25px; font-size: 14px; color: #636e72; }
        .footer-link a { color: var(--primary-purple); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Welcome Back</h2>
        <p class="subtitle">Task Management System</p>
        
        <%-- Display error message if login fails --%>
        <c:if test="${not empty errorMessage}">
            <div class="error-msg">${errorMessage}</div>
        </c:if>

        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter your username" required>
            </div>
            
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>
            
            <input type="submit" value="Login">
        </form>
        
        <div class="footer-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>
    </div>
</body>
</html>