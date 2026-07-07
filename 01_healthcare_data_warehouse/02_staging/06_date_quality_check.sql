-- Validate date quality in staging.
SELECT * FROM (

WITH patient_bad_dates AS (
    SELECT 
        'patients' AS table_name, 
        COUNT(*) AS bad_date_count
    FROM staging.patients
    WHERE birthdate > deathdate 
    OR birthdate > CURRENT_DATE
),
encounter_bad_dates AS (
    SELECT 
        'encounters' AS table_name, 
        COUNT(*) AS bad_date_count
    FROM staging.encounters
    WHERE start > stop
),
careplans_bad_dates AS (
    SELECT 
        'careplans' AS table_name, 
        COUNT(*) AS bad_date_count
    FROM staging.careplans
    WHERE start > stop
),
conditions_bad_dates AS (
    SELECT 
        'conditions' AS table_name, 
        COUNT(*) AS bad_date_count
    FROM staging.conditions
    WHERE start > stop
),
devices_bad_dates AS (
    SELECT 
        'devices' AS table_name, 
        COUNT(*) AS bad_date_count
    FROM staging.devices
    WHERE start > stop
),
medications_bad_dates AS (
    SELECT 
        'medications' AS table_name, 
        COUNT(*) AS bad_date_count
    FROM staging.medications
    WHERE start > stop
),
payer_transitions_bad_dates AS (
    SELECT 
        'payer_transitions' AS table_name, 
        COUNT(*) AS bad_date_count
    FROM staging.payer_transitions
    WHERE start_year > end_year
)

SELECT
    table_name,
    bad_date_count,
    CASE WHEN bad_date_count = 0 THEN 'PASS' ELSE 'FAIL' END AS status
FROM patient_bad_dates

UNION ALL
SELECT table_name, bad_date_count, CASE WHEN bad_date_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM encounter_bad_dates
UNION ALL
SELECT table_name, bad_date_count, CASE WHEN bad_date_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM careplans_bad_dates
UNION ALL
SELECT table_name, bad_date_count, CASE WHEN bad_date_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM conditions_bad_dates
UNION ALL
SELECT table_name, bad_date_count, CASE WHEN bad_date_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM devices_bad_dates
UNION ALL
SELECT table_name, bad_date_count, CASE WHEN bad_date_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM medications_bad_dates
UNION ALL
SELECT table_name, bad_date_count, CASE WHEN bad_date_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM payer_transitions_bad_dates

) checks
ORDER BY
    CASE WHEN status = 'FAIL' THEN 0 ELSE 1 END,
    bad_date_count DESC,
    table_name;