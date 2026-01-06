<%-- 
    Document   : dashboard
    Created on : 6 Jan 2026, 10:15:56 pm
    Author     : VICTUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Task Management System | Dashboard</title>
    <style>
        /* CSS Variables to match your UI/UX design colors */
        :root {
            --purple-primary: #8e8cd8;
            --dark-header: #333333;
            --sidebar-bg: #ffffff;
            --btn-green: #27ae60;
            --btn-blue: #5dade2;
        }

        body { font-family: 'Segoe UI', Arial, sans-serif; margin: 0; background-color: #f0f2f5; }

        /* Top Navigation Bar */
        .top-nav { display: flex; background-color: var(--purple-primary); color: white; height: 80px; align-items: center; }
        .user-profile { flex: 1.5; padding-left: 20px; display: flex; align-items: center; gap: 10px; }
        .nav-link { 
            flex: 1; text-align: center; height: 100%; display: flex; 
            flex-direction: column; justify-content: center; border-left: 1px solid rgba(255,255,255,0.3);
            cursor: pointer; transition: 0.3s;
        }
        .nav-link:hover { background-color: rgba(255,255,255,0.1); }
        .nav-active { background-color: #d1d0f5; color: #333; }
        .nav-dark { background-color: var(--dark-header); }

        /* Main Content Layout */
        .main-container { display: flex; padding: 20px; gap: 20px; }

        /* Left Sidebar: Current Task List */
        .current-task-panel { 
            width: 300px; background: white; border: 2px solid #000; 
            border-radius: 5px; padding: 15px; 
        }
        .task-category { background: #e0e0e0; min-height: 120px; padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        
        /* Right Panel: Calendar */
        .calendar-panel { flex: 1; background: white; padding: 15px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 15px; text-align: center; }
        th { background: #f8f9fa; }

        /* Buttons */
        .btn-group { display: flex; gap: 10px; margin-top: 10px; }
        .btn { padding: 10px 20px; border: none; border-radius: 25px; color: white; cursor: pointer; font-weight: bold; }
        .btn-add { background-color: var(--btn-green); }
        .btn-edit { background-color: var(--btn-blue); }

        /* Footer Logout */
        .logout-footer { position: fixed; bottom: 15px; right: 25px; font-weight: bold; cursor: pointer; }
    </style>
</head>
<body>

    <header class="top-nav">
        <div class="user-profile">
            <div style="width:40px; height:40px; border-radius:50%; background:#ccc; border: 1px solid #000;"></div>
            <div>
                <strong>Task Management System</strong><br>
                <small>Welcome, User!</small>
            </div>
        </div>
        <div class="nav-link nav-active">🏠 Home</div>
        <div class="nav-link nav-dark">📊 Dashboard</div>
        <div class="nav-link">☰ Task Details</div>
    </header>

    <div class="main-container">
        <aside class="current-task-panel">
            <h3 style="text-align: center; margin-top: 0;">Current Task</h3>
            
            <h4>Individual</h4>
            <div class="task-category">
                <c:forEach var="task" items="${individualTasks}">
                    <p>• ${task.title} <small>[${task.priority}]</small></p>
                </c:forEach>
                <c:if test="${empty individualTasks}">
                    <p>No individual tasks found.</p>
                </c:if>
            </div>

            <h4>Group</h4>
            <div class="task-category">
                <c:forEach var="task" items="${groupTasks}">
                    <p>• ${task.title}</p>
                </c:forEach>
                <c:if test="${empty groupTasks}">
                    <p>No group tasks found.</p>
                </c:if>
            </div>

            <div class="btn-group">
                <button class="btn btn-add" onclick="location.href='addtask.jsp'">Add Task</button>
                <button class="btn btn-edit">Edit Task</button>
            </div>
        </aside>

        <section class="calendar-panel">
            <div style="display:flex; justify-content: space-between; align-items: center;">
                <button>&lt;</button>
                <h3>December 2025</h3>
                <button>&gt;</button>
            </div>
            <table>
                <thead>
                    <tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>
                </thead>
                <tbody>
                    <tr><td>30</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td></tr>
                    <tr><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td><td>12</td><td>13</td></tr>
                    <tr><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td style="background:#e8f4fd;">20</td></tr>
                    <tr><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td></tr>
                </tbody>
            </table>
        </section>
    </div>

    <footer class="logout-footer">
        Logout 🚪
    </footer>

</body>
</html>
