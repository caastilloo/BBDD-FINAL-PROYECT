# 🏕️ Queenswood Summer Camp — SQL Server Database Project
 
Relational database project for managing a summer camp for teenagers aged 12–16. Designed and implemented in SQL Server, it covers the full database lifecycle: entity-relationship modelling, relational schema, table creation, business logic through triggers, and reporting through stored procedures.
 
---
 
## 📁 Repository Structure
 
```
├── DOCS/
│   ├── QUEENSWOOD SUMMER CAMP.pdf            # Project specification
│   └── DATABASE DESIGN PHASE/
│       ├── [DIA] DIAGRAMA ER.dia             # Editable ER diagram (DIA format)
│       ├── [IMG] ER DIAGRAM.png              # Entity-relationship diagram
│       ├── [IMG] Relational Model.png        # Derived relational schema
│       ├── [IMG] SQL DIAGRAM.png             # SQL Server database diagram
│       └── [PDF] ER DIAGRAM.pdf              # ER diagram in PDF format
│
└── SCRIPTS SQL/
    ├── SETUP/
    │   ├── [SCRIPT] TABLES GENERATOR.sql     # Table creation with constraints
    │   └── [SCRIPT] DATA GENERATOR.sql       # Sample data for testing
    ├── TRIGGERS/
    │   ├── [TRIG1] ASSIGN CABIN.sql
    │   ├── [TRIG2] UPDATE EMPLOYEE ACTIVITY.sql
    │   ├── [TRIG3] UPDATE BONUS TUTOR.sql
    │   └── [TRIG4] APPLY ACTIVITY.sql
    └── PROCEDURES/
        ├── [PROC1] LIST MEDICAL RECORDS.sql
        ├── [PROC2] ACTIVITIES TYPE.sql
        ├── [PROC3] CABIN CHILDREN.sql
        └── [PROC4] EMPLOYEES SALARY.sql
```
 
---
 
## 🗄️ Database Overview
 
The database manages the following entities:
 
| Entity | Description |
|---|---|
| `EMPLOYEE` | Camp staff with position, salary and bonus tracking |
| `CABIN` | Cabins by gender with an assigned tutor |
| `CHILD` | Enrolled campers, automatically assigned to a cabin |
| `PARENT` | Parents or guardians linked to each child |
| `MEDICAL_ISSUE` | Medical records per child |
| `ACTIVITY` | Physical and recreational activities with schedule and capacity |
| `REGISTER` | Enrolment of children in activities |
| `IN_CHARGE` | Coaches assigned to each activity |
 
---
 
## ⚡ Triggers
 
| Trigger | Event | Description |
|---|---|---|
| `ASSIGN_CABIN` | `INSERT` on CHILD | Automatically assigns the child to an available cabin matching their gender. Rolls back if no cabin is available. |
| `UPDATE_EMPLOYEE_ACTIVITY` | `INSERT` on ACTIVITY | Assigns two available coaches to the new activity, avoiding schedule conflicts. Updates their activity bonus and reassigns cabin tutors based on workload. |
| `UPDATE_BONUS_TUTOR` | `UPDATE` on CABIN | Recalculates the tutor bonus (40€ per cabin) for both the new and the previous tutor whenever a cabin's tutor changes. |
| `APPLY_ACTIVITY` | `INSERT` on REGISTER | Validates enrolment: checks available spots, schedule conflicts, and the 4-activity limit per child. Rolls back with a descriptive message if any check fails. |
 
---
 
## 📋 Stored Procedures
 
| Procedure | Description |
|---|---|
| `LIST_MEDICAL_RECORDS` | Lists all children who have medical records, with their issues, medication and special needs. |
| `ACTIVITIES_TYPE` `@type` | Lists all activities of the given type (`Physical` / `Recreational`), including assigned coaches and enrolled children with their parents. |
| `CABIN_CHILDREN` `@type` | Lists all cabins of the given gender type (`M` / `F`) with their assigned children and the activities each child is enrolled in. |
| `EMPLOYEES_SALARY` | Displays all employees with their position, salary, activity bonus and tutor bonus. |
 
---
 
## 🚀 How to Run
 
1. Open **SQL Server Management Studio 22** and connect to your instance.
2. Create the database manually or let the setup script handle it:
   ```sql
   CREATE DATABASE QUEENSWOOD_SUMMER_CAMP;
   ```
3. Run `SETUP/[SCRIPT] TABLES GENERATOR.sql` to create all tables and constraints.
4. Run the scripts in `TRIGGERS/` and `PROCEDURES/` in any order to create all objects.
5. Run `SETUP/[SCRIPT] DATA GENERATOR.sql` to populate the database with sample data.
6. Test the procedures:
   ```sql
   EXEC LIST_MEDICAL_RECORDS
   EXEC ACTIVITIES_TYPE 'Physical'
   EXEC ACTIVITIES_TYPE 'Recreational'
   EXEC CABIN_CHILDREN 'F'
   EXEC CABIN_CHILDREN 'M'
   EXEC EMPLOYEES_SALARY
   ```
 
> To test trigger rollbacks, uncomment the corresponding test cases at the bottom of `[SCRIPT] DATA GENERATOR.sql`.
 
---
 
## 🛠️ Built With
 
- **SQL Server Management Studio 22**
- **DIA** — ER diagram design
