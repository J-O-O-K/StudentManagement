-- V3: Schema with DateOfBirth added to Students

IF DB_ID('StudentManagementState') IS NULL CREATE DATABASE StudentManagementState;
GO
USE StudentManagementState;
GO

-- Dropping existing tables
IF OBJECT_ID('dbo.Enrollments','U') IS NOT NULL DROP TABLE dbo.Enrollments;
IF OBJECT_ID('dbo.Courses','U')     IS NOT NULL DROP TABLE dbo.Courses;
IF OBJECT_ID('dbo.Students','U')    IS NOT NULL DROP TABLE dbo.Students;
GO

CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    EnrollmentDate DATETIME2 NOT NULL,
    DateOfBirth DATE NOT NULL          -- NEW in V3
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
