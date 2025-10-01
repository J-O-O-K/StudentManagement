-- V1: Initial Schema

IF DB_ID('StudentManagementState') IS NULL CREATE DATABASE StudentManagementState;
GO
USE StudentManagementState;
GO


CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    EnrollmentDate DATETIME2 NOT NULL
);

CREATE TABLE Courses (
    Id INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(200) NOT NULL,
    Credits INT NOT NULL
);

CREATE TABLE Enrollments (
    Id INT PRIMARY KEY IDENTITY,
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    Grade NVARCHAR(10),
    FOREIGN KEY (StudentId) REFERENCES Students(Id),
    FOREIGN KEY (CourseId) REFERENCES Courses(Id)
);
