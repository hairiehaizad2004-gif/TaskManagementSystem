/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.model;

import java.sql.Date;

public class Task {
    private int taskId; // Renamed from id to taskId to match DAO
    private String title;
    private String description;
    private String status;
    private String priority;
    private String category;
    private java.sql.Date dueDate;
    
    // Constructors
    public Task() {}
    
    public Task(int taskId, String title, String description, String status, String priority, String category, Date dueDate) {
        this.taskId = taskId;
        this.title = title;
        this.description = description;
        this.status = status;
        this.priority = priority;
        this.category = category;
        this.dueDate = dueDate;
    }

    // --- Task ID (Matched to DAO) ---
    public int getTaskId() { return taskId; }
    public void setTaskId(int taskId) { this.taskId = taskId; }

    // --- Title ---
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    // --- Description ---
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    // --- Status ---
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // --- Priority ---
    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    // --- Category ---
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    // --- Due Date (Fixed Logic) ---
    public Date getDueDate() { return dueDate; }
    public void setDueDate(java.sql.Date dueDate) { this.dueDate = dueDate; }
}