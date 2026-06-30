TRUNCATE raw.immunizations;
\copy raw.immunizations (
    date, patient, encounter, code, description, base_cost
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/immunizations.csv'
WITH (FORMAT csv, HEADER true, NULL '');