-- Check referential integrity in staging.
SELECT * FROM (

-- =============================================================
-- REFERENTIAL INTEGRITY CHECKS
-- Every query should return 0 — any result means broken reference
-- =============================================================

-- ENCOUNTERS
SELECT 'encounters → patients'              AS check_name,
       COUNT(*)                             AS records_flagged,
       CASE WHEN COUNT(*) = 0 
            THEN 'PASS' ELSE 'FAIL' END     AS status
FROM staging.encounters e
LEFT JOIN staging.patients p ON e.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL

-- CONDITIONS
SELECT 'conditions → patients',             COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.conditions c
LEFT JOIN staging.patients p ON c.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'conditions → encounters',           COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.conditions c
LEFT JOIN staging.encounters e ON c.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- MEDICATIONS
SELECT 'medications → patients',            COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.medications m
LEFT JOIN staging.patients p ON m.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'medications → encounters',          COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.medications m
LEFT JOIN staging.encounters e ON m.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- PROCEDURES
SELECT 'procedures → patients',             COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.procedures pr
LEFT JOIN staging.patients p ON pr.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'procedures → encounters',           COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.procedures pr
LEFT JOIN staging.encounters e ON pr.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- OBSERVATIONS
SELECT 'observations → patients',           COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.observations o
LEFT JOIN staging.patients p ON o.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'observations → encounters',         COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.observations o
LEFT JOIN staging.encounters e ON o.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- ALLERGIES
SELECT 'allergies → patients',              COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.allergies a
LEFT JOIN staging.patients p ON a.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'allergies → encounters',            COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.allergies a
LEFT JOIN staging.encounters e ON a.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- IMMUNIZATIONS
SELECT 'immunizations → patients',          COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.immunizations i
LEFT JOIN staging.patients p ON i.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'immunizations → encounters',        COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.immunizations i
LEFT JOIN staging.encounters e ON i.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- CAREPLANS
SELECT 'careplans → patients',              COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.careplans cp
LEFT JOIN staging.patients p ON cp.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'careplans → encounters',            COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.careplans cp
LEFT JOIN staging.encounters e ON cp.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- DEVICES
SELECT 'devices → patients',               COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.devices d
LEFT JOIN staging.patients p ON d.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'devices → encounters',             COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.devices d
LEFT JOIN staging.encounters e ON d.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- IMAGING STUDIES
SELECT 'imaging_studies → patients',       COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.imaging_studies img
LEFT JOIN staging.patients p ON img.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'imaging_studies → encounters',     COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.imaging_studies img
LEFT JOIN staging.encounters e ON img.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- SUPPLIES
SELECT 'supplies → patients',              COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.supplies s
LEFT JOIN staging.patients p ON s.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'supplies → encounters',            COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.supplies s
LEFT JOIN staging.encounters e ON s.encounter::TEXT = e.id::TEXT
WHERE e.id IS NULL

UNION ALL

-- ENCOUNTERS → REFERENCE TABLES
SELECT 'encounters → organizations',       COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.encounters e
LEFT JOIN staging.organizations o ON e.organization::TEXT = o.id::TEXT
WHERE o.id IS NULL

UNION ALL
SELECT 'encounters → providers',           COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.encounters e
LEFT JOIN staging.providers pr ON e.provider::TEXT = pr.id::TEXT
WHERE pr.id IS NULL

UNION ALL
SELECT 'encounters → payers',              COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.encounters e
LEFT JOIN staging.payers py ON e.payer::TEXT = py.id::TEXT
WHERE py.id IS NULL

UNION ALL

-- PAYER TRANSITIONS
SELECT 'payer_transitions → patients',     COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.payer_transitions pt
LEFT JOIN staging.patients p ON pt.patient::TEXT = p.id::TEXT
WHERE p.id IS NULL

UNION ALL
SELECT 'payer_transitions → payers',       COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.payer_transitions pt
LEFT JOIN staging.payers py ON pt.payer::TEXT = py.id::TEXT
WHERE py.id IS NULL

UNION ALL

-- PROVIDERS → ORGANIZATIONS
SELECT 'providers → organizations',        COUNT(*), CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM staging.providers pr
LEFT JOIN staging.organizations o ON pr.organization::TEXT = o.id::TEXT
WHERE o.id IS NULL

) checks
ORDER BY
    CASE WHEN status = 'FAIL' THEN 0 ELSE 1 END,
    records_flagged DESC,
    check_name;

--check_name              | records_flagged | status | notes
--observations→encounters | 43,488          | FAIL   | Source data issue —
--                        |                 |        | encounter IDs referenced
--                        |                 |        | in observations do not
--                        |                 |        | exist in source CSV.
--                        |                 |        | Confirmed not a load error.