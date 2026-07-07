-- Fix medication date quality issues.
SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE start > stop) AS bad_date_count,
    ROUND(
        COUNT(*) FILTER (WHERE start > stop) 
        * 100.0 / NULLIF(COUNT(*), 0), 2)   AS pct_bad_dates
FROM staging.medications;

DELETE FROM staging.medications 
WHERE start > stop 
