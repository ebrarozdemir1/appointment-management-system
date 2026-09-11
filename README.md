# Appointment Management System

## Overview

Appointment Management System is a Java-based desktop application designed to manage patient appointments in a simple and organized way.

The application provides separate interfaces for users and doctors, allowing patients to log in, view available doctors and departments, and create appointments. The system uses Microsoft SQL Server for storing and managing application data.

## Features

- Patient login
- Doctor login
- Patient registration and account management
- Doctor and department management
- Appointment creation
- Appointment listing
- Appointment status management
- SQL Server database integration
- Graphical desktop user interface
- Form-based user interaction

## Application Structure

The application consists of several main components:

### Login Form

The login interface allows users to access the system using their account information.

### Patient Panel

The patient panel provides functionality for patients to interact with the appointment system and manage their appointments.

### Appointment Form

The appointment form allows patients to select available doctors, departments, dates and times when creating an appointment.

### Database Connection

The `DBConnection.java` class is responsible for establishing a connection between the Java application and the Microsoft SQL Server database.

Database credentials are read from environment variables rather than being stored directly in the source code.

## Database Design

The project uses Microsoft SQL Server and contains four main tables:

```text
Department (Bolum)
      |
      v
   Doctor (Doktor)
      |
      v
Appointment (Randevu)
      ^
      |
Patient (Hasta)
```

### Main Tables

- `Bolum` — stores department information.
- `Doktor` — stores doctor information and department relationships.
- `Hasta` — stores patient information.
- `Randevu` — stores appointment information and relationships between patients and doctors.

Foreign key relationships are used to connect doctors with departments and appointments with patients and doctors.

The repository includes `RandevuDB.sql`, which contains the database schema and fictional demo data for development and testing purposes.

## Technologies

- Java
- Microsoft SQL Server
- JDBC
- NetBeans
- Java Swing
- SQL

## Project Structure

```text
appointment-management-system/
├── DBConnection.java
├── HastaPanel.form
├── HastaPanel.java
├── LoginForm.form
├── LoginForm.java
├── RandevuAlForm.form
├── RandevuAlForm.java
├── RandevuSistemi.java
├── RandevuDB.sql
├── build.xml
├── manifest.mf
├── .gitignore
└── README.md
```

## How It Works

1. The application starts from the main Java class.
2. Users access the system through the login interface.
3. The application establishes a connection to the SQL Server database using JDBC.
4. Patients can access the patient panel.
5. Available departments and doctors can be viewed through the application.
6. Patients can create appointments by selecting the required information.
7. Appointment information is stored in the SQL Server database.
8. Existing appointment information can be retrieved and managed through the application.

## Database Configuration

The application connects to a local Microsoft SQL Server instance.

The database connection uses the following environment variables:

`DB_USER`

`DB_PASSWORD`

These variables should be configured locally before running the application.

Example:

```text
DB_USER=your_database_username
DB_PASSWORD=your_database_password
```

Database credentials should never be committed directly to the repository.

## Running the Project

### 1. Set Up the Database

Open Microsoft SQL Server and execute:

`RandevuDB.sql`

The script creates the required database structure and inserts fictional demo data.

### 2. Configure Database Credentials

Set the following environment variables on your local machine:

`DB_USER`

`DB_PASSWORD`

### 3. Open the Project

Open the project using NetBeans or another compatible Java development environment.

### 4. Run the Application

Run:

`RandevuSistemi.java`

The application will open the login interface.

## Security

Database credentials are not stored directly in the source code.

The project uses environment variables to keep database authentication information outside the repository.

The database script contains fictional demo records only and does not contain real patient or doctor information.

## Learning Outcomes

This project provided practical experience with:

- Java desktop application development
- Object-oriented programming
- Java Swing interfaces
- JDBC database connectivity
- Microsoft SQL Server
- Relational database design
- SQL queries
- Foreign key relationships
- Form-based application development
- Basic application security practices

## Author

**Ebrar Özdemir**

Computer Engineering Student  
Sakarya University of Applied Sciences

GitHub: [github.com/ebrarozdemir1](https://github.com/ebrarozdemir1)
