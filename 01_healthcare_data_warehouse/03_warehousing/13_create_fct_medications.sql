-- Create the medications fact table.
CREATE TABLE IF NOT EXISTS warehouse.fct_medications (
    medication_sk           SERIAL      PRIMARY KEY,  -- fixed: added PRIMARY KEY
    patient_sk              INT         NOT NULL,     -- fixed: INT to match dim_patients.patient_sk SERIAL
    encounter_id            UUID        NOT NULL,
    medication_code         BIGINT,
    medication_description  TEXT,
    start_date              DATE,
    stop_date               DATE,
    base_cost               NUMERIC,
    loaded_at               TIMESTAMP
);

INSERT INTO warehouse.fct_medications (
    patient_sk,
    encounter_id,
    medication_code,
    medication_description,
    start_date,
    stop_date,
    base_cost,
    loaded_at
)
SELECT
    d.patient_sk                AS patient_sk,
    e.id::UUID                  AS encounter_id,
    m.code::BIGINT              AS medication_code,
    m.description               AS medication_description,
    m.start::DATE               AS start_date,
    m.stop::DATE                AS stop_date,
    m.base_cost::NUMERIC        AS base_cost,
    NOW()                       AS loaded_at
FROM staging.medications m
JOIN staging.encounters e
  ON e.id = m.encounter
JOIN warehouse.dim_patients d
  ON d.patient_id = e.patient::TEXT
 AND d.is_current = TRUE;
