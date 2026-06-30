TRUNCATE raw.supplies;
\copy raw.supplies (
    date, patient, encounter, code, description, quantity
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/supplies.csv'
WITH (FORMAT csv, HEADER true, NULL '');