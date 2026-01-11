<%-- 
    Document   : tasklist
    Created on : Jan 11, 2026, 9:04:51 AM
    Author     : user
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

<div class="container mt-4">
    <div class="row">
        <div class="col-md-3">
            <div class="filter-section">
                <h5 class="mb-3">Filter & Sort</h5>
                <form action="tasklist" method="GET">
                    <label class="small fw-bold text-muted">CATEGORY</label>
                    <select name="category" class="form-select mb-3">
                        <option value="">All Categories</option>
                        <option value="Individual" ${param.category == 'Individual' ? 'selected' : ''}>Individual</option>
                        <option value="Group" ${param.category == 'Group' ? 'selected' : ''}>Group</option>
                    </select>

                    <label class="small fw-bold text-muted">SORT BY</label>
                    <select name="sortBy" class="form-select mb-4">
                        <option value="priority" ${param.sortBy == 'priority' ? 'selected' : ''}>High Priority First</option>
                        <option value="due_date" ${param.sortBy == 'due_date' ? 'selected' : ''}>Earliest Due Date</option>
                    </select>

                    <button type="submit" class="btn btn-primary w-100" style="background: var(--primary-purple); border:none;">Apply</button>
                </form>
            </div>
        </div>

        <div class="col-md-9">
            <div class="task-list-panel">
                <h3 class="mb-4">My Tasks</h3>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Title</th>
                                <th>Category</th>
                                <th>Priority</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- FIXED: Changed items to match your working "tasksList" --%>
                            <c:forEach var="task" items="${tasksList}">
                                <tr>
                                    <td><strong>${task.title}</strong></td>
                                    <td><span class="badge-category">${task.category}</span></td>
                                    <td>
                                        <span class="fw-bold" style="color: ${task.priority == 'High' ? 'var(--priority-high)' : (task.priority == 'Medium' ? 'var(--priority-medium)' : '#2ecc71')};">
                                            ● ${task.priority}
                                        </span>
                                    </td>
                                    <td>${task.dueDate}</td>
                                    <td>
                                        <span class="fw-bold" style="color: ${task.status == 'Completed' ? 'var(--priority-high)' : (task.status == 'In Progress' ? 'var(--priority-medium)' : '#2ecc71')};">
                                            ● ${task.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="UpdateTask.jsp?id=${task.taskId}" class="btn-update">
                                            Update 
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>