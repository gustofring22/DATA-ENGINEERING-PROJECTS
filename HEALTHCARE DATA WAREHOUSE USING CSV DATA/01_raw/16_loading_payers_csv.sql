TRUNCATE raw.payers;
\copy raw.payers (
    id, name, address, city, state_headquartered, zip, phone,
    amount_covered, amount_uncovered, revenue, covered_encounters,
    uncovered_encounters, covered_medications, uncovered_medications,
    covered_procedures, uncovered_procedures, covered_immunizations,
    uncovered_immunizations, unique_customers, qols_avg, member_months
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/payers.csv'
WITH (FORMAT csv, HEADER true, NULL '');