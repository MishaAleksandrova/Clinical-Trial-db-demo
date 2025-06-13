CALL add_new_patient(
    'Unit',
    'Test',
    '1980-01-01',
    'M',
    '2025-06-01'
);

SELECT
    CASE
        WHEN EXISTS (
            SELECT 1 FROM patients
            WHERE first_name = 'Unit' AND last_name = 'Test'
        ) THEN '✅ PASS: Patient was inserted.'
        ELSE '❌ FAIL: Patient was NOT inserted.'
    END AS test_result;

DELETE FROM patients
WHERE first_name = 'Unit' AND last_name='Test';