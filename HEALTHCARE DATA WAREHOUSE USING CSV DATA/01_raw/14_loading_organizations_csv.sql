TRUNCATE raw.organizations;
\copy raw.organizations (
    id, name, address, city, state, zip, lat, lon, phone,
    revenue, utilization
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/organizations.csv'
WITH (FORMAT csv, HEADER true, NULL '');