CREATE INDEX idx_dim_patients_patient_id
ON warehouse.dim_patients (patient_id);

CREATE INDEX idx_dim_patients_is_current
ON warehouse.dim_patients (is_current);
