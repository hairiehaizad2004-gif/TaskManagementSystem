<%-- 
    Document   : dashboard
    Created on : 6 Jan 2026, 10:15:56 pm
    Author     : VICTUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<style>
    .main-container { display: flex; padding: 30px; gap: 20px; align-items: flex-start; }
    
    /* Sidebar styling */
    .current-task-panel { width: 350px; background: white; border: 2px solid #000; padding: 20px; border-radius: 4px; }
    .task-category-box { background: #e0e0e0; min-height: 150px; padding: 10px; margin-bottom: 20px; border-radius: 4px; border: 1px solid #ccc; }
    
    /* Calendar styling to match image */
    .calendar-panel { flex: 1; background: white; padding: 10px; border: 1px solid #ccc; border-radius: 8px; }
    .calendar-header { display: flex; justify-content: space-between; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
    
    table { width: 100%; border-collapse: collapse; }
    th { font-size: 12px; color: #666; padding: 10px; border-bottom: 1px solid #eee; }
    td { height: 80px; border: 0.5px solid #eee; text-align: left; vertical-align: top; padding: 5px; }
    .today-cell { background-color: #e8f4fd; }

    /* Button Styling */
    .btn-row { display: flex; gap: 10px; }
    .btn { flex: 1; padding: 12px; border: none; border-radius: 20px; cursor: pointer; font-weight: bold; background: #999; color: white; }
    .btn-green { background-color: #27ae60; }
</style>

<div class="main-container">
    <aside class="current-task-panel">
        <h2 style="text-align: center;">Current Task</h2>
        
        <h3>Individual</h3>
        <div class="task-box">
            <h4>Individual</h4>
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Individual'}">
                    <div class="task-item">${task.title} - ${task.taskDate}</div>
                </c:if>
            </c:forEach>
        </div>

        <h3>Group</h3>
        <div class="task-box">
            <h4>Group</h4>
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Group'}">
                    <div class="task-item">${task.title} - ${task.taskDate}</div>
                </c:if>
            </c:forEach>
        </div>

        <div class="btn-row">
            <button class="btn btn-green" onclick="location.href='addtask.jsp'">Add Task</button>
            <button class="btn">Edit Task</button>
        </div>
    </aside>

    <section class="calendar-panel">
    <div class="calendar-header">
        <button onclick="location.href='dashboard?month=${currentMonth - 1}&year=${currentYear}'">&lt;</button>
        <h3>${monthName} ${currentYear}</h3>
        <button onclick="location.href='dashboard?month=${currentMonth + 1}&year=${currentYear}'">&gt;</button>
    </div>
    
    <table>
        <thead>
            <tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>
        </thead>
        <tbody>
            <tr>
                <c:forEach var="i" begin="1" end="${startDay - 1}">
                    <td class="empty-day" style="background: #f9f9f9;"></td>
                </c:forEach>

                <c:forEach var="day" begin="1" end="${daysInMonth}" varStatus="status">
                    <td style="height: 100px; vertical-align: top;">
                        <span class="day-number">${day}</span>
                        
                        <c:forEach var="task" items="${calendarTasks}">
                            <c:set var="dayStr" value="${day < 10 ? '0'.concat(day) : day}" />
                            <c:if test="${task.taskDate.endsWith('-'.concat(dayStr))}">
                                <div class="task-badge">${task.title}</div>
                            </c:if>
                        </c:forEach>
                    </td>

                    <c:if test="${(status.count + startDay - 1) % 7 == 0}">
                        </tr><tr>
                    </c:if>
                </c:forEach>
            </tr>
        </tbody>
    </table>
</section>
</div>

<jsp:include page="footer.jsp" />