-- Insert patient
INSERT INTO patients (first_name, last_name, birth_date, gender, enrollment_date)
VALUES ('Adverse', 'Test', '1980-01-01', 'F', CURRENT_DATE)
ON CONFLICT DO NOTHING;

-- Call the procedure in a DO block
DO $$
DECLARE
    v_patient_id INT;
BEGIN
    SELECT patient_id INTO v_patient_id FROM patients WHERE last_name = 'Test' LIMIT 1;
    CALL report_adverse_event(v_patient_id, 'Headache', 'Mild', CURRENT_DATE);
END;
$$;

-- Validate
SELECT CASE
    WHEN EXISTS (
        SELECT 1 FROM adverse_events
        WHERE event_description = 'Headache'
        AND patient_id = (SELECT patient_id FROM patients WHERE last_name = 'Test')
    )
    THEN '✅ PASS: Adverse event recorded.'
    ELSE '❌ FAIL: Adverse event not recorded.'
END AS test_result;

-- Cleanup
DELETE FROM adverse_events WHERE event_description = 'Headache';
DELETE FROM patients WHERE last_name = 'Test';