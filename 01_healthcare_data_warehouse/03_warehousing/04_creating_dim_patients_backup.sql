-- Create a backup copy of the patient dimension.
CREATE TABLE warehouse.dim_patients_backup AS
SELECT * FROM warehouse.dim_patients;

