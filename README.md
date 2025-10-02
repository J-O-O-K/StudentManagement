# Student Management — Database Schema Migrations

## Overview

This repository contains the compulsory assignment for **Database Schema Migrations**.
The goal is to design and evolve a **Student Management** database schema while demonstrating two different migration strategies:

1. **Change-Based (Entity Framework Core / Code-First)**
2. **State-Based (Schema Diff)**

Both approaches are version-controlled and use **feature branches** to show incremental schema changes.

---

## Branches

### EF Code-First (Change-Based Migrations)

Implemented using Entity Framework Core with incremental migrations and generated SQL artifacts.
[View the EF branch here](https://github.com/J-O-O-K/StudentManagement/blob/feat/modify-course-credits-ef/StudentManagement/README.md)

### State-Based (Schema Diff)

Implemented using manually maintained SQL scripts that describe the target schema at each version.
[View the State-Based branch here](https://github.com/J-O-O-K/StudentManagement/blob/feat/modify-credits-state/StudentManagement/README.md)

---

## Notes

* Both approaches evolve the schema through the same sequence of changes (V1–V7).
* Each branch contains its own **README.md**.
* State based branch doesn't use a migration tool to compare the database state with the new schema. Instead, every version is applied destructively (drop and recreate). In real-world practice, a state-based tool would generate non-destructive ALTER scripts to preserve data.
