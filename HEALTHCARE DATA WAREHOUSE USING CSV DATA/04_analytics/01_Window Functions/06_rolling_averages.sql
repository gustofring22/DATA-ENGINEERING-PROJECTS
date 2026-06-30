SELECT
    patient_sk,
    encounter_sk,
    encounter_start,
    base_cost,
    ROUND(
        AVG(base_cost) OVER (
            PARTITION BY patient_sk
            ORDER BY encounter_start
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_avg_cost_3enc

FROM warehouse.fct_encounters
ORDER BY patient_sk, encounter_start;