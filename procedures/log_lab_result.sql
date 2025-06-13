-- Procedure: log_lab_results.sql
-- Description: Records a new lab test result for a patient.


CREATE OR REPLACE PROCEDURE log_lab_result(
    p_patient_id INT,
    p_test_name TEXT,
    p_test_result NUMERIC,
    p_test_unit TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO labs (patient_id, test_name, test_result, test_date)
    VALUES (p_patient_id, p_test_name, p_test_result, CURRENT_DATE);
END;
$$;