CREATE TABLE IF NOT EXISTS warehouse.dim_patients (
    patient_sk          SERIAL          PRIMARY KEY,  
    patient_id          TEXT            NOT NULL,    
    full_name           TEXT,
    birthdate           DATE,
    gender              TEXT,
    race                TEXT,
    ethnicity           TEXT,
    marital_status      TEXT,
    city                TEXT,
    state               TEXT,
    zip                 VARCHAR(10),
    effective_date      DATE            NOT NULL,
    expiry_date         DATE,
    is_current          BOOLEAN         NOT NULL DEFAULT TRUE,
    record_hash         TEXT            NOT NULL,
    loaded_at           TIMESTAMP       DEFAULT NOW()
);