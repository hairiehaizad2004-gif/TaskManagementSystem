<%-- 
    Document   : dashboard
    Created on : 6 Jan 2026, 10:15:56 pm
    Author     : VICTUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- Get System Date for "Today" Highlighting --%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="todayDay" value="${now}" pattern="d" />
<fmt:formatDate var="todayMonth" value="${now}" pattern="M" />
<fmt:formatDate var="todayYear" value="${now}" pattern="yyyy" />

<%-- Default values to prevent errors if variables are missing --%>
<c:if test="${empty startDay}"><c:set var="startDay" value="1" /></c:if>
<c:if test="${empty daysInMonth}"><c:set var="daysInMonth" value="30" /></c:if>

<jsp:include page="header.jsp" />

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

.main-container {
    display: flex;
    padding: 30px;
    gap: 25px;
    background-color: var(--bg-light);
    min-height: 100vh;
}

/* Side Panel Styling */
.current-task-panel {
    width: 320px;
    background: white;
    padding: 24px;
    border-radius: 16px;
    box-shadow: var(--card-shadow);
}

.task-item {
    background: #ffffff;
    padding: 12px;
    margin-bottom: 12px;
    border-radius: 10px;
    /* Default border; dynamic border set in inline style below */
    border-left: 5px solid var(--primary-purple);
    box-shadow: 0 2px 4px rgba(0,0,0,0.04);
}

/* Calendar Panel Styling */
.calendar-panel {
    flex: 1;
    background: white;
    padding: 25px;
    border-radius: 16px;
    box-shadow: var(--card-shadow);
}

.calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
}

th {
    text-transform: uppercase;
    font-size: 12px;
    letter-spacing: 1px;
    color: var(--text-muted);
    padding: 15px 0;
}

td {
    height: 110px;
    width: 14.28%;
    border: 0.5px solid #edf2f7;
    padding: 10px;
    vertical-align: top;
    transition: background 0.2s;
}

/* Today Highlighter Class */
.today-highlight {
    background-color: #f0f7ff !important;
    border: 2px solid var(--secondary-blue) !important;
}

.day-number {
    font-weight: 600;
    color: #4a5568;
    display: block;
    margin-bottom: 8px;
}

/* Calendar Task Badge Styling */
.task-badge {
    background-color: #8e8cd8; /* Matches the soft purple in your list */
    color: white;
    padding: 4px 8px;
    border-radius: 6px; /* Matching the rounded corners of your side cards */
    font-size: 0.75rem;
    margin-top: 4px;
    display: block;
    text-align: left;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* If you want to differentiate Group tasks like your list does */
.task-badge.group-task {
    background-color: #60a5fa; /* Matches the blue "sssss" task in your list */
}

.btn-row { display: flex; gap: 10px; margin-top: 20px; }
.btn { flex: 1; padding: 10px; border-radius: 8px; border: none; font-weight: bold; cursor: pointer; text-align: center; text-decoration: none; }
.btn-green { background: #27ae60; color: white; }
</style>

<div class="main-container">
    <aside class="current-task-panel">
        <h2 style="text-align: center;">Current Task</h2>

        <h3>Individual</h3>
        <div class="task-box">
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Individual'}">
                    <%-- Dynamic Border based on Priority --%>
                    <div class="task-item" style="border-left-color: ${task.priority == 'High' ? 'var(--priority-high)' : (task.priority == 'Medium' ? 'var(--priority-medium)' : 'var(--primary-purple)')};">
                        <strong>${task.title}</strong><br>
                        <small>Due: ${task.dueDate}</small>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <h3>Group</h3>
        <div class="task-box">
            <c:forEach var="task" items="${taskList}">
                <c:if test="${task.category == 'Group'}">
                    <div class="task-item" style="border-left-color: var(--secondary-blue);">
                        <strong>${task.title}</strong><br>
                        <small>Due: ${task.dueDate}</small>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="btn-row">
            <a href="addtask.jsp" class="btn btn-green">Add Task</a>
        </div>
    </aside>

    <section class="calendar-panel">
        <div class="calendar-header">
            <button onclick="location.href='dashboard?month=${currentMonth - 1}&year=${currentYear}'" style="padding: 5px 15px;">&lt;</button>
            <h3>${monthName} ${currentYear}</h3>
            <button onclick="location.href='dashboard?month=${currentMonth + 1}&year=${currentYear}'" style="padding: 5px 15px;">&gt;</button>
        </div>
        
        <table>
            <thead>
                <tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr>
            </thead>
            <tbody>
                <tr>
                    <c:if test="${startDay > 1}">
                        <c:forEach begin="1" end="${startDay - 1}">
                            <td style="background: #fdfdfd;"></td>
                        </c:forEach>
                    </c:if>

                    <c:forEach var="day" begin="1" end="${daysInMonth}" varStatus="status">
                        <%-- Dynamic Class for Today --%>
                        <td class="${(day == todayDay && currentMonth == todayMonth && currentYear == todayYear) ? 'today-highlight' : ''}">
                            <span class="day-number">${day}</span>
                            <c:forEach var="task" items="${taskList}">
                                <c:if test="${not empty task.dueDate}">
                                    <fmt:formatDate value="${task.dueDate}" pattern="d" var="tDay" />
                                    <fmt:formatDate value="${task.dueDate}" pattern="M" var="tMonth" />
                                    <fmt:formatDate value="${task.dueDate}" pattern="yyyy" var="tYear" />

                                    <c:if test="${tDay == day && tMonth == currentMonth && tYear == currentYear}">
                                        <%-- Dynamic Badge Color based on Category --%>
                                        <div class="task-badge" 
                                             style="background-color: ${task.category == 'Group' ? 'var(--secondary-blue)' : 'var(--primary-purple)'};"
                                             title="${task.description}">
                                            ${task.title}
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </td>

                        <c:if test="${(status.index + startDay) % 7 == 0 && day != daysInMonth}">
                            </tr><tr>
                        </c:if>
                    </c:forEach>
                </tr>
            </tbody>
        </table>
    </section>
</div>