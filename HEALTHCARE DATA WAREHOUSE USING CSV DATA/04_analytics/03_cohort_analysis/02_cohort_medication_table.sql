WITH cohort retentioSELECT
    c.cohort_month,
    COUNT(DISTINCT c.patient_sk)                                        AS "Month 0",
    COUNT(DISTINCT CASE WHEN months_since = 1 THEN c.patient_sk END)   AS "Month 1",
    COUNT(DISTINCT CASE WHEN months_since = 2 THEN c.patient_sk END)   AS "Month 2",
    COUNT(DISTINCT CASE WHEN months_since = 3 THEN c.patient_sk END)   AS "Month 3",
    COUNT(DISTINCT CASE WHEN months_since = 4 THEN c.patient_sk END)   AS "Month 4",
    COUNT(DISTINCT CASE WHEN months_since = 5 THEN c.patient_sk END)   AS "Month 5",
    COUNT(DISTINCT CASE WHEN months_since = 6 THEN c.patient_sk END)   AS "Month 6"

FROM (
    SELECT
        c.patient_sk,
        c.cohort_month,
        EXTRACT(
            MONTH FROM AGE(
                DATE_TRUNC('month', e.encounter_start),
                c.cohort_month
            )
        )::INT    AS months_since
    FROM (
        SELECT
            patient_sk,
            DATE_TRUNC('month', MIN(onset_date))::DATE    AS cohort_month
        FROM warehouse.fct_conditions
        GROUP BY patient_sk
    ) c
    JOIN warehouse.fct_encounters e
      ON c.patient_sk = e.patient_sk
     AND e.encounter_start >= c.cohort_month
     AND e.encounter_start <  c.cohort_month + INTERVAL '7 months'
) c
GROUP BY c.cohort_month
ORDER BY c.cohort_month;