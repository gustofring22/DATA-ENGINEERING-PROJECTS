WITH cohort AS (
    SELECT
        patient_sk,
        DATE_TRUNC('month', MIN(onset_date))::DATE    AS cohort_month,
        MIN(onset_date)                               AS first_onset_date
    FROM warehouse.fct_conditions
    GROUP BY patient_sk
)

SELECT
	c.cohort_month,
	COUNT(m.medication_code) AS total_medication
FROM cohort c
JOIN warehouse.fct_medications m
ON c.patient_sk::TEXT = m.patient_sk::TEXT
GROUP BY c.cohort_month
			
ORDER BY total_medication DESC