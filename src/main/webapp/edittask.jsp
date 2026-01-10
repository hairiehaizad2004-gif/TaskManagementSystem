<%-- 
    Document   : edittask
    Created on : 10 Jan 2026, 3:32:25 pm
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

<style>
    .form-container {
        max-width: 600px;
        margin: 50px auto;
        padding: 30px;
        background: white;
        border: 2px solid #000;
        border-radius: 8px;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }
    
    .form-group input,
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }
    
    .form-group textarea {
        resize: vertical;
        min-height: 100px;
    }
    
    .btn-row {
        display: flex;
        gap: 10px;
        margin-top: 30px;
    }
    
    .btn {
        flex: 1;
        padding: 12px;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        font-weight: bold;
        font-size: 16px;
    }
    
    .btn-green {
        background-color: #27ae60;
        color: white;
    }
    
    .btn-gray {
        background-color: #999;
        color: white;
    }
    
    .btn:hover {
        opacity: 0.9;
    }
    
    .error-message {
        color: red;
        margin-bottom: 15px;
    }
    
    .success-message {
        color: green;
        margin-bottom: 15px;
    }
</style>

<div class="form-container">
    <h2 style="text-align: center; margin-bottom: 30px;">Edit Task</h2>
    
    <!-- Display error or success messages -->
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
    
    <c:if test="${not empty successMessage}">
        <div class="success-message">${successMessage}</div>
    </c:if>
    
    <form action="EditTaskServlet" method="POST">
        <!-- Hidden field for task ID -->
        <input type="hidden" name="taskId" value="${task.id}">
        
        <div class="form-group">
            <label for="title">Task Title *</label>
            <input type="text" id="title" name="title" value="${task.title}" required>
        </div>
        
        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description">${task.description}</textarea>
        </div>
        
        <div class="form-group">
            <label for="category">Category *</label>
            <select id="category" name="category" required>
                <option value="Individual" ${task.category == 'Individual' ? 'selected' : ''}>Individual</option>
                <option value="Group" ${task.category == 'Group' ? 'selected' : ''}>Group</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="priority">Priority *</label>
            <select id="priority" name="priority" required>
                <option value="Low" ${task.priority == 'Low' ? 'selected' : ''}>Low</option>
                <option value="Medium" ${task.priority == 'Medium' ? 'selected' : ''}>Medium</option>
                <option value="High" ${task.priority == 'High' ? 'selected' : ''}>High</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="status">Status *</label>
            <select id="status" name="status" required>
                <option value="Pending" ${task.status == 'Pending' ? 'selected' : ''}>Pending</option>
                <option value="In Progress" ${task.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                <option value="Completed" ${task.status == 'Completed' ? 'selected' : ''}>Completed</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="taskDate">Due Date *</label>
            <input type="date" id="taskDate" name="taskDate" value="${task.taskDate}" required>
        </div>
        
        <div class="btn-row">
            <button type="submit" class="btn btn-green">Update Task</button>
            <button type="button" class="btn btn-gray" onclick="location.href='dashboard'">Cancel</button>
        </div>
    </form>
</div>

<jsp:include page="footer.jsp" />

