-- Procedure: record_medication.sql
-- Description: Logs medication given to a patient with dose and duration.

CREATE OR REPLACE PROCEDURE record_medication(
    IN p_patient_id INT,
    IN p_medication_name VARCHAR(100),
    IN p_dose VARCHAR(50),
    IN p_start_date DATE,
    IN p_end_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM patients WHERE patient_id = p_patient_id) THEN
        RAISE EXCEPTION 'Patient ID % does not exist.', p_patient_id;
    END IF;

    INSERT INTO medications (patient_id, medication_name, dose, start_date, end_date)
    VALUES (p_patient_id, p_medication_name, p_dose, p_start_date, p_end_date);
END;
$$;