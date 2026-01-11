<%-- 
    Document   : dashboard2
    Created on : 11 Jan 2026, 9:30:10 pm
    Author     : Muhamad Zulhairie
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Task List - TaskManager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-purple: #8e8cd8;
            --secondary-blue: #5b92e5;
            --priority-high: #ff7675;
            --priority-medium: #fdcb6e;
            --bg-light: #f8f9fa;
            --text-muted: #6c757d;
            --card-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        body { background-color: var(--bg-light); }
        .filter-section, .task-list-panel { 
            background: white; padding: 25px; border-radius: 16px; box-shadow: var(--card-shadow); 
        }
        .badge-category { background-color: var(--primary-purple); color: white; padding: 5px 10px; border-radius: 8px; font-size: 0.85rem; }
        .btn-update {
        background-color: #6c5ce7; /* Purple to match your header */
        color: white;
        padding: 6px 12px;
        border-radius: 4px;
        text-decoration: none;
        font-size: 13px;
        font-weight: bold;
        display: inline-block;
        transition: background 0.3s;
        }

        .btn-update:hover {
            background-color: #a29bfe; /* Lighter purple on hover */
            color: white;
        }
    </style>
</head>
<body>

<%-- Use collaborator's header --%>
<jsp:include page="header.jsp" />

<div class="container">
    <h2>Task Overview</h2>

    <div class="card mb-4">
        <div class="card-header bg-warning text-dark">⏳ Pending Tasks</div>
        <table class="table">
            <thead>
                <tr><th>Title</th><th>Priority</th><th>Due Date</th><th>Action</th></tr>
            </thead>
            <tbody>
                <c:forEach var="task" items="${pendingTasks}">
                    <tr>
                        <td>${task.title}</td>
                        <td>${task.priority}</td>
                        <td>${task.dueDate}</td>
                        <td>
                            <a href="toggleTaskStatus?taskId=${task.taskId}" class="btn btn-sm btn-success">Mark Done</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="card">
        <div class="card-header bg-success text-white">✅ Completed Tasks</div>
        <table class="table">
            <thead>
                <tr><th>Title</th><th>Category</th><th>Action</th></tr>
            </thead>
            <tbody>
                <c:forEach var="task" items="${completedTasks}">
                    <tr>
                        <td style="text-decoration: line-through;">${task.title}</td>
                        <td>${task.category}</td>
                        <td>
                            <a href="deleteTask?taskId=${task.taskId}" class="btn btn-sm btn-danger">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>