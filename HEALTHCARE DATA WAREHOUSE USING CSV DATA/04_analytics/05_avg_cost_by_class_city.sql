SELECT 
    d.city,
    e.encounter_class,
    ROUND(AVG(e.total_claim_cost), 2)   AS avg_claim_cost
FROM warehouse.dim_patients d
JOIN warehouse.fct_encounters e
  ON d.patient_sk::TEXT = e.patient_sk
GROUP BY          
    d.city,
    e.encounter_class
ORDER BY avg_claim_cost DESC;