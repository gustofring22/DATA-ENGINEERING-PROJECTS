TRUNCATE raw.medications;
\copy raw.medications (
    start, stop, patient, payer, encounter, code, description,
    base_cost, payer_coverage, dispenses, totalcost, reasoncode, reasondescription
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/medications.csv'
WITH (FORMAT csv, HEADER true, NULL '');