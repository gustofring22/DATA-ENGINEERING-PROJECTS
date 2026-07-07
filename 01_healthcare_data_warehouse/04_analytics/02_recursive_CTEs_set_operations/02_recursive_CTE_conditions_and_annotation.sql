-- Build a recursive condition hierarchy and annotate results.
WITH RECURSIVE condition_hierarchy AS (
	SELECT
        category                            AS node,
        category                            AS category,
        NULL::TEXT                          AS sub_category,
        NULL::BIGINT                        AS condition_code,
        NULL::TEXT                          AS condition_desc,
        category                            AS path,
        1                                   AS level
    FROM warehouse.ref_condition_categories
    GROUP BY category

    UNION ALL

    
    SELECT
        CASE h.level
            WHEN 1 THEN r.sub_category
            WHEN 2 THEN r.condition_desc
        END                                 AS node,
        r.category,
        CASE h.level
            WHEN 1 THEN r.sub_category
            WHEN 2 THEN r.sub_category
        END                                 AS sub_category,
        CASE h.level
            WHEN 1 THEN NULL::BIGINT
            WHEN 2 THEN r.condition_code
        END                                 AS condition_code,
        CASE h.level
            WHEN 1 THEN NULL::TEXT
            WHEN 2 THEN r.condition_desc
        END                                 AS condition_desc,
        CASE h.level
            WHEN 1 THEN h.path || ' > ' || r.sub_category
            WHEN 2 THEN h.path || ' > ' || r.condition_desc
        END                                 AS path,
        h.level + 1                         AS level
    FROM warehouse.ref_condition_categories r
    JOIN condition_hierarchy h
      ON r.category = h.category
     AND CASE h.level
            WHEN 1 THEN TRUE
            WHEN 2 THEN r.sub_category = h.sub_category
         END
    WHERE h.level < 3
    GROUP BY
        r.category,
        r.sub_category,
        r.condition_code,
        r.condition_desc,
        h.path,
        h.level
),

condition_paths AS (
    SELECT
        condition_code,
        category,
        sub_category,
        condition_desc,
        path                                AS full_category_path
    FROM condition_hierarchy
    WHERE level = 3
    AND condition_code IS NOT NULL
)


SELECT
    f.condition_sk,
    f.patient_sk,
    f.encounter_id,
    f.condition_code,
    f.condition_description,
    f.onset_date,
    f.resolution_date,
    COALESCE(cp.category,   'Uncategorised') AS category,
    COALESCE(cp.sub_category,'Uncategorised') AS sub_category,
    COALESCE(cp.full_category_path,
             'Uncategorised > ' ||
             f.condition_description
    )                                       AS full_category_path
FROM warehouse.fct_conditions f
LEFT JOIN condition_paths cp
       ON f.condition_code = cp.condition_code
ORDER BY
    cp.category,
    cp.sub_category,
    f.onset_date;