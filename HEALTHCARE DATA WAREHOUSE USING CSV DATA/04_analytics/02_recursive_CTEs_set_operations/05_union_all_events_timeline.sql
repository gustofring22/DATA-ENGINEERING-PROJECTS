SELECT
    'encounter'             AS event_type,   
    patient_sk,
    encounter_start         AS event_date,
    encounter_class         AS event_detail
FROM warehouse.fct_encounters

UNION ALL

SELECT
    'condition'             AS event_type,   
    patient_sk,
    onset_date              AS event_date,
    condition_description   AS event_detail
FROM warehouse.fct_conditions

UNION ALL

SELECT
    'medication'            AS event_type,   
    patient_sk,
    start_date              AS event_date,
    medication_description  AS event_detail
FROM warehouse.fct_medications

