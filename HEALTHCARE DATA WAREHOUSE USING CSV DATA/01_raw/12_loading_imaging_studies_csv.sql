TRUNCATE raw.imaging_studies;
\copy raw.imaging_studies (
    id, date, patient, encounter, bodysite_code, bodysite_description,
    modality_code, modality_description, sop_code, sop_description
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/imaging_studies.csv'
WITH (FORMAT csv, HEADER true, NULL '');