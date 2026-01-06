/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  VICTUS
 * Created: 6 Jan 2026
 */

CREATE DATABASE IF NOT EXISTS faculty_club_db;
USE faculty_club_db;

CREATE TABLE clients (
    client_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE tasks (
    task_id VARCHAR(50) PRIMARY KEY,
    client_id VARCHAR(50),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    due_date DATE,
    status VARCHAR(20), -- e.g., 'Pending', 'Completed'
    priority VARCHAR(20), -- e.g., 'High', 'Medium', 'Low'
    category VARCHAR(50),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

