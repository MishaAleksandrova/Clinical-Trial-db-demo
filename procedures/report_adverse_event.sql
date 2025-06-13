-- Procedure: report_adverse_event.sql
-- Description: Records an adverse event reported for a patient.


CREATE OR REPLACE PROCEDURE report_adverse_event(
    IN p_patient_id INT,
    IN p_description TEXT,
    IN p_severity TEXT,
    IN p_event_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM patients WHERE patient_id = p_patient_id) THEN
        RAISE EXCEPTION 'Patient ID % does not exist.', p_patient_id;
    END IF;

    IF p_severity NOT IN ('Mild', 'Moderate', 'Severe') THEN
        RAISE EXCEPTION 'Invalid severity: %', p_severity;
    END IF;

    INSERT INTO adverse_events (patient_id, event_description, severity, event_date)
    VALUES (p_patient_id, p_description, p_severity, p_event_date);
END;
$$;