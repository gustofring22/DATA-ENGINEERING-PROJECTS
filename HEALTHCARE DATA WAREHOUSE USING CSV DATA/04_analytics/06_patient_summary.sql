SELECT
    d.patient_id,
    d.full_name,
    MAX(e.encounter_start)          AS most_recent_encounter,
    conditions.number_conditions,
    medications.number_medications
FROM warehouse.fct_encounters e


JOIN warehouse.dim_patients d
  ON e.patient_sk = d.patient_sk::TEXT
AND d.is_current = TRUE


LEFT JOIN (
    SELECT 
        patient_sk,
        COUNT(*) AS number_conditions
    FROM warehouse.fct_conditions
    GROUP BY patient_sk
) conditions 
  ON e.patient_sk = conditions.patient_sk


LEFT JOIN (
    SELECT 
        patient_sk,
        COUNT(*) AS number_medications
    FROM warehouse.fct_medications
    GROUP BY patient_sk
) medications 
  ON e.patient_sk = medications.patient_sk

GROUP BY 
    d.patient_id,
    d.full_name,
    conditions.number_conditions,
    medications.number_medications
ORDER BY most_recent_encounter DESC;