COMMENT ON TABLE warehouse.dim_patients IS 'Dimension table for patient demographics and SCD Type 2 History';

COMMENT ON COLUMN warehouse.dim_patients.patient_id IS 'Natural key from source system, used to track patient across loads';
COMMENT ON COLUMN warehouse.dim_patients.effective_date IS 'Date when this record version became valid';
COMMENT ON COLUMN warehouse.dim_patients.expiry_date IS 'Date when this record version expired (NULL if current)';
COMMENT ON COLUMN warehouse.dim_patients.record_hash IS 'MD5 hash of patient attributes for change detection';
COMMENT ON COLUMN warehouse.dim_patients.patient_sk IS 'Surrogate key that handles the history of patients';
