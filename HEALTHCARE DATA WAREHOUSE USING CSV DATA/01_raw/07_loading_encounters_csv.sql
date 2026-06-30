TRUNCATE raw.encounters;
\copy raw.encounters (
    id, start, stop, patient, organization, provider, payer,
    encounterclass, code, description, base_encounter_cost,
    total_claim_cost, payer_coverage
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/encounters.csv'
WITH (FORMAT csv, HEADER true, NULL '');