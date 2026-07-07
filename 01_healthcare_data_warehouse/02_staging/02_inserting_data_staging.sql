-- Load source data from raw into staging.
INSERT INTO staging.patients (
    id,
    birthdate,
    deathdate,
    ssn,
    drivers,
    passport,
    prefix,
    first,
    last,
    suffix,
    maiden,
    marital,
    race,
    ethnicity,
    gender,
    birthplace,
    address,
    city,
    state,
    county,
    zip,
    lat,
    lon,
    healthcare_expenses,
    healthcare_coverage,
    loaded_at,
    source_file
)
SELECT
    NULLIF(TRIM(id), '')                            AS id,
    TO_DATE(NULLIF(TRIM(birthdate), ''), 'DD-MM-YYYY')  AS birthdate,
    TO_DATE(NULLIF(TRIM(deathdate), ''), 'DD-MM-YYYY')  AS deathdate,
    NULLIF(TRIM(ssn), '')                           AS ssn,
    NULLIF(TRIM(drivers), '')                       AS drivers,
    NULLIF(TRIM(passport), '')                      AS passport,
    NULLIF(TRIM(prefix), '')                        AS prefix,
    UPPER(TRIM(first))                              AS first,
    UPPER(TRIM(last))                               AS last,
    NULLIF(TRIM(suffix), '')                        AS suffix,
    NULLIF(TRIM(maiden), '')                        AS maiden,
    UPPER(NULLIF(TRIM(marital), ''))                AS marital,
    LOWER(NULLIF(TRIM(race), ''))                   AS race,
    LOWER(NULLIF(TRIM(ethnicity), ''))              AS ethnicity,
    UPPER(NULLIF(TRIM(gender), ''))                 AS gender,
    NULLIF(TRIM(birthplace), '')                    AS birthplace,
    NULLIF(TRIM(address), '')                       AS address,
    UPPER(NULLIF(TRIM(city), ''))                   AS city,
    UPPER(NULLIF(TRIM(state), ''))                  AS state,
    NULLIF(TRIM(county), '')                        AS county,
    NULLIF(TRIM(zip), '')                           AS zip,
    NULLIF(TRIM(lat), '')::NUMERIC(9,6)             AS lat,
    NULLIF(TRIM(lon), '')::NUMERIC(12,6)            AS lon,
    NULLIF(TRIM(healthcare_expenses), '')::NUMERIC(19,4)    AS healthcare_expenses,
    NULLIF(TRIM(healthcare_coverage), '')::NUMERIC(19,4)    AS healthcare_coverage,
    NOW()                                           AS loaded_at,
    'patients.csv'                                  AS source_file
FROM raw.patients;
INSERT INTO staging.encounters (
    id, start, stop, patient, organization, provider, payer,
    encounterclass, code, description, base_encounter_cost,
    total_claim_cost, payer_coverage, reasoncode, reasondescription,
    loaded_at, source_file
)
SELECT
    NULLIF(TRIM(id), '')::UUID                                          AS id,
    TO_TIMESTAMP(NULLIF(TRIM(start), ''), 'YYYY-MM-DD"T"HH24:MI:SS')        AS start,
    TO_TIMESTAMP(NULLIF(TRIM(stop), ''), 'YYYY-MM-DD"T"HH24:MI:SS')         AS stop,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(organization), '')::UUID                                AS organization,
    NULLIF(TRIM(provider), '')::UUID                                    AS provider,
    NULLIF(TRIM(payer), '')::UUID                                       AS payer,
    LOWER(NULLIF(TRIM(encounterclass), ''))                             AS encounterclass,
    NULLIF(TRIM(code), '')::BIGINT                                      AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NULLIF(TRIM(base_encounter_cost), '')::NUMERIC(10,2)                AS base_encounter_cost,
    NULLIF(TRIM(total_claim_cost), '')::NUMERIC(10,2)                   AS total_claim_cost,
    NULLIF(TRIM(payer_coverage), '')::NUMERIC(10,2)                     AS payer_coverage,
    NULLIF(TRIM(reasoncode), '')::BIGINT                                AS reasoncode,
    NULLIF(TRIM(reasondescription), '')                                 AS reasondescription,
    NOW()                                                               AS loaded_at,
    'encounters.csv'                                                    AS source_file
