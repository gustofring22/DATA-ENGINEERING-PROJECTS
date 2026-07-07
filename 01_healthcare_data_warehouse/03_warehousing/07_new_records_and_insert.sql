-- Identify and insert new patient records.
WITH new_records AS (
    SELECT s.*
    FROM staging.patients s
    WHERE NOT EXISTS (
        SELECT 1
        FROM warehouse.dim_patients d
        WHERE s.id::TEXT = d.patient_id
    )
)
INSERT INTO warehouse.dim_patients (
    patient_id,
    full_name,
    birthdate,
    gender,
    race,
    ethnicity,
    marital_status,
    city,
    state,
    zip,
    effective_date,
    expiry_date,
    is_current,
    record_hash,
    loaded_at
)
SELECT 
    s.id,
    s.first || ' ' || s.last AS full_name,
    s.birthdate,
    s.gender,
    s.race,
    s.ethnicity,
    s.marital,
    s.city,
    s.state,
    s.zip,
    CURRENT_DATE,          -- effective_date
    NULL,                  -- expiry_date
    TRUE,                  -- is_current
    MD5(CONCAT(
        COALESCE(s.marital, 'NULL'), '|',
        COALESCE(s.city, 'NULL'), '|',
        COALESCE(s.state, 'NULL'), '|',
        COALESCE(s.zip, 'NULL')
    )) AS record_hash,
    NOW()                  -- loaded_at
FROM new_records s;
