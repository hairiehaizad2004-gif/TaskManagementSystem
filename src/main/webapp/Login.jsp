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

        .login-container { 
            background: white; 
            padding: 40px; 
            border-radius: 16px; 
            box-shadow: var(--card-shadow); 
            width: 380px; 
        }

        h2 { text-align: center; color: #2d3436; margin-bottom: 10px; font-weight: 700; }
        .subtitle { text-align: center; color: #b2bec3; margin-bottom: 30px; font-size: 14px; }

        .error-msg { 
            background-color: #fff2f2; 
            color: #d63031; 
            padding: 10px; 
            border-radius: 8px; 
            font-size: 13px; 
            text-align: center; 
            margin-bottom: 20px; 
        }

        label { font-size: 14px; color: #636e72; font-weight: 600; }

        input[type="text"], input[type="password"] { 
            width: 100%; 
            padding: 12px; 
            margin: 8px 0 20px 0; 
            border: 1px solid #dfe6e9; 
            border-radius: 8px; 
            box-sizing: border-box; 
            transition: border-color 0.3s;
        }

        input:focus { border-color: var(--primary-purple); outline: none; }

        input[type="submit"] { 
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

        input[type="submit"]:hover { 
            background-color: var(--hover-purple); 
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(142, 140, 216, 0.4);
        }

        .footer-link { text-align: center; margin-top: 25px; font-size: 14px; color: #636e72; }
        .footer-link a { color: var(--primary-purple); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Welcome Back</h2>
        <p class="subtitle">Task Management System</p>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-msg">${errorMessage}</div>
        </c:if>

        <form action="LoginServlet" method="POST">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter your username" required>
            
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter your password" required>
            
            <input type="submit" value="Login to Dashboard">
        </form>
        
        <div class="footer-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>
    </div>
</body>
</html>