<%-- 
    Document   : addtask
    Created on : 6 Jan 2026, 11:11:57 pm
    Author     : VICTUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Task</title>
    <style>
        body { font-family: sans-serif; background: #f4f4f4; padding: 50px; }
        .form-container { background: white; padding: 20px; border-radius: 8px; max-width: 400px; margin: auto; border: 1px solid #ccc; }
        input, select, textarea { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn-save { background: #27ae60; color: white; border: none; padding: 10px; width: 100%; cursor: pointer; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Create New Task</h2>
        <form action="addtaskservlet" method="POST">
            <label>Task Title</label>
            <input type="text" name="title" required placeholder="e.g., Study for Exam">
            
            <label>Category</label>
            <select name="category">
                <option value="Individual">Individual</option>
                <option value="Group">Group</option>
            </select>
            
            <label>Priority</label>
            <select name="priority">
                <option value="Low">Low</option>
                <option value="Medium">Medium</option>
                <option value="High">High</option>
            </select>
            
            <label for="taskDate">Due Date:</label>
            <input type="date" name="taskDate" id="taskDate" required class="form-control">   
            </div>
          
            <button type="submit" class="btn-save">Save Task</button>
        </form>
    
</body>
</html>
