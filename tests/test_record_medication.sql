INSERT INTO patients (first_name, last_name, birth_date, gender, enrollment_date)
VALUES ('Med', 'Test', '1990-01-01', 'M', CURRENT_DATE) ON CONFLICT DO NOTHING;

DO $$
DECLARE
    v_patient_id INT;
BEGIN
    SELECT patient_id INTO v_patient_id FROM patients WHERE last_name = 'Test' LIMIT 1;
    CALL record_medication(
    v_patient_id,
    'Aspirin',
    '100mg',
    CURRENT_DATE,
    (CURRENT_DATE + INTERVAL '7 days')::DATE
);
END;
$$;

SELECT
    CASE
        WHEN EXISTS (
            SELECT 1 FROM medications
            WHERE medication_name = 'Aspirin'
            AND patient_id = (SELECT patient_id FROM patients WHERE first_name = 'Med' AND last_name = 'Test')
        ) THEN '✅ PASS: Medication recorded.'
        ELSE '❌ FAIL: Medication NOT recorded.'
    END AS test_result;

DELETE FROM medications
WHERE medication_name = 'Aspirin'
AND patient_id = (SELECT patient_id FROM patients WHERE first_name = 'Med' AND last_name = 'Test');

DELETE FROM patients WHERE first_name = 'Med' AND last_name = 'Test';