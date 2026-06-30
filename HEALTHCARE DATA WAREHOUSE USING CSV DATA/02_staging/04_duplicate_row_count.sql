SELECT * FROM (

WITH
-- =============================================================
-- SINGLE KEY DUPLICATE CHECKS
-- =============================================================
patient_dupes AS (
    SELECT id FROM staging.patients
    GROUP BY id HAVING COUNT(*) > 1
),
encounter_dupes AS (
    SELECT id FROM staging.encounters
    GROUP BY id HAVING COUNT(*) > 1
),
careplan_dupes AS (
    SELECT id FROM staging.careplans
    GROUP BY id HAVING COUNT(*) > 1
),
imaging_dupes AS (
    SELECT id FROM staging.imaging_studies
    GROUP BY id HAVING COUNT(*) > 1
),
organization_dupes AS (
    SELECT id FROM staging.organizations
    GROUP BY id HAVING COUNT(*) > 1
),
provider_dupes AS (
    SELECT id FROM staging.providers
    GROUP BY id HAVING COUNT(*) > 1
),
payer_dupes AS (
    SELECT id FROM staging.payers
    GROUP BY id HAVING COUNT(*) > 1
),

-- =============================================================
-- COMPOSITE KEY DUPLICATE CHECKS
-- NOTE: procedures, medications, observations, supplies excluded
-- Same code can legitimately appear multiple times per encounter
-- =============================================================
condition_dupes AS (
    SELECT patient, encounter, code
    FROM staging.conditions
    GROUP BY patient, encounter, code
    HAVING COUNT(*) > 1
),
allergy_dupes AS (
    SELECT patient, code, start
    FROM staging.allergies
    GROUP BY patient, code, start
    HAVING COUNT(*) > 1
),
immunization_dupes AS (
    SELECT patient, code, date
    FROM staging.immunizations
    GROUP BY patient, code, date
    HAVING COUNT(*) > 1
),
device_dupes AS (
    SELECT patient, code, start
    FROM staging.devices
    GROUP BY patient, code, start
    HAVING COUNT(*) > 1
),
payer_transition_dupes AS (
    SELECT patient, start_year
    FROM staging.payer_transitions
    GROUP BY patient, start_year
    HAVING COUNT(*) > 1
)

SELECT
    'patients - duplicate id'                   AS check_name,
    'single key'                                AS check_type,
    'id'                                        AS key_columns,
    COUNT(*)                                    AS dupe_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS'
         ELSE 'FAIL' END                        AS status
FROM patient_dupes

UNION ALL
SELECT 'encounters - duplicate id',         'single key',     'id',                    COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM encounter_dupes
UNION ALL
SELECT 'careplans - duplicate id',          'single key',     'id',                    COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM careplan_dupes
UNION ALL
SELECT 'imaging_studies - duplicate id',    'single key',     'id',                    COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM imaging_dupes
UNION ALL
SELECT 'organizations - duplicate id',      'single key',     'id',                    COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM organization_dupes
UNION ALL
SELECT 'providers - duplicate id',          'single key',     'id',                    COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM provider_dupes
UNION ALL
SELECT 'payers - duplicate id',             'single key',     'id',                    COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM payer_dupes
UNION ALL
SELECT 'conditions - duplicate composite',  'composite key',  'patient,encounter,code', COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM condition_dupes
UNION ALL
SELECT 'allergies - duplicate composite',   'composite key',  'patient,code,start',     COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM allergy_dupes
UNION ALL
SELECT 'immunizations - duplicate composite','composite key', 'patient,code,date',      COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM immunization_dupes
UNION ALL
SELECT 'devices - duplicate composite',     'composite key',  'patient,code,start',     COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM device_dupes
UNION ALL
SELECT 'payer_transitions - duplicate composite','composite key','patient,start_year',  COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END FROM payer_transition_dupes

) checks
ORDER BY
    CASE WHEN status = 'FAIL' THEN 0 ELSE 1 END,
    dupe_count DESC,
    check_name;