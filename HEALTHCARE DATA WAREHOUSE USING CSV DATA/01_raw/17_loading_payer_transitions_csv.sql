TRUNCATE raw.payer_transitions;
\copy raw.payer_transitions (
    patient, start_year, end_year, payer, ownership
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/payer_transitions.csv'
WITH (FORMAT csv, HEADER true, NULL '');