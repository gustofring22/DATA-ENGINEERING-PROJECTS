-- Find patients who changed cities and their condition history.
WITH city_changers AS(
	SELECT patient_id
	FROM warehouse.dim_patients
	GROUP BY patient_id
	HAVING COUNT(*) > 1
),
their_conditions AS (
    SELECT
        c.condition_code,
        c.condition_description,
        COUNT(DISTINCT c.patient_sk)    AS patient_count
    FROM warehouse.fct_conditions c
    JOIN warehouse.dim_patients d
      ON c.patient_sk = d.patient_sk::TEXT
    WHERE d.patient_id IN (SELECT patient_id FROM city_changers)
    GROUP BY c.condition_code, c.condition_description
)
SELECT
    condition_code,
    condition_description,
    patient_count
FROM their_conditions
ORDER BY patient_count DESC
LIMIT 10;