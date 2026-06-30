**Healthcare Data Warehouse Using CSV Data**

A PostgreSQL data warehouse built from Synthea synthetic patient CSV data. The project implements a full ELT pipeline — raw ingestion, staging and cleansing, dimensional warehousing with SCD Type 2 history tracking, and an analytics layer of SQL queries demonstrating window functions, recursive CTEs, set operations, and cohort analysis.

**Architecture**

The pipeline follows a four layer design, each layer living in its own folder and numbered in execution order

01_raw   - Raw ingestion schema creation raw table DDL CSV loads copy row counts
02_staging   - Staging typed tables data cleansing duplicate referential integrity date checks
03_warehousing   - Warehouse dimension and fact tables SCD2 merge logic indexes
04_analytics   - Analytics window functions recursive CTEs cohort analysis ad hoc reports

**1 Raw layer**

Creates the raw staging and warehouse schemas defines raw tables all columns as TEXT to preserve source fidelity and loads each Synthea CSV file patients encounters conditions medications procedures observations immunizations allergies careplans devices imaging studies supplies organizations providers payers payer transitions via copy

**2 Staging layer**

Casts raw TEXT columns into proper types dates numerics varchars and runs data quality checks row count reconciliation against raw duplicate detection referential integrity date sanity checks and negative number checks

**3 Warehouse layer**

Builds the dimensional model

Dimension tables for example dim_patients tracked with Slowly Changing Dimension Type 2 effective_date expiry_date is_current and a record_hash to detect changes on each load

Fact tables fct_encounters fct_conditions fct_medications linked to dimensions via surrogate keys

Indexes for query performance and a daily feed SCD2 merge process for incremental loads

**4 Analytics layer**

SQL examples organized by technique

Window Functions first encounter per patient ranking conditions running totals day gap analysis LAG patient quartiles rolling averages

Recursive CTEs and Set Operations condition grouping annotation INTERSECT of metabolic cardiovascular conditions encounters with no conditions UNION ALL event timelines

Cohort Analysis medication based patient cohorts adherence calculations

Ad hoc reports 2021 medication patients average cost by drug class and city patient summaries condition changes by city

**Tech Stack**

Database PostgreSQL
Data source Synthea synthetic patient records CSV
Tooling psql copy for bulk loads

**Prerequisites**

PostgreSQL tested on PostgreSQL 13 plus
psql command line client
Synthea generated CSV files patients encounters conditions medications procedures observations immunizations allergies careplans devices imagingstudies supplies organizations providers payers payer_transitions

**Setup**

1 Generate or obtain Synthea CSV data and note the folder path
2 Update CSV file paths in 01_raw loading csv sql each copy statement points to a local path and will need updating to match your environment
3 Run the scripts in order layer by layer

**Example**

psql -d your_database -f 01_raw 00_create_schema sql
psql -d your_database -f 01_raw 01_creating_raw_tables sql
psql -d your_database -f 01_raw 02_loading_allergies_csv sql

Continue through each folder in numeric order

Alternatively run an entire folder in order with a loop
for f in 01_raw/*.sql do psql -d your_database -f "$f" done

**Project Structure**

01_raw   Schema and raw table creation CSV loads
02_staging   Typed staging tables data quality checks
03_warehousing   Dimensional model dims facts SCD2 indexes
04_analytics   Window functions recursive CTEs cohort analysis ad hoc reports

**Notes**

Raw tables store all fields as TEXT to keep ingestion resilient to source formatting issues type casting happens in the staging layer
The SCD2 merge includes a synthetic daily feed simulation random city marital status mutations to demonstrate and test change detection remove this in production
CSV encoding is set to WIN1252 to match common Synthea export defaults adjust if your source files use a different encoding
