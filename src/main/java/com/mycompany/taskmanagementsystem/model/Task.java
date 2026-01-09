/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.model;
import java.sql.Date;
/**
 *
 * @author VICTUS Zulhairie
 */
public class Task {
    private int id;
    private String title;
    private String description;
    private String status;
    private String priority;
    private String category;
    private Date taskDate;
    
    // Constructors
    public Task() {}
    
    public Task(int id, String title, String description, String status, String priority, String category, Date taskDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status;
        this.priority = priority;
        this.category = category;
        this.taskDate = taskDate;
    }
    // Getters and Setters
    // --- ID ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

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

    // --- Task Date ---
    public Date getTaskDate() { return taskDate; }
    public void setTaskDate(Date taskDate) { this.taskDate = taskDate; }
}