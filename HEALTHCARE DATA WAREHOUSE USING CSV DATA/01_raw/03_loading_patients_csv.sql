TRUNCATE raw.patients
\copy raw.patients (
    id, birthdate, deathdate, ssn, drivers, passport, prefix, first, last, suffix,
    maiden, marital, race, ethnicity, gender, birthplace, address, city, state,
    county, zip, lat, lon, healthcare_expenses, healthcare_coverage
)
FROM 'C:\Users\Lewis Maina\Big Data\Data Engineering\HealthCare DE\data\patients.csv'
WITH (FORMAT csv, HEADER true, NULL '',ENCODING 'WIN1252');
