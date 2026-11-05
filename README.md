# dbForge Studio for SQL Server – Practical Demos

This repository contains the SQL scripts and sample datasets accompanying my video:

**I Tried an AI Assistant with SQL Server — Here's What Happened**

In this video, I explore dbForge Studio for SQL Server through practical demonstrations using a custom SQL Server sales database.

Rather than relying entirely on pre-built sample databases, the examples use our own Customers, Products, Orders, and Sales tables to demonstrate real-world SQL development workflows.

## What's Covered

- AI-assisted SQL development and debugging
- JOIN autocomplete and IntelliSense
- SELECT * column expansion
- CTE and alias IntelliSense
- Inline table metadata
- Visual Query Builder
- SQL formatting
- T-SQL Code Analyzer
- Data Generator
- T-SQL Debugger
- Query History
- Data Compare
- Pivot Tables
- Charts and data visualization
- Master-Detail Browser
- Data Reporting

## SQL Scripts

All SQL scripts are available below.

| File | Description |
|---|---|
| [01_Create_Sales_Database.sql](https://github.com/learnknowstar-cpu/dbForge-Studio-SQL-Server-Demo/blob/main/01_Create_Sales_Database.sql) | Creates the sales database tables, relationships, and sample data |
| [02_AI_Assistant_Debugging.sql](https://github.com/learnknowstar-cpu/dbForge-Studio-SQL-Server-Demo/blob/main/02_AI_Assistant_Debugging.sql) | Duplicate-key error investigation and source-to-target grain mismatch |
| [03_AI_SQL_Generation.sql](https://github.com/learnknowstar-cpu/dbForge-Studio-SQL-Server-Demo/blob/main/03_AI_SQL_Generation.sql) | Natural-language SQL generation example |
| [04_SQL_Development_Demos.sql](https://github.com/learnknowstar-cpu/dbForge-Studio-SQL-Server-Demo/blob/main/04_SQL_Development_Demos.sql) | JOIN autocomplete, IntelliSense, Query Builder, formatting, Code Analyzer, and Query History |
| [05_Debugging_and_Data_Generator.sql](https://github.com/learnknowstar-cpu/dbForge-Studio-SQL-Server-Demo/blob/main/05_Debugging_and_Data_Generator.sql) | T-SQL Debugger and Data Generator |
| [06_Data_Compare_Demo.sql](https://github.com/learnknowstar-cpu/dbForge-Studio-SQL-Server-Demo/blob/main/06_Data_Compare_Demo.sql) | Production vs. staging data comparison |
| [07_Data_Analysis_and_Reporting.sql](https://github.com/learnknowstar-cpu/dbForge-Studio-SQL-Server-Demo/blob/main/07_Data_Analysis_and_Reporting.sql) | Pivot Tables, Charts, Master-Detail Browser, and Reporting |

## Getting Started

### Requirements

- Microsoft SQL Server
- dbForge Studio for SQL Server

### Setup Instructions

1. Clone or download this repository.
2. Connect to your SQL Server instance.
3. Create a dedicated demo database.
4. Run `01_Create_Sales_Database.sql` to create the tables and populate the sample data.
5. Execute the individual SQL scripts to explore the demonstrations.

Some demonstrations require interaction with the dbForge Studio interface in addition to executing SQL scripts. These include Data Generator, Query Builder, Data Compare, Pivot Tables, Charts, Master-Detail Browser, and Data Reporting.

## Important Notes

- The examples use fictional customers, products, orders, and sales transactions.
- The AI debugging example intentionally reproduces a duplicate-key error to demonstrate troubleshooting.
- The T-SQL Debugger example contains an intentional division-by-zero error.
- The Data Generator example creates an empty destination table for generating sample records through the dbForge interface.
- Data Compare is demonstrated using separate production and staging tables. No synchronization is performed.

Run the scripts in a dedicated demo database rather than a production environment.

## Video

**Watch the demonstration:** [I Tried an AI Assistant with SQL Server — Here's What Happened](https://www.youtube.com/)

## Acknowledgment

This repository accompanies a sponsored video created in collaboration with **Devart**, the developer of dbForge Studio for SQL Server.

Learn more about dbForge Studio for SQL Server: https://www.devart.com/dbforge/sql/studio/
