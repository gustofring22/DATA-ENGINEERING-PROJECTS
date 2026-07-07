-- Use ROW_NUMBER to identify each patient's first encounter.
SELECT *
FROM (
    SELECT
        patient_sk,
        encounter_id,
        encounter_start,
        ROW_NUMBER() OVER (
            PARTITION BY patient_sk
            ORDER BY encounter_start
        )                               AS encounter_number,
        COUNT(*) OVER (
            PARTITION BY patient_sk
        )                               AS total_encounters
    FROM warehouse.fct_encounters
) ranked
WHERE encounter_number = 1          
ORDER BY patient_sk;