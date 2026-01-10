<%-- 
    Document   : dashboard
    Created on : 6 Jan 2026, 10:15:56 pm
    Author     : VICTUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- Default values to prevent 'end < 0' errors if variables are missing --%>
<c:if test="${empty startDay}"><c:set var="startDay" value="1" /></c:if>
<c:if test="${empty daysInMonth}"><c:set var="daysInMonth" value="30" /></c:if>

<jsp:include page="header.jsp" />

<style>
    .main-container { display: flex; padding: 30px; gap: 20px; align-items: flex-start; }
    .current-task-panel { width: 350px; background: white; border: 2px solid #000; padding: 20px; border-radius: 4px; }
    .task-box { background: #e0e0e0; min-height: 100px; padding: 10px; margin-bottom: 20px; border-radius: 4px; border: 1px solid #ccc; }
    .calendar-panel { flex: 1; background: white; padding: 10px; border: 1px solid #ccc; border-radius: 8px; }
    .calendar-header { display: flex; justify-content: space-between; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
    table { width: 100%; border-collapse: collapse; }
    th { font-size: 12px; color: #666; padding: 10px; border-bottom: 1px solid #eee; }
    td { height: 80px; border: 0.5px solid #eee; text-align: left; vertical-align: top; padding: 5px; }
    .btn-row { display: flex; gap: 10px; }
    .btn { flex: 1; padding: 12px; border: none; border-radius: 20px; cursor: pointer; font-weight: bold; background: #999; color: white; }
    .btn-green { background-color: #27ae60; }
    .task-badge { background:#8e8cd8; color:white; font-size:10px; margin-top:2px; border-radius:3px; padding:2px; }
</style>

<div class="main-container">
    <aside class="current-task-panel">
        <h2 style="text-align: center;">Current Task</h2>
        
        <h3>Individual</h3>
        <div class="task-box">
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Individual'}">
                    <div class="task-item"><strong>${task.title}</strong> - ${task.dueDate}</div>
                </c:if>
            </c:forEach>
        </div>

        <h3>Group</h3>
        <div class="task-box">
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Group'}">
                    <div class="task-item"><strong>${task.title}</strong> - ${task.dueDate}</div>
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
                    <%-- Safety check for startDay --%>
                    <c:if test="${startDay > 1}">
                        <c:forEach var="i" begin="1" end="${startDay - 1}">
                            <td class="empty-day" style="background: #f9f9f9;"></td>
                        </c:forEach>
                    </c:if>

                    <c:forEach var="day" begin="1" end="${daysInMonth}" varStatus="status">
                        <td>
                            <span class="day-number">${day}</span>
                            <c:forEach var="task" items="${taskList}">
                                <fmt:formatDate value="${task.dueDate}" pattern="d" var="taskDay" />
                                <c:if test="${taskDay == day}">
                                    <div class="task-badge">${task.title}</div>
                                </c:if>
                            </c:forEach>
                        </td>
                        <%-- Logic to wrap rows every 7 days --%>
                        <c:if test="${(status.index + startDay) % 7 == 0 && day != daysInMonth}">
                            </tr><tr>
                        </c:if>
                    </c:forEach>
                </tr>
            </tbody>
        </table>
    </section>
</div>
