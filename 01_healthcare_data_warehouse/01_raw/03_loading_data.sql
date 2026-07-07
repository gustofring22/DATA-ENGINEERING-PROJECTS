-- Load CSV files into the raw tables.
-- PATIENTS
TRUNCATE raw.patients;
\copy raw.patients (
    id, birthdate, deathdate, ssn, drivers, passport, prefix,
    first, last, suffix, maiden, marital, race, ethnicity,
    gender, birthplace, address, city, state, county, zip,
    lat, lon, healthcare_expenses, healthcare_coverage
)
FROM :'data_path'/patients.csv
WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'WIN1252');

-- ALLERGIES
TRUNCATE raw.allergies;
\copy raw.allergies (
    start, stop, patient, encounter, code, description
)
FROM :'data_path'/allergies.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- CAREPLANS
TRUNCATE raw.careplans;
\copy raw.careplans (
    id, start, stop, patient, encounter, code,
    description, reasoncode, reasondescription
)
FROM :'data_path'/careplans.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- CONDITIONS
TRUNCATE raw.conditions;
\copy raw.conditions (
    start, stop, patient, encounter, code, description
)
FROM :'data_path'/conditions.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- DEVICES
TRUNCATE raw.devices;
\copy raw.devices (
    start, stop, patient, encounter, code, description, udi
)
FROM :'data_path'/devices.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- ENCOUNTERS
TRUNCATE raw.encounters;
\copy raw.encounters (
    id, start, stop, patient, organization, provider, payer,
    encounterclass, code, description, base_encounter_cost,
    total_claim_cost, payer_coverage, reasoncode, reasondescription
)
FROM :'data_path'/encounters.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- MEDICATIONS
TRUNCATE raw.medications;
\copy raw.medications (
    start, stop, patient, payer, encounter, code, description,
    base_cost, payer_coverage, dispenses, totalcost,
    reasoncode, reasondescription
)
FROM :'data_path'/medications.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- PROCEDURES
TRUNCATE raw.procedures;
\copy raw.procedures (
    date, patient, encounter, code, description,
    base_cost, reasoncode, reasondescription
)
FROM :'data_path'/procedures.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- OBSERVATIONS
TRUNCATE raw.observations;
\copy raw.observations (
    date, patient, encounter, code, description,
    value, units, type
)
FROM :'data_path'/observations.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- IMMUNIZATIONS
TRUNCATE raw.immunizations;
\copy raw.immunizations (
    date, patient, encounter, code, description, base_cost
)
FROM :'data_path'/immunizations.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- IMAGING STUDIES
TRUNCATE raw.imaging_studies;
\copy raw.imaging_studies (
    id, date, patient, encounter, bodysite_code,
    bodysite_description, modality_code, modality_description,
    sop_code, sop_description
)
FROM :'data_path'/imaging_studies.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- SUPPLIES
TRUNCATE raw.supplies;
\copy raw.supplies (
    date, patient, encounter, code, description, quantity
)
FROM :'data_path'/supplies.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- ORGANIZATIONS
TRUNCATE raw.organizations;
\copy raw.organizations (
    id, name, address, city, state, zip, lat, lon,
    phone, revenue, utilization
)
FROM :'data_path'/organizations.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- PROVIDERS
TRUNCATE raw.providers;
\copy raw.providers (
    id, organization, name, gender, speciality, address,
    city, state, zip, lat, lon, utilization
)
FROM :'data_path'/providers.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- PAYERS
TRUNCATE raw.payers;
\copy raw.payers (
    id, name, address, city, state_headquartered, zip, phone,
    amount_covered, amount_uncovered, revenue, covered_encounters,
    uncovered_encounters, covered_medications, uncovered_medications,
    covered_procedures, uncovered_procedures, covered_immunizations,
    uncovered_immunizations, unique_customers, qols_avg, member_months
)
FROM :'data_path'/payers.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- PAYER TRANSITIONS
TRUNCATE raw.payer_transitions;
\copy raw.payer_transitions (
    patient, start_year, end_year, payer, ownership
)
FROM :'data_path'/payer_transitions.csv
WITH (FORMAT csv, HEADER true, NULL '');

-- ROW COUNT VERIFICATION
SELECT
    table_name,
    (xpath('/row/cnt/text()',
        query_to_xml(
            'SELECT COUNT(*) AS cnt FROM raw.' || quote_ident(table_name),
            false, true, ''
        )
    ))[1]::TEXT::INT AS row_count
FROM information_schema.tables
WHERE table_schema = 'raw'
ORDER BY table_name;