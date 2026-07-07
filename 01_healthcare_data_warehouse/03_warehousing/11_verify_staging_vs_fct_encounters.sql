-- Compare staging data with the encounters fact table.
SELECT COUNT(*)
FROM warehouse.fct_encounters
UNION ALL
SELECT COUNT(*)
FROM staging.encounters