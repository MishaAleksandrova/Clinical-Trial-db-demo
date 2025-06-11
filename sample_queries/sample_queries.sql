-- 1. List all patients along with their most recent visit date
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    MAX(v.visit_date) AS last_visit
FROM
    patients p
LEFT JOIN
    visits v ON p.patient_id = v.patient_id
GROUP BY
    p.patient_id, p.first_name, p.last_name;

-- 2. Patients who experienced more than 2 adverse events
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(*) AS adverse_event_count
FROM
    patients p
JOIN
    adverse_events ae ON p.patient_id = ae.patient_id
GROUP BY
    p.patient_id, p.first_name, p.last_name
HAVING
    COUNT(*) > 2;

-- 3. Average test result per test_name
SELECT
    test_name,
    ROUND(AVG(test_result), 2) AS average_result
FROM
    labs
GROUP BY
    test_name;

-- 4. Current medications (where end_date is NULL)
SELECT
    patient_id,
    medication_name,
    dose,
    start_date
FROM
    medications
WHERE
    end_date IS NULL;

-- 5. All investigators working at a specific site (e.g., site_id = 1)
SELECT
    s.name AS site_name,
    i.first_name,
    i.last_name,
    i.role
FROM
    site_investigators si
JOIN
    sites s ON si.site_id = s.site_id
JOIN
    investigators i ON si.investigator_id = i.investigator_id
WHERE
    si.site_id = 1;


-- 6. Lab test results for patients with Severe adverse events
SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    l.test_name,
    l.test_result,
    l.test_date
FROM
    patients p
JOIN
    adverse_events ae ON p.patient_id = ae.patient_id
JOIN
    labs l ON p.patient_id = l.patient_id
WHERE
    ae.severity = 'Severe';

-- 7. All visits with notes containing the word 'lorem'
SELECT
    visit_id,
    patient_id,
    visit_date,
    notes
FROM
    visits
WHERE
    LOWER(notes) LIKE '%lorem%';