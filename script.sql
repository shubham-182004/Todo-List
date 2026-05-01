-- Todo Management Application - Database Setup Script
-- Run this script in MySQL to create the required database and tables

CREATE DATABASE IF NOT EXISTS todo_management;
USE todo_management;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `username` varchar(250) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- FIX: Changed target_date from datetime(6) to date to match Java LocalDate usage
CREATE TABLE IF NOT EXISTS `todos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_done` bit(1) NOT NULL DEFAULT b'0',
  `target_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
