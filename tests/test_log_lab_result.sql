INSERT INTO patients (first_name, last_name, birth_date, gender, enrollment_date)
VALUES ('Lab', 'Test', '1985-01-01', 'F', CURRENT_DATE)
ON CONFLICT DO NOTHING;

-- Get the patient_id of the test patient
DO $$
DECLARE
    v_patient_id INT;
BEGIN
    SELECT patient_id INTO v_patient_id FROM patients WHERE last_name = 'Test' LIMIT 1;
    CALL log_lab_result(v_patient_id, 'Glucose', 5.5, 'mg/dL');
END;
$$;

-- Check if the lab result was inserted correctly
SELECT
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM labs l
            JOIN patients p ON l.patient_id = p.patient_id
            WHERE p.first_name = 'Lab' AND p.last_name = 'Test'
            AND l.test_name = 'Glucose' AND l.test_result = 5.5
        )
        THEN '✅ PASS: Lab result logged.'
        ELSE '❌ FAIL: Lab result NOT logged.'
    END AS test_result;

-- Cleanup inserted test data (optional)
DELETE FROM labs
WHERE test_name = 'Glucose' AND test_result = 5.5
AND patient_id = (SELECT patient_id FROM patients WHERE first_name = 'Lab' AND last_name = 'Test');

DELETE FROM patients WHERE first_name = 'Lab' AND last_name = 'Test';