# 🦷 Monash New Smile – SQL Database Implementation & Manipulation 

This project demonstrates hands-on SQL development and transaction control using Oracle for a dental clinic system called **Monash New Smile (MNS)**. 
Developed as part of **Introduction to Databases**, it focuses on schema design, sample data population, advanced DML operations, schema modifications, and transaction theory.

---

## 📋 Assignment Objectives

- ✅ Apply relational database principles using SQL
- ✅ Implement normalized tables with correct constraints
- ✅ Populate tables with sample data and enforce real-world logic
- ✅ Execute advanced DML queries and schema alterations
- ✅ Analyze transaction management and concurrency

---

## 🧠 Case Study: Monash New Smile (MNS)

Monash New Smile is a dental care provider. This database supports:
- Patient and emergency contact tracking
- Appointment scheduling
- Provider, nurse, and service management
- Service-item mapping and room usage
- Follow-up visit relationships
- Transaction control for live updates

---

## 🛠 Deliverables

| File | Description |
|------|-------------|
| `T1-mns-schema.sql` | DDL to create missing tables and constraints (EMERGENCY_CONTACT, PATIENT, APPOINTMENT) |
| `T2-mns-insert.sql` | INSERT statements for 5 contacts, 10 patients, 15 appointments (parallel, follow-up cases) |
| `T3-mns-dm.sql` | Advanced DML: insert, update, delete with transaction control |
| `T4-mns-alter.sql` | Schema modifications for business logic enhancements (multi-contact, training tracking) |
| `T5-mns-transaction.pdf` | Theory questions on checkpoint recovery, locking, and deadlocks |

---

## 🧪 Key Features Implemented

### 🛠 DDL & Constraints
- Hand-coded `CREATE TABLE` and `ALTER TABLE`
- PK, FK, and CHECK constraints
- Data types, default values, column comments

### 🧾 Data Insertion
- Emergency contacts reused across multiple patients
- Parallel appointments and multiple providers/nurses
- Follow-up visit links via FK
- Hardcoded PKs (< 100) and real-world data simulation

### ✍️ DML Operations
- Insert appointments and adjust schedules
- Sequence creation and usage
- Cascade deletes, update propagation
- Doctor leave scenario with bulk deletion

### 🔄 Schema Alterations
- Add total appointments per patient (with population logic)
- Convert 1-to-1 to 1-to-many for emergency contacts
- Add nurse training relationship (self-referencing M:N)

### 🔐 Transaction & Locking Analysis
- SQL-level concurrency simulation
- Wait-for graph and deadlock detection
- Checkpoint & crash recovery walkthrough

---

## ⚙️ Technologies Used

- Oracle RDBMS
- SQL*Plus / Oracle SQL Developer
- Git (Monash FIT GitLab)
- Lucidchart (for wait-for graph)
- MS Word or Google Docs (for theory write-up)

---

## 🧠 Learning Outcomes Demonstrated

- Schema design and normalization into 3NF
- SQL DDL/DML mastery including transactions
- Concurrency and isolation behavior analysis
- Effective data modeling from real-world requirements
- Script modularity and maintainability

---


