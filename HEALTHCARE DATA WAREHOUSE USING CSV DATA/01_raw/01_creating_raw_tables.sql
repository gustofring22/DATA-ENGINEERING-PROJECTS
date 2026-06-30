CREATE TABLE IF NOT EXISTS raw.patients (
    id                      TEXT,
    birthdate               TEXT,
    deathdate               TEXT,
    ssn                     TEXT,
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
    zip                     TEXT,
    lat                     TEXT,
    lon                     TEXT,
    healthcare_expenses     TEXT,
    healthcare_coverage     TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'patients.csv'
);

CREATE TABLE IF NOT EXISTS raw.encounters (
    id                      TEXT,
    start                   TEXT,
    stop                    TEXT,
    patient                 TEXT,
    organization            TEXT,
    provider                TEXT,
    payer                   TEXT,
    encounterclass          TEXT,
    code                    TEXT,
    description             TEXT,
    base_encounter_cost     TEXT,
    total_claim_cost        TEXT,
    payer_coverage          TEXT,
    reasoncode              TEXT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'encounters.csv'
);

CREATE TABLE IF NOT EXISTS raw.conditions (
    start                   TEXT,
    stop                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'conditions.csv'
);

CREATE TABLE IF NOT EXISTS raw.medications (
    start                   TEXT,
    stop                    TEXT,
    patient                 TEXT,
    payer                   TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    base_cost               TEXT,
    payer_coverage          TEXT,
    dispenses               TEXT,
    totalcost               TEXT,
    reasoncode              TEXT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'medications.csv'
);

CREATE TABLE IF NOT EXISTS raw.procedures (
    date                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    base_cost               TEXT,
    reasoncode              TEXT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'procedures.csv'
);

CREATE TABLE IF NOT EXISTS raw.observations (
    date                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    value                   TEXT,
    units                   TEXT,
    type                    TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'observations.csv'
);

CREATE TABLE IF NOT EXISTS raw.allergies (
    start                   TEXT,
    stop                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'allergies.csv'
);

CREATE TABLE IF NOT EXISTS raw.immunizations (
    date                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    base_cost               TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'immunizations.csv'
);

CREATE TABLE IF NOT EXISTS raw.careplans (
    id                      TEXT,
    start                   TEXT,
    stop                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    reasoncode              TEXT,
    reasondescription       TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'careplans.csv'
);

CREATE TABLE IF NOT EXISTS raw.devices (
    start                   TEXT,
    stop                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    udi                     TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'devices.csv'
);

CREATE TABLE IF NOT EXISTS raw.imaging_studies (
    id                      TEXT,
    date                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    bodysite_code           TEXT,
    bodysite_description    TEXT,
    modality_code           TEXT,
    modality_description    TEXT,
    sop_code                TEXT,
    sop_description         TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'imaging_studies.csv'
);

CREATE TABLE IF NOT EXISTS raw.supplies (
    date                    TEXT,
    patient                 TEXT,
    encounter               TEXT,
    code                    TEXT,
    description             TEXT,
    quantity                TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'supplies.csv'
);

CREATE TABLE IF NOT EXISTS raw.organizations (
    id                      TEXT,
    name                    TEXT,
    address                 TEXT,
    city                    TEXT,
    state                   TEXT,
    zip                     TEXT,
    lat                     TEXT,
    lon                     TEXT,
    phone                   TEXT,
    revenue                 TEXT,
    utilization             TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'organizations.csv'
);

CREATE TABLE IF NOT EXISTS raw.providers (
    id                      TEXT,
    organization            TEXT,
    name                    TEXT,
    gender                  TEXT,
    speciality              TEXT,
    address                 TEXT,
    city                    TEXT,
    state                   TEXT,
    zip                     TEXT,
    lat                     TEXT,
    lon                     TEXT,
    utilization             TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'providers.csv'
);

CREATE TABLE IF NOT EXISTS raw.payers (
    id                      TEXT,
    name                    TEXT,
    address                 TEXT,
    city                    TEXT,
    state_headquartered     TEXT,
    zip                     TEXT,
    phone                   TEXT,
    amount_covered          TEXT,
    amount_uncovered        TEXT,
    revenue                 TEXT,
    covered_encounters      TEXT,
    uncovered_encounters    TEXT,
    covered_medications     TEXT,
    uncovered_medications   TEXT,
    covered_procedures      TEXT,
    uncovered_procedures    TEXT,
    covered_immunizations   TEXT,
    uncovered_immunizations TEXT,
    unique_customers        TEXT,
    qols_avg                TEXT,
    member_months           TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'payers.csv'
);

CREATE TABLE IF NOT EXISTS raw.payer_transitions (
    patient                 TEXT,
    start_year              TEXT,
    end_year                TEXT,
    payer                   TEXT,
    ownership               TEXT,
    loaded_at               TIMESTAMP DEFAULT NOW(),
    source_file             TEXT      DEFAULT 'payer_transitions.csv'
);

