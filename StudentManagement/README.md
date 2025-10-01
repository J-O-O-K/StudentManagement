# Student Management — EF Code-First (Change-Based Migrations)

## Overview

This branch demonstrates the **change-based migration strategy** using Entity Framework Core (Code-First) in a .NET console application.
Each schema change is implemented incrementally as a new branch and migration, with an accompanying SQL artifact (`Migrations/Sql/V#__Description.sql`).

This approach gives us a **traceable history** of how the schema evolves over time, and makes it easy to reproduce or roll back changes.

---

## Initial Setup

* Project type: .NET 8 Console App
* Packages:

  * `Microsoft.EntityFrameworkCore.SqlServer`
  * `Microsoft.EntityFrameworkCore.Tools`
* Layers:

  * `Domain/Models` → entity classes
  * `Infrastructure/Data` → `StudentContext` DbContext
* Database: SQL Server LocalDB

---

## Migration History

### V1 — Initial Schema

**Entities:**

* Student (Id, FirstName, LastName, Email, EnrollmentDate)
* Course (Id, Title, Credits)
* Enrollment (Id, StudentId, CourseId, Grade)

**Approach:** Non-destructive — tables created fresh.
**Artifact:** `Migrations/Sql/V1__InitialSchema.sql`

---

### V2 — Add MiddleName to Student

**Change:** Added `MiddleName` column (nullable).
**Approach:** Non-destructive — added a nullable column so existing rows remain valid.
**Artifact:** `Migrations/Sql/V2__AddMiddleName.sql`

---

### V3 — Add DateOfBirth to Student

**Change:** Added `DateOfBirth` column (non-nullable).
**Approach:** Non-destructive — EF generated the column with a default (`0001-01-01`) so existing rows are preserved.
**Artifact:** `Migrations/Sql/V3__AddDateOfBirth.sql`

---

### V4 — Add Instructor relation

**Change:** New `Instructor` table + `InstructorId` foreign key in `Course`.
**Approach:** Non-destructive — added a new table and FK.
**Artifact:** `Migrations/Sql/V4__AddInstructor.sql`

---

### V5 — Rename Grade → FinalGrade

**Change:** `Grade` column in `Enrollment` renamed to `FinalGrade`.
**Approach:** Non-destructive — EF generated `RenameColumn` (SQL Server `sp_rename`), preserving existing data.
**Artifact:** `Migrations/Sql/V5__RenameGrade.sql`

---

### V6 — Add Department relation

**Change:** New `Department` table with attributes (Id, Name, Budget, StartDate) and optional FK `DepartmentHeadId` → `Instructor`.
**Approach:** Non-destructive — new table and nullable FK added.
**Artifact:** `Migrations/Sql/V6__AddDepartment.sql`

---

### V7 — Modify Course Credits type

**Change:** `Credits` changed from `int` to `decimal(5,2)`.
**Approach:** EF warned about possible data loss, but this was **non-destructive** in practice — SQL Server safely widened integers to decimals using `ALTER COLUMN`.
**Artifact:** `Migrations/Sql/V7__ModifyCourseCredits.sql`