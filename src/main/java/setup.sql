/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  VICTUS
 * Created: 6 Jan 2026
 */

-- Java DB (Derby) Syntax
CREATE TABLE tasks (
    task_id VARCHAR(50) NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(50),
    priority VARCHAR(20)
);