FROM raw.encounters
ALTER TABLE staging.conditions 
ALTER COLUMN code TYPE BIGINT;
INSERT INTO staging.conditions (
    start, stop, patient, encounter, code, description,
    loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(start), ''), 'YYYY MM DD')                     AS start,
    TO_DATE(NULLIF(TRIM(stop), ''), 'YYYY MM DD')                      AS stop,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::NUMERIC::BIGINT  							AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NOW()                                                               AS loaded_at,
    'conditions.csv'                                                    AS source_file
FROM raw.conditions
WHERE patient != 'PATIENT';
INSERT INTO staging.medications (
    start, stop, patient, payer, encounter, code, description,
    base_cost, payer_coverage, dispenses, totalcost,
    reasoncode, reasondescription, loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(start), ''), 'YYYY MM DD')                     AS start,
    TO_DATE(NULLIF(TRIM(stop), ''), 'YYYY MM DD')                      AS stop,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(payer), '')::UUID                                       AS payer,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::BIGINT                                      AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NULLIF(TRIM(base_cost), '')::NUMERIC(10,2)                         AS base_cost,
    NULLIF(TRIM(payer_coverage), '')::NUMERIC(10,2)                    AS payer_coverage,
    NULLIF(TRIM(dispenses), '')::NUMERIC(10,2)                         AS dispenses,
    NULLIF(TRIM(totalcost), '')::NUMERIC(10,2)                         AS totalcost,
    NULLIF(TRIM(reasoncode), '')::BIGINT                               AS reasoncode,
    NULLIF(TRIM(reasondescription), '')                                 AS reasondescription,
    NOW()                                                               AS loaded_at,
    'medications.csv'                                                   AS source_file
FROM raw.medications
WHERE patient != 'PATIENT';
INSERT INTO staging.procedures (
    date, patient, encounter, code, description,
    base_cost, reasoncode, reasondescription,
    loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(date), ''), 'YYYY MM DD')                      AS date,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::BIGINT                                      AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NULLIF(TRIM(base_cost), '')::NUMERIC(10,2)                         AS base_cost,
    NULLIF(TRIM(reasoncode), '')::BIGINT                               AS reasoncode,
    NULLIF(TRIM(reasondescription), '')                                 AS reasondescription,
    NOW()                                                               AS loaded_at,
    'procedures.csv'                                                    AS source_file
FROM raw.procedures
WHERE patient != 'PATIENT';
INSERT INTO staging.observations (
    date, patient, encounter, code, description, value,
    loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(date), ''), 'YYYY MM DD')                      AS date,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')                                              AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    CASE
        WHEN NULLIF(TRIM(units), '') IS NULL THEN NULLIF(TRIM(value), '')
        ELSE CONCAT(TRIM(value), ' ', TRIM(units))
    END                                                                 AS value,
    NOW()                                                               AS loaded_at,
    'observations.csv'                                                  AS source_file
FROM raw.observations
WHERE patient != 'PATIENT';
INSERT INTO staging.allergies (
    start, stop, patient, encounter, code, description,
    loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(start), ''), 'YYYY MM DD')                     AS start,
    TO_DATE(NULLIF(TRIM(stop), ''), 'YYYY MM DD')                      AS stop,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::BIGINT                                      AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NOW()                                                               AS loaded_at,
    'allergies.csv'                                                     AS source_file
FROM raw.allergies
WHERE patient != 'PATIENT';
INSERT INTO staging.immunizations (
    date, patient, encounter, code, description, base_cost,
    loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(date), ''), 'YYYY MM DD')                      AS date,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::NUMERIC                                     AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NULLIF(TRIM(base_cost), '')::NUMERIC(10,2)                         AS base_cost,
    NOW()                                                               AS loaded_at,
    'immunizations.csv'                                                 AS source_file
