-- Compare row counts between raw and staging.
SELECT
    tbl,
    raw_count,
    stg_count,
    raw_count - stg_count AS difference
FROM (
    SELECT 'patients'           AS tbl, COUNT(*) AS raw_count FROM raw.patients         WHERE id != 'Id'
    UNION ALL
    SELECT 'encounters',         COUNT(*) FROM raw.encounters        WHERE id != 'Id'
    UNION ALL
    SELECT 'conditions',         COUNT(*) FROM raw.conditions        WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'medications',        COUNT(*) FROM raw.medications       WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'procedures',         COUNT(*) FROM raw.procedures        WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'observations',       COUNT(*) FROM raw.observations      WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'allergies',          COUNT(*) FROM raw.allergies         WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'immunizations',      COUNT(*) FROM raw.immunizations     WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'careplans',          COUNT(*) FROM raw.careplans         WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'devices',            COUNT(*) FROM raw.devices           WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'imaging_studies',    COUNT(*) FROM raw.imaging_studies   WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'supplies',           COUNT(*) FROM raw.supplies          WHERE patient != 'PATIENT'
    UNION ALL
    SELECT 'organizations',      COUNT(*) FROM raw.organizations     WHERE id != 'Id'
    UNION ALL
    SELECT 'providers',          COUNT(*) FROM raw.providers         WHERE id != 'Id'
    UNION ALL
    SELECT 'payers',             COUNT(*) FROM raw.payers            WHERE id != 'Id'
    UNION ALL
    SELECT 'payer_transitions',  COUNT(*) FROM raw.payer_transitions WHERE patient != 'PATIENT'
) raw_counts
JOIN (
    SELECT 'patients'           AS tbl, COUNT(*) AS stg_count FROM staging.patients
    UNION ALL
    SELECT 'encounters',         COUNT(*) FROM staging.encounters
    UNION ALL
    SELECT 'conditions',         COUNT(*) FROM staging.conditions
    UNION ALL
    SELECT 'medications',        COUNT(*) FROM staging.medications
    UNION ALL
    SELECT 'procedures',         COUNT(*) FROM staging.procedures
    UNION ALL
    SELECT 'observations',       COUNT(*) FROM staging.observations
    UNION ALL
    SELECT 'allergies',          COUNT(*) FROM staging.allergies
    UNION ALL
    SELECT 'immunizations',      COUNT(*) FROM staging.immunizations
    UNION ALL
    SELECT 'careplans',          COUNT(*) FROM staging.careplans
    UNION ALL
    SELECT 'devices',            COUNT(*) FROM staging.devices
    UNION ALL
    SELECT 'imaging_studies',    COUNT(*) FROM staging.imaging_studies
    UNION ALL
    SELECT 'supplies',           COUNT(*) FROM staging.supplies
    UNION ALL
    SELECT 'organizations',      COUNT(*) FROM staging.organizations
    UNION ALL
    SELECT 'providers',          COUNT(*) FROM staging.providers
    UNION ALL
    SELECT 'payers',             COUNT(*) FROM staging.payers
    UNION ALL
    SELECT 'payer_transitions',  COUNT(*) FROM staging.payer_transitions
) stg_counts
USING (tbl)
ORDER BY tbl;