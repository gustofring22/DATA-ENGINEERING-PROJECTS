-- Merge the new daily feed into the SCD Type 2 patient dimension.
WITH patients_to_update AS (
    SELECT id 
    FROM staging.patients
    WHERE RANDOM() < 0.2
)
UPDATE staging.patients
SET
    city    = CASE (RANDOM() * 4)::INT
                    WHEN 0 THEN 'BOSTON'
                    WHEN 1 THEN 'NEW YORK'
                    WHEN 2 THEN 'CHICAGO'
                    WHEN 3 THEN 'SEATTLE'
                    ELSE        'MIAMI'
              END,
    marital = CASE (RANDOM() * 2)::INT
                    WHEN 0 THEN 'S'
                    ELSE		'M'
              END
WHERE id IN (SELECT id FROM patients_to_update);

SELECT
    s.id,
    s.first,
    s.last,
    d.city          AS old_city,
    s.city          AS new_city,
    d.marital_status AS old_marital,
    s.marital       AS new_marital
FROM staging.patients s
JOIN warehouse.dim_patients d
  ON s.id::TEXT = d.patient_id
AND d.is_current = TRUE
WHERE s.city != d.city
OR s.marital != d.marital_status
LIMIT 20;

