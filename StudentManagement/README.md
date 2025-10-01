# Student Management — State-Based Migrations

## Overview

This branch demonstrates the **state-based migration strategy** for evolving the Student Management database schema.
Each migration is represented as a **versioned SQL artifact** (`state-based/V#__Description.sql`) that describes the **entire desired schema at that version**.

Unlike the EF Code-First (change-based) approach, here we:

* Write SQL scripts manually (or maintain them in a tool).
* Focus on **final state snapshots** rather than incremental changes.
* Use simple drop-and-recreate scripts, as no data is affected.

---

## How to Apply

1. Open the `.sql` file for the version you want in **SSMS**.
2. Each file is **self-contained**:

   * It creates the database if missing.
   * It switches into the correct database (`USE StudentManagementState`).
   * It recreates all tables for that version.

---

## Migration History

### V1 — Initial Schema

**Entities:**

* Student (Id, FirstName, LastName, Email, EnrollmentDate)
* Course (Id, Title, Credits)
* Enrollment (Id, StudentId, CourseId, Grade)

**Approach:** Fresh schema creation.
**Artifact:** `V1__InitialSchema.sql`

---

### V2 — Add MiddleName to Student

**Change:** Added `MiddleName` column.
**Approach:** Destructive (drop & recreate Students).
**Artifact:** `V2__AddMiddleName.sql`

---

### V3 — Add DateOfBirth to Student

**Change:** Added `DateOfBirth` column.
**Approach:** Destructive (drop & recreate Students).
**Artifact:** `V3__AddDateOfBirth.sql`

---

### V4 — Add Instructor relation

**Change:** Created `Instructors` table + `InstructorId` in `Courses`.
**Approach:** Destructive (drop & recreate schema).
**Artifact:** `V4__AddInstructor.sql`

---

### V5 — Rename Grade → FinalGrade

**Change:** Renamed `Grade` column to `FinalGrade` in `Enrollments`.
**Approach:** Destructive (drop & recreate Enrollments).
**Note:** In production, schema diff tools would generate a **non-destructive `sp_rename`**. Destructive approach was used since there's no data.
**Artifact:** `V5__RenameGradeToFinalGrade.sql`

---

### V6 — Add Department relation

**Change:** Added `Departments` table with `DepartmentHeadId` FK → `Instructors`.
**Approach:** Destructive (drop & recreate schema).
**Artifact:** `V6__AddDepartment.sql`

---

### V7 — Modify Course.Credits type

**Change:** Changed `Credits` from INT → DECIMAL(5,2).
**Approach:** Destructive (drop & recreate Courses).
**Note:** In production, schema diff tools would generate a **non-destructive `ALTER TABLE … ALTER COLUMN`**. Again, destructive approach was used since there's no data.
**Artifact:** `V7__ModifyCourseCredits.sql`

---