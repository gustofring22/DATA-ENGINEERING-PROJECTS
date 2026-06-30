BEGIN;
-- Step 1: Capture brand new patients
CREATE TEMP TABLE new_records AS
SELECT s.*
FROM staging.patients s
WHERE NOT EXISTS (
	SELECT 1
	FROM warehouse.dim_patients d
	WHERE s.id::TEXT = d.patient_id
);

INSERT INTO warehouse.dim_patients (
	patient_id, full_name, birthdate, gender, race, ethnicity,
	marital_status, city, state, zip,
	effective_date, expiry_date, is_current, record_hash, loaded_at
)
SELECT 
	s.id,
	s.first || ' ' || s.last AS full_name,
	s.birthdate, s.gender, s.race, s.ethnicity,
	s.marital, s.city, s.state, s.zip,
	CURRENT_DATE, NULL, TRUE,
	MD5(CONCAT(
		COALESCE(s.marital, 'NULL'), '|',
		COALESCE(s.city, 'NULL'), '|',
		COALESCE(s.state, 'NULL'), '|',
		COALESCE(s.zip, 'NULL')
	)),
	NOW()
FROM new_records s;

-- Step 2: Capture changed patients
CREATE TEMP TABLE changed_records AS
SELECT s.*
FROM staging.patients s
JOIN warehouse.dim_patients d
  ON s.id::TEXT = d.patient_id
 AND d.is_current = TRUE
WHERE MD5(CONCAT(
		COALESCE(s.marital, 'NULL'), '|',
		COALESCE(s.city, 'NULL'), '|',
		COALESCE(s.state, 'NULL'), '|',
		COALESCE(s.zip, 'NULL')
	)) != d.record_hash;

UPDATE warehouse.dim_patients d
SET expiry_date = CURRENT_DATE - 1,
	is_current = FALSE
FROM changed_records c
WHERE d.patient_id = c.id::TEXT
  AND d.is_current = TRUE;

INSERT INTO warehouse.dim_patients (
	patient_id, full_name, birthdate, gender, race, ethnicity,
	marital_status, city, state, zip,
	effective_date, expiry_date, is_current, record_hash, loaded_at
)
SELECT 
	c.id,
	c.first || ' ' || c.last AS full_name,
	c.birthdate, c.gender, c.race, c.ethnicity,
	c.marital, c.city, c.state, c.zip,
	CURRENT_DATE, NULL, TRUE,
	MD5(CONCAT(
		COALESCE(c.marital, 'NULL'), '|',
		COALESCE(c.city, 'NULL'), '|',
		COALESCE(c.state, 'NULL'), '|',
		COALESCE(c.zip, 'NULL')
	)),
	NOW()
FROM changed_records c;
COMMIT;
