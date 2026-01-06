/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.taskmanagementsystem.model;

/**
 *
 * @author VICTUS
 */
public class Task {
    private String taskId;
    private String title;
    private String category; // To differentiate 'Individual' vs 'Group'
    private String priority;
    
    // Default Constructor
    public Task() {
    }

    // Getters - These allow the JSP to read the data
    public String getTitle() { return title; }
    public String getCategory() { return category; }
    public String getPriority() { return priority; }
    
    public void setTitle(String title) {
        this.title = title;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }
}