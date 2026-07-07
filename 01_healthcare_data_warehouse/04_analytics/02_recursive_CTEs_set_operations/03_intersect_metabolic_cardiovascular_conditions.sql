-- Find patients with both metabolic and cardiovascular conditions.
WITH cardiovascular_patients AS (
    SELECT DISTINCT f.patient_sk
    FROM warehouse.fct_conditions f
    JOIN warehouse.ref_condition_categories r
      ON f.condition_code = r.condition_code
    WHERE r.category = 'Cardiovascular'
),
metabolic_patients AS (
    SELECT DISTINCT f.patient_sk
    FROM warehouse.fct_conditions f
    JOIN warehouse.ref_condition_categories r
      ON f.condition_code = r.condition_code
    WHERE r.category = 'Metabolic'
),
both_conditions AS (
    SELECT patient_sk FROM cardiovascular_patients
    INTERSECT
    SELECT patient_sk FROM metabolic_patients
)
SELECT
    d.patient_id,
    d.full_name,
    d.city,
    d.gender
FROM warehouse.dim_patients d
JOIN both_conditions b
  ON d.patient_sk::TEXT = b.patient_sk
AND d.is_current = TRUE
ORDER BY d.full_name;