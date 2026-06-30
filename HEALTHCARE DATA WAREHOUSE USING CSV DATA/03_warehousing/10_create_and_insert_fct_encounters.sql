CREATE TABLE IF NOT EXISTS warehouse.fct_encounters(
	encounter_sk 		SERIAL 	PRIMARY KEY,
	encounter_id 		UUID	NOT NULL,
	patient_sk 			TEXT	NOT NULL,
	encounter_class 	TEXT,
	encounter_start 	DATE,
	encounter_stop 		DATE,
	base_cost 			NUMERIC,
	payer_coverage 		NUMERIC,
	total_claim_cost	NUMERIC,
	loaded_at 			TIMESTAMP
);

INSERT INTO warehouse.fct_encounters(
	encounter_id,
	patient_sk,
	encounter_class,
	encounter_start,
	encounter_stop,
	base_cost,
	payer_coverage,
	total_claim_cost,
	loaded_at
)

SELECT
    e.id                                AS encounter_id,
    d.patient_sk                        AS patient_sk,
    e.encounterclass                    AS encounter_class,
    e.start                             AS encounter_start,
    e.stop                              AS encounter_stop,
    e.base_encounter_cost               AS base_cost,
    e.total_claim_cost                  AS total_claim_cost,
    e.payer_coverage                    AS payer_coverage,
    NOW()                               AS loaded_at
FROM staging.encounters e
JOIN warehouse.dim_patients d           
  ON e.patient::TEXT = d.patient_id
AND d.is_current = TRUE