FROM raw.immunizations
WHERE patient != 'PATIENT';
INSERT INTO staging.careplans (
    id, start, stop, patient, encounter, code, description,
    reasoncode, reasondescription, loaded_at, source_file
)
SELECT
    NULLIF(TRIM(id), '')::UUID                                          AS id,
    TO_DATE(NULLIF(TRIM(start), ''), 'YYYY MM DD')                     AS start,
    TO_DATE(NULLIF(TRIM(stop), ''), 'YYYY MM DD')                      AS stop,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::BIGINT                                      AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NULLIF(TRIM(reasoncode), '')::BIGINT                               AS reasoncode,
    NULLIF(TRIM(reasondescription), '')                                 AS reasondescription,
    NOW()                                                               AS loaded_at,
    'careplans.csv'                                                     AS source_file
FROM raw.careplans
WHERE patient != 'PATIENT';
INSERT INTO staging.devices (
    start, stop, patient, encounter, code, description, udi,
    loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(start), ''), 'YYYY MM DD')                     AS start,
    TO_DATE(NULLIF(TRIM(stop), ''), 'YYYY MM DD')                      AS stop,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::BIGINT                                      AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NULLIF(TRIM(udi), '')                                               AS udi,
    NOW()                                                               AS loaded_at,
    'devices.csv'                                                       AS source_file
FROM raw.devices
WHERE patient != 'PATIENT';
INSERT INTO staging.supplies (
    date, patient, encounter, code, description, quantity,
    loaded_at, source_file
)
SELECT
    TO_DATE(NULLIF(TRIM(date), ''), 'YYYY MM DD')                      AS date,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(code), '')::BIGINT                                      AS code,
    NULLIF(TRIM(description), '')                                       AS description,
    NULLIF(TRIM(quantity), '')::NUMERIC                                 AS quantity,
    NOW()                                                               AS loaded_at,
    'supplies.csv'                                                      AS source_file
FROM raw.supplies
WHERE patient != 'PATIENT';
INSERT INTO staging.organizations (
    id, name, address, city, state, zip, lat, lon,
    phone, revenue, utilization, loaded_at, source_file
)
SELECT
    NULLIF(TRIM(id), '')::UUID                                          AS id,
    NULLIF(TRIM(name), '')                                              AS name,
    NULLIF(TRIM(address), '')                                           AS address,
    UPPER(NULLIF(TRIM(city), ''))                                       AS city,
    UPPER(NULLIF(TRIM(state), ''))                                      AS state,
    NULLIF(TRIM(zip), '')                                               AS zip,
    NULLIF(TRIM(lat), '')::NUMERIC(9,6)                                AS lat,
    NULLIF(TRIM(lon), '')::NUMERIC(12,6)                               AS lon,
    NULLIF(TRIM(phone), '')                                             AS phone,
    NULLIF(TRIM(revenue), '')::NUMERIC(10,2)                           AS revenue,
    NULLIF(TRIM(utilization), '')::NUMERIC                             AS utilization,
    NOW()                                                               AS loaded_at,
    'organizations.csv'                                                 AS source_file
FROM raw.organizations
WHERE id != 'Id';
INSERT INTO staging.imaging_studies (
    id, date, patient, encounter,
    bodysite_code, bodysite_description,
    modality_code, modality_description,
    sop_code, sop_description,
    loaded_at, source_file
)
SELECT
    NULLIF(TRIM(id), '')::UUID                                          AS id,
    TO_DATE(NULLIF(TRIM(date), ''), 'YYYY MM DD')                      AS date,
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(encounter), '')::UUID                                   AS encounter,
    NULLIF(TRIM(bodysite_code), '')                          AS bodysite_code,
    NULLIF(TRIM(bodysite_description), '')                              AS bodysite_description,
    NULLIF(TRIM(modality_code), '')                          AS modality_code,
    NULLIF(TRIM(modality_description), '')                              AS modality_description,
    NULLIF(TRIM(sop_code), '')                                AS sop_code,
    NULLIF(TRIM(sop_description), '')                                   AS sop_description,
    NOW()                                                               AS loaded_at,
    'imaging_studies.csv'                                               AS source_file
