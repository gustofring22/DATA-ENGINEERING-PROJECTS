-- Build a patient medication cohort.
WITH cohort AS (
    SELECT
        patient_sk,
        DATE_TRUNC('month', MIN(onset_date))::DATE    AS cohort_month,
        MIN(onset_date)                               AS first_onset_date
    FROM warehouse.fct_conditions
    GROUP BY patient_sk
),


cohort_size AS (
    SELECT
        cohort_month,
        COUNT(patient_sk)          AS total_patients
    FROM cohort
    GROUP BY cohort_month
),


followup AS (
    SELECT
        c.cohort_month,
        COUNT(DISTINCT c.patient_sk)   AS patients_with_followup
    FROM cohort c
    JOIN warehouse.fct_encounters e
      ON c.patient_sk = e.patient_sk
     AND e.encounter_start BETWEEN c.first_onset_date
                               AND c.first_onset_date + INTERVAL '30 days'
    GROUP BY c.cohort_month
),


medications AS (
    SELECT
        c.cohort_month,
        AVG(med_count)             AS avg_medications
    FROM cohort c
    JOIN (
        SELECT
            m.patient_sk,
            COUNT(*)               AS med_count
        FROM warehouse.fct_medications m
        JOIN cohort co ON m.patient_sk = co.patient_sk
        WHERE m.start_date BETWEEN co.first_onset_date
                               AND co.first_onset_date + INTERVAL '12 months'
        GROUP BY m.patient_sk
    ) med_counts ON c.patient_sk = med_counts.patient_sk
    GROUP BY c.cohort_month
)


SELECT
    cs.cohort_month,
    cs.total_patients,
    COALESCE(f.patients_with_followup, 0)             AS patients_with_followup,
    ROUND(
        COALESCE(f.patients_with_followup, 0) * 100.0
        / cs.total_patients, 1
    )                                                  AS followup_pct,
    ROUND(COALESCE(m.avg_medications, 0), 2)           AS avg_medications_12m

FROM cohort_size cs
LEFT JOIN followup   f ON cs.cohort_month = f.cohort_month
LEFT JOIN medications m ON cs.cohort_month = m.cohort_month
ORDER BY cs.cohort_month;