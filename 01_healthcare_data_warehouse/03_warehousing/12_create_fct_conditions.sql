-- Create the conditions fact table.
CREATE TABLE IF NOT EXISTS warehouse.fct_conditions (
    condition_sk            SERIAL      PRIMARY KEY,
    patient_sk              INT         NOT NULL,   -- fixed: INT to match dim_patients.patient_sk SERIAL
    encounter_id            UUID        NOT NULL,
    condition_code          NUMERIC,
    condition_description   TEXT,
    onset_date              DATE,
    resolution_date         DATE,
    loaded_at               TIMESTAMP
);

INSERT INTO warehouse.fct_conditions (
    patient_sk,
    encounter_id,
    condition_code,
    condition_description,
    onset_date,
    resolution_date,
    loaded_at
)
SELECT
    d.patient_sk                AS patient_sk,
    e.id::UUID                  AS encounter_id,
    s.code::NUMERIC             AS condition_code,
    s.description               AS condition_description,
    s.start::DATE               AS onset_date,
    s.stop::DATE                AS resolution_date,
    NOW()                       AS loaded_at
FROM staging.conditions s
JOIN staging.encounters e
  ON s.encounter = e.id
JOIN warehouse.dim_patients d
  ON d.patient_id::UUID = e.patient::UUID
 AND d.is_current = TRUE;
