SELECT COUNT(*)
FROM warehouse.fct_encounters
UNION ALL
SELECT COUNT(*)
FROM staging.encounters