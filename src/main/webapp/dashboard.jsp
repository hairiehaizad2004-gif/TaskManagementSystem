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
    td { height: 100px; border: 0.5px solid #eee; text-align: left; vertical-align: top; padding: 5px; width: 14.28%; }
    .btn-row { display: flex; gap: 10px; margin-top: 10px; }
    .btn { flex: 1; padding: 12px; border: none; border-radius: 20px; cursor: pointer; font-weight: bold; background: #999; color: white; text-align: center; text-decoration: none; }
    .btn-green { background-color: #27ae60; }
    .task-badge { background:#8e8cd8; color:white; font-size:10px; margin-top:2px; border-radius:3px; padding:2px; cursor: help; }
    .empty-day { background: #f9f9f9; }
</style>

<div class="main-container">
    <aside class="current-task-panel">
        <h2 style="text-align: center;">Current Task</h2>

        <h3>Individual</h3>
        <div class="task-box">
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Individual'}">
                    <div class="task-item" style="padding: 5px; border-bottom: 1px solid #ddd;">
                        <strong>${task.title}</strong><br>
                        <%-- Fixed: Ensure property name matches your Task model --%>
                        <small>Due: ${task.dueDate}</small>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <h3>Group</h3>
        <div class="task-box">
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Group'}">
                    <div class="task-item" style="padding: 5px; border-bottom: 1px solid #ddd;">
                        <strong>${task.title}</strong><br>
                        <small>Due: ${task.dueDate}</small>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="btn-row">
            <a href="addtask.jsp" class="btn btn-green">Add Task</a>
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
                    <%-- 1. Correct Weekday Alignment: Fill empty slots before day 1 --%>
                    <c:if test="${startDay > 1}">
                        <c:forEach var="i" begin="1" end="${startDay - 1}">
                            <td class="empty-day"></td>
                        </c:forEach>
                    </c:if>

                    <%-- 2. Main Calendar Day Loop --%>
                    <c:forEach var="day" begin="1" end="${daysInMonth}" varStatus="status">
                        <td>
                            <span class="day-number">${day}</span>

                            <%-- 3. Null-Safe Task Check --%>
                            <c:forEach var="task" items="${taskList}">
                            <c:if test="${not empty task.dueDate}">
                                <%-- 1. Extract Day, Month, and Year from the task date --%>
                                <fmt:formatDate value="${task.dueDate}" pattern="d" var="tDay" />
                                <fmt:formatDate value="${task.dueDate}" pattern="M" var="tMonth" />
                                <fmt:formatDate value="${task.dueDate}" pattern="yyyy" var="tYear" />

                                <%-- 2. Compare all three parts to the current calendar view --%>
                                <c:if test="${tDay == day && tMonth == currentMonth && tYear == currentYear}">
                                    <div class="task-badge" title="${task.description}">
                                        ${task.title}
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        </td>

                        <%-- 4. Row Wrapping: Break row after Saturday --%>
                        <c:if test="${(status.index + startDay) % 7 == 0 && day != daysInMonth}">
                            </tr><tr>
                        </c:if>
                    </c:forEach>
                </tr>
            </tbody>
        </table>
    </section>
</div>