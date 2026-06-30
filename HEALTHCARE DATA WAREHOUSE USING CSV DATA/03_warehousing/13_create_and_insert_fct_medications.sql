CREATE TABLE IF NOT EXISTS warehouse.medications(
	medication_sk 				SERIAL 		NOT NULL,
	patient_sk 					TEXT 		NOT NULL,
	encounter_id 				UUID 		NOT NULL,
	medication_code 			BIGINT,
	medication_description 		TEXT,
	start_date					DATE,
	stop_date 					DATE,
	base_cost					NUMERIC,
	loaded_at 					TIMESTAMP
);

INSERT INTO warehouse.medications(
	patient_sk,
	encounter_id,
	medication_code,
	medication_description,
	start_date,
	stop_date,
	base_cost,
	loaded_at
)

SELECT
	d.patient_sk			AS patient_sk,
	e.id 					AS encounter_id,
	m.code					AS medication_code,
	m.description 			AS medication_description,
	m.start					AS start_date,
	m.stop					AS stop_date,
	m.base_cost 			AS base_cost,
	NOW()
	FROM staging.medications m
	JOIN staging.encounters e
	ON e.id = m.encounter
	JOIN warehouse.dim_patients d
	ON d.patient_id = e.patient::TEXT
	AND d.is_current = TRUE;