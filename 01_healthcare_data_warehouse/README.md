# 🏥 Healthcare Data Warehouse — Synthea Dataset

A production-style healthcare data warehouse built on the [Synthea](https://kaggle.com/datasets/paulbacher/synthea) synthetic patient dataset using PostgreSQL. This project demonstrates end-to-end data engineering — from raw CSV ingestion through to an analytics-ready warehouse — following real-world patterns used in clinical data infrastructure.

---

## 📁 Structure

```
01_raw/          → Schema creation, raw table DDL, CSV loading, row count verification
02_staging/      → Type casting, cleaning, data quality checks, referential integrity
03_warehousing/  → SCD Type 2 patient dimension, fact tables, SCD merge logic
04_analytics/    → Window functions, recursive CTEs, cohort analysis, set operations
```

---

## ⚙️ Tech Stack

`PostgreSQL` · `SQL` · `pgAdmin`

---

## ✅ What This Demonstrates

- **Three-layer pipeline** — raw → staging → warehouse with clear separation of concerns
- **SCD Type 2** — full patient history tracking with record hashing, effective/expiry dates, and a transactional merge pattern
- **Data quality** — duplicate checks, referential integrity validation, date and negative value checks across all domains
- **Fact tables** — encounters, conditions, and medications joined to the dimension via point-in-time logic
- **Advanced SQL** — window functions (ROW_NUMBER, LAG, NTILE, rolling averages), recursive CTEs, INTERSECT/EXCEPT/UNION ALL, cohort retention analysis

---

## 🔧 How to Run

1. Install PostgreSQL and pgAdmin
2. Run scripts in numbered order within each folder — start with `01_raw/`
3. For data loading, run from psql and pass your local data path:

```bash
psql -U postgres -d healthcare_dw \
  -v data_path="'/your/local/path/to/data'" \
  -f 01_raw/03_loading_data.sql
```

> ⚠️ This project uses the Synthea synthetic dataset. No real patient data is used or stored. Download the dataset from [Kaggle](https://kaggle.com/datasets/paulbacher/synthea).

---

## 🚀 What Could Be Improved

- **Orchestration** — pipeline steps are currently run manually; Airflow DAGs would automate and schedule each layer
- **Containerisation** — Docker would make the environment fully reproducible across machines
- **Infrastructure as code** — Terraform could provision schemas, roles, and permissions automatically
- **dbt** — transformation logic in `02_staging` and `03_warehousing` would benefit from dbt models with built-in testing and lineage
- **Additional dimensions** — `dim_providers`, `dim_payers`, and `dim_organizations` would complete the dimensional model
- **FHIR ingestion** — the next iteration of this project ingests the same clinical data in FHIR R4 format via a Python pipeline

---

## 👤 Author

**Lewis Ngugi Maina**
[![LinkedIn](https://img.shields.io/badge/LinkedIn-lewisngugi-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/lewisngugi)
[![GitHub](https://img.shields.io/badge/GitHub-gustofring22-181717?style=flat&logo=github)](https://github.com/gustofring22)
