<%-- 
    Document   : header
    Created on : 8 Jan 2026, 11:41:05 pm
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        :root { --purple-primary: #8e8cd8; }
        body { font-family: sans-serif; margin: 0; background-color: #f4f4f4; }
        
        .top-nav { display: flex; background-color: var(--purple-primary); height: 80px; align-items: stretch; border-bottom: 2px solid #333; }
        
        /* Profile Section */
        .profile-section { flex: 2; display: flex; align-items: center; padding-left: 15px; gap: 10px; border-right: 1px solid #333; }
        .profile-icon { width: 50px; height: 50px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 30px; }
        
        /* Nav Links */
        .nav-link { 
            flex: 1; display: flex; align-items: center; justify-content: center; 
            text-decoration: none; color: black; font-weight: bold; border-right: 1px solid #333;
            transition: 0.3s; cursor: pointer;
        }
        .nav-link:hover { background: rgba(255,255,255,0.2); }
        .nav-active { background: #d1d0f5; }
    </style>
</head>
<body>
    <header class="top-nav">
        <div class="profile-section">
            <div class="profile-icon">👤</div>
            <div>
                <strong>Task Management System</strong><br>
                <small>Welcome, ${not empty username ? username : 'Guest'}!</small>
            </div>
        </div>
        <a href="home" class="nav-link nav-active">🏠 Home</a>
        <a href="task-status" class="nav-link">📊 Dashboard</a>
        <a href="task-details.jsp" class="nav-link">📋 Task Details</a>
        <a href="LogoutServlet" class="nav-link" style="color: red;">🚪 Logout</a>
    </header>