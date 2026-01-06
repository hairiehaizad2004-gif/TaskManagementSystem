/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.model;

/**
 *
 * @author VICTUS
 */
package com.taskmanagement.model;

public class Task {
    private String taskId;
    private String title;
    private String category; // To differentiate 'Individual' vs 'Group'
    private String priority;
    
    // Constructor
    public Task(String title, String category, String priority) {
        this.title = title;
        this.category = category;
        this.priority = priority;
    }

    // Getters - These allow the JSP to read the data
    public String getTitle() { return title; }
    public String getCategory() { return category; }
    public String getPriority() { return priority; }
}