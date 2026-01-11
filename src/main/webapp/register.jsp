<%-- 
    Document   : register
    Created on : 9 Jan 2026, 11:10:06 pm
    Author     : Muhamad Zulhairie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TMS - Create Account</title>
    <style>
        :root {
            --primary-purple: #8e8cd8;
            --hover-purple: #7a78c2;
            --bg-light: #f8f9fa;
            --card-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--bg-light); 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }

        .register-container { 
            background: white; 
            padding: 40px; 
            border-radius: 16px; 
            box-shadow: var(--card-shadow); 
            width: 380px; 
        }

        h2 { text-align: center; color: #2d3436; margin-bottom: 30px; font-weight: 700; }

        label { font-size: 14px; color: #636e72; font-weight: 600; }

        input { 
            width: 100%; 
            padding: 12px; 
            margin: 8px 0 20px 0; 
            border: 1px solid #dfe6e9; 
            border-radius: 8px; 
            box-sizing: border-box; 
            transition: border-color 0.3s;
        }

        input:focus { border-color: var(--primary-purple); outline: none; }

        button { 
            width: 100%; 
            padding: 14px; 
            background-color: var(--primary-purple); 
            color: white; 
            border: none; 
            border-radius: 8px; 
            cursor: pointer; 
            font-size: 16px; 
            font-weight: bold;
            transition: all 0.3s ease;
        }

        button:hover { 
            background-color: var(--hover-purple); 
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(142, 140, 216, 0.4);
        }

        .login-link { text-align: center; margin-top: 20px; font-size: 14px; color: #636e72; }
        .login-link a { color: var(--primary-purple); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Create Account</h2>
        <form action="RegisterServlet" method="POST">
            <label>Username</label>
            <input type="text" name="username" placeholder="Choose a username" required>
            
            <label>Email Address</label>
            <input type="email" name="email" placeholder="example@mail.com" required>
            
            <label>Password</label>
            <input type="password" name="password" placeholder="Create a password" required>
            
            <button type="submit">Register Account</button>
        </form>
        <div class="login-link">
            Already have an account? <a href="Login.jsp">Login here</a>
        </div>
    </div>
</body>
</html>