FROM raw.imaging_studies
WHERE patient != 'PATIENT';
INSERT INTO staging.providers (
    id, organization, name, gender, speciality,
    address, city, state, zip, lat, lon,
    utilization, loaded_at, source_file
)
SELECT
    NULLIF(TRIM(id), '')::UUID                                          AS id,
    NULLIF(TRIM(organization), '')::UUID                               AS organization,
    NULLIF(TRIM(name), '')                                              AS name,
    UPPER(NULLIF(TRIM(gender), ''))                                     AS gender,
    NULLIF(TRIM(speciality), '')                                        AS speciality,
    NULLIF(TRIM(address), '')                                           AS address,
    UPPER(NULLIF(TRIM(city), ''))                                       AS city,
    UPPER(NULLIF(TRIM(state), ''))                                      AS state,
    NULLIF(TRIM(zip), '')                                               AS zip,
    NULLIF(TRIM(lat), '')::NUMERIC(9,6)                                AS lat,
    NULLIF(TRIM(lon), '')::NUMERIC(12,6)                               AS lon,
    NULLIF(TRIM(utilization), '')::NUMERIC                             AS utilization,
    NOW()                                                               AS loaded_at,
    'providers.csv'                                                     AS source_file
FROM raw.providers
WHERE id != 'Id';
INSERT INTO staging.payers (
    id, name, address, city, state_headquartered, zip, phone,
    amount_covered, amount_uncovered, revenue,
    covered_encounters, uncovered_encounters,
    covered_medications, uncovered_medications,
    covered_procedures, uncovered_procedures,
    covered_immunizations, uncovered_immunizations,
    unique_customers, qols_avg, member_months,
    loaded_at, source_file
)
SELECT
    NULLIF(TRIM(id), '')::UUID                              AS id,
    NULLIF(TRIM(name), '')                                  AS name,
    NULLIF(TRIM(address), '')                               AS address,
    UPPER(NULLIF(TRIM(city), ''))                           AS city,
    UPPER(NULLIF(TRIM(state_headquartered), ''))            AS state_headquartered,
    NULLIF(TRIM(zip), '')                                   AS zip,
    NULLIF(TRIM(phone), '')                                 AS phone,
    NULLIF(TRIM(amount_covered), '')::NUMERIC(19,2)         AS amount_covered,
    NULLIF(TRIM(amount_uncovered), '')::NUMERIC(19,2)       AS amount_uncovered,
    NULLIF(TRIM(revenue), '')::NUMERIC(19,2)                AS revenue,
    NULLIF(TRIM(covered_encounters), '')::NUMERIC           AS covered_encounters,
    NULLIF(TRIM(uncovered_encounters), '')::NUMERIC         AS uncovered_encounters,
    NULLIF(TRIM(covered_medications), '')::NUMERIC          AS covered_medications,
    NULLIF(TRIM(uncovered_medications), '')::NUMERIC        AS uncovered_medications,
    NULLIF(TRIM(covered_procedures), '')::NUMERIC           AS covered_procedures,
    NULLIF(TRIM(uncovered_procedures), '')::NUMERIC         AS uncovered_procedures,
    NULLIF(TRIM(covered_immunizations), '')::NUMERIC        AS covered_immunizations,
    NULLIF(TRIM(uncovered_immunizations), '')::NUMERIC      AS uncovered_immunizations,
    NULLIF(TRIM(unique_customers), '')::NUMERIC             AS unique_customers,
    NULLIF(TRIM(qols_avg), '')::NUMERIC(18,15)              AS qols_avg,
    NULLIF(TRIM(member_months), '')::NUMERIC                AS member_months,
    NOW()                                                   AS loaded_at,
    'payers.csv'                                            AS source_file
FROM raw.payers
WHERE id != 'Id';

INSERT INTO staging.payer_transitions (
    patient, start_year, end_year, payer, ownership,
    loaded_at, source_file
)
SELECT
    NULLIF(TRIM(patient), '')::UUID                                     AS patient,
    NULLIF(TRIM(start_year), '')::SMALLINT                             AS start_year,
    NULLIF(TRIM(end_year), '')::SMALLINT                               AS end_year,
    NULLIF(TRIM(payer), '')::UUID                                       AS payer,
    NULLIF(TRIM(ownership), '')                                         AS ownership,
    NOW()                                                               AS loaded_at,
    'payer_transitions.csv'                                             AS source_file
FROM raw.payer_transitions
WHERE patient != 'PATIENT';



