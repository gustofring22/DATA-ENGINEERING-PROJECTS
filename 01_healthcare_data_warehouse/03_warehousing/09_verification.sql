-- Verify warehousing row counts and results.
SELECT COUNT(*)
FROM warehouse.dim_patients
WHERE patient_id = '00431bef-4be7-4a41-bd42-7eca1803b797'
