-- Calculate a running total with SUM over a window.
SELECT
	patient_sk,
	encounter_start,
	SUM(total_claim_cost) OVER (PARTITION BY patient_sk ORDER BY encounter_start) AS running_total
FROM warehouse.fct_encounters
	