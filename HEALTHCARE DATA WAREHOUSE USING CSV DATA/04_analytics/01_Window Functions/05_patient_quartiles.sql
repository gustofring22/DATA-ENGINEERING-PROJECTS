WITH patient_totals AS (
    
    SELECT
        patient_sk,
        SUM(base_cost)              AS total_medication_cost
    FROM warehouse.fct_medications
    GROUP BY patient_sk             
),
quartiles AS (
    
    SELECT
        patient_sk,
        total_medication_cost,
        NTILE(4) OVER (
            ORDER BY total_medication_cost ASC  
        )                           AS quartile
    FROM patient_totals
)

SELECT
    patient_sk,
    total_medication_cost,
    quartile,
    CASE quartile
        WHEN 1 THEN 'Bronze'
        WHEN 2 THEN 'Silver'
        WHEN 3 THEN 'Gold'
        WHEN 4 THEN 'Platinum'
    END                             AS quartile_label
FROM quartiles
ORDER BY total_medication_cost DESC;