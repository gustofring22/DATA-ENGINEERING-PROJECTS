-- Use RANK and DENSE_RANK to rank condition counts.
WITH condition_counts AS (
    SELECT
        patient_sk,
        condition_description,
        COUNT(DISTINCT condition_code) AS num_conditions
    FROM warehouse.fct_conditions
    GROUP BY patient_sk, condition_description
)
SELECT
    patient_sk,
    condition_description,
	SUM(num_conditions) OVER(
		PARTITION BY patient_sk
	) AS total_conditions,
    RANK() OVER (
        PARTITION BY patient_sk
        ORDER BY num_conditions DESC
    ) AS rank_num,
    DENSE_RANK() OVER (
        PARTITION BY patient_sk
        ORDER BY num_conditions DESC
    ) AS dense_rank_num,
    ROW_NUMBER() OVER (
        PARTITION BY patient_sk
        ORDER BY num_conditions DESC
    ) AS row_num
FROM condition_counts
ORDER BY total_conditions DESC;
