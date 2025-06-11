# 🧪 Clinical Trial Database Simulation

This project simulates a clinical trial database using PostgreSQL. It includes a realistic data model, mock data for patients, visits, test results, medications, and adverse events. It's designed to demonstrate my SQL and database development skills for an **Associate Database Developer** position.

---

## 🧠 Description

The database replicates the essential components of an Electronic Data Capture (EDC) system in clinical trials. It simulates the following:

- Patient demographics and enrollment
- Clinical visits and test results
- Medication administration
- Adverse event tracking

The data was generated using [Mockaroo](https://mockaroo.com) to reflect realistic clinical scenarios.

---

## 🏗 Schema Overview

| Table            | Description                                |
|------------------|--------------------------------------------|
| `patients`       | Basic demographic and enrollment data      |
| `visits`         | Records of patient visits                  |
| `test_results`   | Lab test results per visit                 |
| `medications`    | Medications prescribed/administered        |
| `adverse_events` | Reported adverse events during the trial   |

---

## 📂 Project Structure

clinical-trial-db-demo/

├── schema.sql # Creates all tables

├── insert_sample_data.sql # Populates all tables with mock data

├── sample_queries.sql # Example queries (joins, aggregates, filters)

├── README.md # This file


---


---

## 🧪 Technologies Used

- PostgreSQL
- pgAdmin
- PyCharm
- Mockaroo (data generation)
- Git / GitHub

---

## 🧠 Example SQL Queries

```sql
-- Patients who experienced more than 2 adverse events
SELECT p.patient_id, p.first_name, p.last_name, COUNT(*) AS event_count
FROM patients p
JOIN adverse_events ae ON p.patient_id = ae.patient_id
GROUP BY p.patient_id
HAVING COUNT(*) > 2;

-- Average Hemoglobin test result per patient
SELECT patient_id, ROUND(AVG(test_result), 2) AS avg_hemoglobin
FROM test_results
WHERE test_name = 'Hemoglobin'
GROUP BY patient_id;

-- Medications currently being taken (no end date)
SELECT * FROM medications
WHERE end_date IS NULL;

```

## 🚀 Future Improvements
- Add stored procedures and data validation rules
- Include views for easier analysis
- Add unit test examples using Python or pgTAP

## 📫 Contact
Feel free to connect with me:
- GitHub: MishaAleksandrova
- LinkedIn: https://www.linkedin.com/in/mihaela-aleksandrova-856965363/

