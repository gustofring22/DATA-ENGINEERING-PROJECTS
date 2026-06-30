TRUNCATE raw.careplans;
\copy raw.careplans (
    id, start, stop, patient, encounter, code, description
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/careplans.csv'
WITH (FORMAT csv, HEADER true, NULL '');