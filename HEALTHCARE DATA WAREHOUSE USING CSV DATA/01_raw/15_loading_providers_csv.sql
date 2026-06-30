TRUNCATE raw.providers;
\copy raw.providers (
    id, organization, name, gender, speciality, address, city,
    state, zip, lat, lon, utilization
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/providers.csv'
WITH (FORMAT csv, HEADER true, NULL '');