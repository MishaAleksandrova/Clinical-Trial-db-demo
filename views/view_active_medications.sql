CREATE OR REPLACE VIEW view_active_medications AS
SELECT
    m.patient_id,
    p.first_name,
    p.last_name,
    m.medication_name,
    m.dose,
    m.start_date,
    m.end_date
FROM medications m
JOIN patients p ON p.patient_id = m.patient_id
WHERE CURRENT_DATE BETWEEN m.start_date AND m.end_date;
