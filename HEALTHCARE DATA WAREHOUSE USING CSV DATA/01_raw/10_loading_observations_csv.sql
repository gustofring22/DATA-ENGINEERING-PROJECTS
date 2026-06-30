TRUNCATE raw.observations;
\copy raw.observations (
    date, patient, encounter, code, description, value, units, type
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/observations.csv'
WITH (FORMAT csv, HEADER true, NULL '');