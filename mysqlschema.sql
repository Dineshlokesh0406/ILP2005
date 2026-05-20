CREATE DATABASE IF NOT EXISTS lms_db;

USE lms_db;

DROP TABLE IF EXISTS learning;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE learning (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    link VARCHAR(500)
);

INSERT INTO users (name, email, password, role)
VALUES ('Admin', 'admin@lms.com', 'admin123', 'admin');

INSERT INTO learning (title, description, link)
VALUES
('Java Basics', 'Introduction to Java programming language.', 'https://docs.oracle.com/javase/tutorial/'),
('JSP and Servlets', 'Learn how JSP and Servlets work in a dynamic web project.', 'https://tomcat.apache.org/tomcat-9.0-doc/'),
('MySQL Basics', 'Basic database concepts and SQL queries for beginners.', 'https://dev.mysql.com/doc/');
