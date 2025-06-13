CREATE OR REPLACE VIEW view_patient_summary AS
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(DISTINCT v.visit_id) AS total_visits,
    MAX(v.visit_date) AS last_visit_date,
    COUNT(DISTINCT ae.event_id) AS adverse_event_count
FROM patients p
LEFT JOIN visits v ON p.patient_id = v.patient_id
LEFT JOIN adverse_events ae ON p.patient_id = ae.patient_id
GROUP BY p.patient_id;