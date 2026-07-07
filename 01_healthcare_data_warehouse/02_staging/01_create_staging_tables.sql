-- Create staging tables for standardized intermediate data.
CREATE TABLE IF NOT EXISTS staging.patients (
    id                      TEXT,
    birthdate               DATE,
    deathdate               DATE,
    ssn                     VARCHAR(11),
    drivers                 TEXT,
    passport                TEXT,
    prefix                  TEXT,
    first                   TEXT,
    last                    TEXT,
    suffix                  TEXT,
    maiden                  TEXT,
    marital                 TEXT,
    race                    TEXT,
    ethnicity               TEXT,
    gender                  TEXT,
    birthplace              TEXT,
    address                 TEXT,
    city                    TEXT,
    state                   TEXT,
    county                  TEXT,
    zip                     VARCHAR(10),
    lat                     NUMERIC(9,6),
    lon                     NUMERIC(12,6),
    healthcare_expenses     NUMERIC(19,4),
    healthcare_coverage     NUMERIC(19,4),
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'patients.csv'
);

CREATE TABLE IF NOT EXISTS staging.encounters (
    id                      UUID,
    start                   TIMESTAMP,
    stop                    TIMESTAMP,
    patient                 UUID  NOT NULL,
    organization            UUID,
    provider                UUID,
    payer                   UUID,
    encounterclass          TEXT,
    code                    BIGINT,
    description             TEXT,
    base_encounter_cost     NUMERIC(10, 2),
    total_claim_cost        NUMERIC(10, 2),
    payer_coverage          NUMERIC(10, 2),
    reasoncode              BIGINT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'encounters.csv'
);

CREATE TABLE IF NOT EXISTS staging.conditions (
    start                   DATE,
    stop                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    NUMERIC(12,0),
    description             TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'conditions.csv'
);

CREATE TABLE IF NOT EXISTS staging.medications (
    start                   DATE,
    stop                    DATE,
    patient                 UUID,
    payer                   UUID,
    encounter               UUID,
    code                    BIGINT,
    description             TEXT,
    base_cost               NUMERIC(10, 2),
    payer_coverage          NUMERIC(10, 2),
    dispenses               NUMERIC(10, 2),
    totalcost               NUMERIC(10, 2),
    reasoncode              BIGINT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'medications.csv'
);

CREATE TABLE IF NOT EXISTS staging.procedures (
    date                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    BIGINT,
    description             TEXT,
    base_cost               NUMERIC(10, 2),
    reasoncode              BIGINT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'procedures.csv'
);

CREATE TABLE IF NOT EXISTS staging.observations (
    date                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    VARCHAR(20),
    description             TEXT,
    value                   TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'observations.csv'
);

CREATE TABLE IF NOT EXISTS staging.allergies (
    start                   DATE,
    stop                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    BIGINT,
    description             TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'allergies.csv'
);

CREATE TABLE IF NOT EXISTS staging.immunizations (
    date                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    NUMERIC,
    description             TEXT,
    base_cost               NUMERIC(10, 2),
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'immunizations.csv'
);

CREATE TABLE IF NOT EXISTS staging.careplans (
    id                      UUID,
    start                   DATE,
    stop                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    BIGINT,
    description             TEXT,
    reasoncode              BIGINT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'careplans.csv'
);

CREATE TABLE IF NOT EXISTS staging.devices (
    start                   DATE,
    stop                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    BIGINT,
    description             TEXT,
    udi                     VARCHAR(100),
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'devices.csv'
);

CREATE TABLE IF NOT EXISTS staging.imaging_studies (
    id                      UUID,
    date                    DATE,
    patient                 UUID,
    encounter               UUID,
    bodysite_code           BIGINT,
    bodysite_description    TEXT,
    modality_code           BIGINT,
    modality_description    TEXT,
    sop_code                NUMERIC,
    sop_description         TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'imaging_studies.csv'
);

CREATE TABLE IF NOT EXISTS staging.supplies (
    date                    DATE,
    patient                 UUID,
    encounter               UUID,
    code                    BIGINT,
    description             TEXT,
    quantity                NUMERIC,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'supplies.csv'
);

CREATE TABLE IF NOT EXISTS staging.organizations (
    id                      UUID,
    name                    TEXT,
    address                 TEXT,
    city                    TEXT,
    state                   TEXT,
    zip                     NUMERIC,
    lat                     NUMERIC(9,6),
    lon                     NUMERIC(12,6),
    phone                   VARCHAR(255),
    revenue                 NUMERIC(10,2),
    utilization             NUMERIC,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'organizations.csv'
);

CREATE TABLE IF NOT EXISTS staging.providers (
    id                      UUID,
    organization            UUID,
    name                    TEXT,
    gender                  TEXT,
    speciality              TEXT,
    address                 TEXT,
    city                    TEXT,
    state                   TEXT,
    zip                     VARCHAR(10),
    lat                     NUMERIC(9,6),
    lon                     NUMERIC(12,6),
    utilization             NUMERIC,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'providers.csv'
);

CREATE TABLE IF NOT EXISTS staging.payers (
    id                      UUID,
    name                    TEXT,
    address                 TEXT,
    city                    TEXT,
    state_headquartered     TEXT,
    zip                     VARCHAR(10),
    phone                   VARCHAR(255),
    amount_covered          NUMERIC(10, 2),
    amount_uncovered        NUMERIC(10, 2),
    revenue                 NUMERIC(10, 2),
    covered_encounters      NUMERIC,
    uncovered_encounters    NUMERIC,
    covered_medications     NUMERIC,
    uncovered_medications   NUMERIC,
    covered_procedures      NUMERIC,
    uncovered_procedures    NUMERIC,
    covered_immunizations   NUMERIC,
    uncovered_immunizations NUMERIC,
    unique_customers        NUMERIC,
    qols_avg                NUMERIC(18, 15),
    member_months           NUMERIC,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'payers.csv'
);

CREATE TABLE IF NOT EXISTS staging.payer_transitions (
    patient                 UUID,
    start_year              SMALLINT,
    end_year                SMALLINT,
    payer                   UUID,
    ownership               TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'payer_transitions.csv'
);

