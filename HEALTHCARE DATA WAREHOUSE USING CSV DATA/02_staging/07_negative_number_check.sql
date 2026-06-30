SELECT * FROM (

WITH encounter_negatives AS (
    SELECT COUNT(*) AS negative_count
    FROM staging.encounters
    WHERE base_encounter_cost < 0 
    OR total_claim_cost < 0 
    OR payer_coverage < 0
),
immunization_negatives AS (
    SELECT COUNT(*) AS negative_count
    FROM staging.immunizations          -- fixed typo
    WHERE base_cost < 0
),
medication_negatives AS (
    SELECT COUNT(*) AS negative_count
    FROM staging.medications
    WHERE base_cost < 0 
    OR payer_coverage < 0 
    OR totalcost < 0                    -- fixed column name
),
patient_negatives AS (
    SELECT COUNT(*) AS negative_count
    FROM staging.patients
    WHERE healthcare_expenses < 0 
    OR healthcare_coverage < 0
),
procedure_negatives AS (               -- fixed typo
    SELECT COUNT(*) AS negative_count
    FROM staging.procedures
    WHERE base_cost < 0
),
payer_negatives AS (
    SELECT COUNT(*) AS negative_count
    FROM staging.payers
    WHERE amount_covered < 0
    OR amount_uncovered < 0
    OR revenue < 0
),
organization_negatives AS (
    SELECT COUNT(*) AS negative_count
    FROM staging.organizations
    WHERE revenue < 0
    OR utilization < 0
),
supply_negatives AS (
    SELECT COUNT(*) AS negative_count
    FROM staging.supplies
    WHERE quantity < 0
)

SELECT
    'encounters - negative costs'       AS check_name,
    negative_count                      AS records_flagged,
    CASE WHEN negative_count = 0 
         THEN 'PASS' ELSE 'FAIL' END    AS status
FROM encounter_negatives

UNION ALL
SELECT 'immunizations - negative costs',    negative_count, CASE WHEN negative_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM immunization_negatives
UNION ALL
SELECT 'medications - negative costs',      negative_count, CASE WHEN negative_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM medication_negatives
UNION ALL
SELECT 'patients - negative costs',         negative_count, CASE WHEN negative_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM patient_negatives
UNION ALL
SELECT 'procedures - negative costs',       negative_count, CASE WHEN negative_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM procedure_negatives
UNION ALL
SELECT 'payers - negative costs',           negative_count, CASE WHEN negative_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM payer_negatives
UNION ALL
SELECT 'organizations - negative values',   negative_count, CASE WHEN negative_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM organization_negatives
UNION ALL
SELECT 'supplies - negative quantity',      negative_count, CASE WHEN negative_count = 0 THEN 'PASS' ELSE 'FAIL' END FROM supply_negatives

) checks
ORDER BY
    CASE WHEN status = 'FAIL' THEN 0 ELSE 1 END,
    records_flagged DESC,
    check_name;