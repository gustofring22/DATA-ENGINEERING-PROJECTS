TRUNCATE raw.procedures;
\copy raw.procedures (
    date, patient, encounter, code, description, base_cost,
    reasoncode, reasondescription
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/procedures.csv'
WITH (FORMAT csv, HEADER true, NULL '');