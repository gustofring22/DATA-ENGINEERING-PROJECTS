SELECT
	d.full_name                                 AS full_name,
	EXTRACT(YEAR FROM e.encounter_start)        AS year_date,
	COUNT(DISTINCT m.medication_code)           AS number_medications
FROM warehouse.dim_patients d
JOIN warehouse.fct_encounters e
  ON d.patient_sk = e.patient_sk::INTEGER
AND d.is_current = TRUE
JOIN warehouse.fct_medications m
  ON d.patient_sk = m.patient_sk::INTEGER
WHERE EXTRACT(YEAR FROM e.encounter_start) = 2020
GROUP BY
	d.patient_sk,
	d.full_name,
	EXTRACT(YEAR FROM e.encounter_start)
HAVING COUNT(DISTINCT m.medication_code) >= 1;


