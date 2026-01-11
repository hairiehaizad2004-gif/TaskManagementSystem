<%-- 
    Document   : UpdateTask
    Created on : 10 Jan 2026, 10:23:24 pm
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Task - Task Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            padding: 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .form-container { 
            background: white; 
            max-width: 600px; 
            width: 100%;
            margin: auto; 
            padding: 40px; 
            border-radius: 12px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.2); 
        }
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-header h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }
        .form-header p {
            color: #666;
            font-size: 14px;
        }
        .form-group { 
            margin-bottom: 20px; 
        }
        label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        label .required {
            color: #e74c3c;
        }
        input[type="text"], 
        input[type="date"], 
        select, 
        textarea { 
            width: 100%; 
            padding: 12px 15px; 
            box-sizing: border-box;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        input[type="text"]:focus, 
        input[type="date"]:focus, 
        select:focus, 
        textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23333' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            padding-right: 40px;
        }
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        button, .btn-cancel { 
            flex: 1;
            padding: 14px 20px; 
            border: none; 
            border-radius: 8px; 
            cursor: pointer; 
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }
        button[type="submit"] { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; 
        }
        button[type="submit"]:hover { 
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .btn-cancel {
            background: #95a5a6;
            color: white;
        }
        .btn-cancel:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }
        .error-message {
            background: #fee;
            border-left: 4px solid #e74c3c;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
            color: #c0392b;
        }
        .success-message {
            background: #e8f8f5;
            border-left: 4px solid #27ae60;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
            color: #229954;
        }
    </style>
</head>
<body>

<div class="form-container">
    <div class="form-header">
        <h2>✏️ Edit Task Details</h2>
        <p>Update the information for your task</p>
    </div>
    
    <c:if test="${not empty error}">
        <div class="error-message">
            <strong>Error:</strong> ${error}
        </div>
    </c:if>
    
    <c:if test="${empty task}">
        <div class="error-message">
            <strong>Error:</strong> Task not found. Please return to the dashboard.
        </div>
        <div style="text-align: center; margin-top: 20px;">
            <a href="dashboard" class="btn-cancel">Return to Dashboard</a>
        </div>
    </c:if>
    
    <c:if test="${not empty task}">
        <form action="updateTask" method="POST" onsubmit="return validateForm()">
            <input type="hidden" name="taskId" value="${task.id}">

            <div class="form-group">
                <label>Title <span class="required">*</span></label>
                <input type="text" id="title" name="title" value="${task.title}" required maxlength="100" placeholder="Enter task title">
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea id="description" name="description" placeholder="Enter task description (optional)" maxlength="500">${task.description}</textarea>
            </div>

            <div class="form-group">
                <label>Category <span class="required">*</span></label>
                <select name="category" required>
                    <option value="Individual" ${task.category == 'Individual' ? 'selected' : ''}>Individual</option>
                    <option value="Group" ${task.category == 'Group' ? 'selected' : ''}>Group</option>
                </select>
            </div>

            <div class="form-group">
                <label>Priority <span class="required">*</span></label>
                <select name="priority" required>
                    <option value="High" ${task.priority == 'High' ? 'selected' : ''}>🔴 High</option>
                    <option value="Medium" ${task.priority == 'Medium' ? 'selected' : ''}>🟡 Medium</option>
                    <option value="Low" ${task.priority == 'Low' ? 'selected' : ''}>🟢 Low</option>
                </select>
            </div>

            <div class="form-group">
                <label>Date <span class="required">*</span></label>
                <input type="date" id="dueDate" name="dueDate" value="${task.dueDate}" required>
            </div>

            <div class="button-group">
                <a href="dashboard" class="btn-cancel">Cancel</a>
                <button type="submit">💾 Save Changes</button>
            </div>
        </form>
    </c:if>
</div>

<script>
    function validateForm() {
        const title = document.getElementById('title').value.trim();
        const dueDate = document.getElementById('dueDate').value;
        
        if (!title) {
            alert('Please enter a task title.');
            return false;
        }
        
        if (!dueDate) {
            alert('Please select a task date.');
            return false;
        }
        
        // Confirm before saving
        return confirm('Are you sure you want to save these changes?');
    }
    
    // Set minimum date to today
    document.addEventListener('DOMContentLoaded', function() {
        const dateInput = document.getElementById('dueDate');
        if (dateInput) {
            const today = new Date().toISOString().split('T')[0];
            // Optional: Uncomment to prevent selecting past dates
            // dateInput.setAttribute('min', today);
        }
    });
</script>

</body>
</html>
