\copy raw.allergies (
    start, stop, patient, encounter, code, description
)
FROM 'C:\Users\Lewis Maina\Big Data\Data Engineering\HealthCare DE\data\allergies.csv'
WITH (FORMAT csv, HEADER true, NULL '');
