WITH encounter_history AS (
    SELECT
        patient_sk,
        encounter_start,
        LAG(encounter_start) OVER (
            PARTITION BY patient_sk 
            ORDER BY encounter_start
        ) AS previous_encounter
    FROM warehouse.fct_encounters
)
SELECT
    patient_sk,
    encounter_start,
    previous_encounter,
    (encounter_start - previous_encounter) AS days_between
FROM encounter_history;
