-- V6: Schema with Departments and DepartmentHead (FK -> Instructors)

IF DB_ID('StudentManagementState') IS NULL CREATE DATABASE StudentManagementState;
GO
USE StudentManagementState;
GO

-- Optional replace mode (drop & recreate; destructive)
IF OBJECT_ID('dbo.Enrollments','U')   IS NOT NULL DROP TABLE dbo.Enrollments;
IF OBJECT_ID('dbo.Courses','U')       IS NOT NULL DROP TABLE dbo.Courses;
IF OBJECT_ID('dbo.Instructors','U')   IS NOT NULL DROP TABLE dbo.Instructors;
IF OBJECT_ID('dbo.Students','U')      IS NOT NULL DROP TABLE dbo.Students;
IF OBJECT_ID('dbo.Departments','U')   IS NOT NULL DROP TABLE dbo.Departments;
GO

CREATE TABLE Students (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    EnrollmentDate DATETIME2 NOT NULL,
    DateOfBirth DATE NOT NULL
);

CREATE TABLE Instructors (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    HireDate DATETIME2 NOT NULL
);

CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Budget DECIMAL(18,2) NOT NULL,
    StartDate DATETIME2 NOT NULL,
    DepartmentHeadId INT NULL, -- must be an Instructor
    CONSTRAINT FK_Departments_Instructors_DepartmentHeadId
        FOREIGN KEY (DepartmentHeadId) REFERENCES Instructors(Id)
);

CREATE TABLE Courses (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Credits INT NOT NULL,
    InstructorId INT NULL,
    CONSTRAINT FK_Courses_Instructors_InstructorId
        FOREIGN KEY (InstructorId) REFERENCES Instructors(Id)
);

CREATE TABLE Enrollments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    FinalGrade NVARCHAR(10) NULL,
    CONSTRAINT FK_Enrollments_Students_StudentId
        FOREIGN KEY (StudentId) REFERENCES Students(Id),
    CONSTRAINT FK_Enrollments_Courses_CourseId
        FOREIGN KEY (CourseId)  REFERENCES Courses(Id)
);
