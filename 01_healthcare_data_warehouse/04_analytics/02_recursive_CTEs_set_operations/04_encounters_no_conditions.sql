-- Find encounters with no linked conditions.
WITH encounters_only AS (
    SELECT DISTINCT patient_sk
    FROM warehouse.fct_encounters

    EXCEPT

    SELECT DISTINCT patient_sk
    FROM warehouse.fct_conditions
)
SELECT
    d.patient_id,
    d.full_name,
    d.city,
    d.gender,
    COUNT(e.encounter_id)           AS total_encounters,
    MAX(e.encounter_start)          AS last_encounter,
    'No conditions recorded'        AS flag
FROM warehouse.dim_patients d
JOIN encounters_only eo
  ON d.patient_sk::TEXT = eo.patient_sk
JOIN warehouse.fct_encounters e
  ON d.patient_sk::TEXT = e.patient_sk
AND d.is_current = TRUE
GROUP BY
    d.patient_id,
    d.full_name,
    d.city,
    d.gender
ORDER BY total_encounters DESC;