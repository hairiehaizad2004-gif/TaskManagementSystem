<%-- 
    Document   : header
    Created on : 8 Jan 2026, 11:41:05 pm
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    /* Resetting the body to remove white gaps */
    body {
        margin: 0 !important;
        padding: 0 !important;
        font-family: 'Segoe UI', sans-serif;
    }

    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #8e8cd8;
        padding: 0 40px;
        height: 70px;
        color: white;
        margin: 0;
        width: 100%;
        box-sizing: border-box;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .nav-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 700;
        font-size: 1.3rem;
        border-right: 1px solid rgba(255, 255, 255, 0.2);
    }

    .nav-menu {
        display: flex;
        list-style: none;
        gap: 30px;
        margin: 0;
        padding: 0;
    }

    .nav-link {
        color: white;
        text-decoration: none;
        font-weight: 500;
    }
    .nav-link:hover, .nav-brand:hover {
        background-color: #7a78c2; /* Darker purple when hovering */
    }
    .user-section {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .avatar {
        width: 35px;
        height: 35px;
        background: white;
        color: #8e8cd8;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-weight: bold;
    }

    .logout-btn {
        background-color: #ff7675;
        color: white;
        padding: 8px 18px;
        border-radius: 8px;
        text-decoration: none;
        font-weight: bold;
    }
</style>

<nav class="navbar">
    <div class="nav-brand">
        <span>🗓️</span> TaskManager
    </div>

    <ul class="nav-menu">
        <li><a href="dashboard" class="nav-link">🏠 Home</a></li>
        <li><a href="dashboard" class="nav-link">📊 Dashboard</a></li>
        <li><a href="dashboard" class="nav-link">📋 Task List</a></li>
    </ul>

    <div class="user-section">
        <div class="user-profile-section" style="display:flex; align-items:center; gap:10px;">
            <div class="avatar">
                <%-- This uses the library to get the first letter --%>
                ${fn:substring(sessionScope.username, 0, 1).toUpperCase()}
            </div>
            <div style="display:flex; flex-direction:column;">
                <span style="font-size:0.9rem; font-weight:600;">${sessionScope.username}</span>
                <span style="font-size:0.7rem; opacity:0.8;">Active Student</span>
            </div>
        </div>
        <a href="LogoutServlet" class="logout-btn">Logout</a>
    </div>
</nav>