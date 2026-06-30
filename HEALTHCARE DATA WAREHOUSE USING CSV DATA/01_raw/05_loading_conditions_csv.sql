TRUNCATE raw.conditions;
\copy raw.conditions (
    id, start, stop, patient, encounter, code, description
)
FROM 'C:/Users/Lewis Maina/Big Data\Data Engineering\HealthCare DE\data\conditions.csv'
WITH (FORMAT csv, HEADER true, NULL '');