TRUNCATE raw.devices;
\copy raw.devices (
    id, start, stop, patient, encounter, code, description
)
FROM 'C:/Users/Lewis Maina/Big Data/Data Engineering/HealthCare DE/data/devices.csv'
WITH (FORMAT csv, HEADER true, NULL '');