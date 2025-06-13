INSERT INTO sites (name, location, contact_info)
VALUES ('Test Site', 'Test City', 'test@example.com') ON CONFLICT DO NOTHING;

INSERT INTO investigators (first_name, last_name, role, contact_info)
VALUES ('Investigator', 'Test', 'Lead', 'inv@test.com') ON CONFLICT DO NOTHING;

-- Fetch IDs into variables inside a DO block, then CALL procedure
DO $$
DECLARE
    v_site_id INT;
    v_inv_id INT;
BEGIN
    SELECT site_id INTO v_site_id FROM sites WHERE name = 'Test Site' LIMIT 1;
    SELECT investigator_id INTO v_inv_id FROM investigators WHERE last_name = 'Test' LIMIT 1;

    CALL assign_investigator_to_site(v_site_id, v_inv_id);
END;
$$;

-- Validate result
SELECT
    CASE
        WHEN EXISTS (
            SELECT 1 FROM site_investigators si
            JOIN sites s ON si.site_id = s.site_id
            JOIN investigators i ON si.investigator_id = i.investigator_id
            WHERE s.name = 'Test Site' AND i.last_name = 'Test'
        ) THEN '✅ PASS: Investigator assigned to site.'
        ELSE '❌ FAIL: Investigator NOT assigned to site.'
    END AS test_result;

-- Cleanup
DELETE FROM site_investigators si
USING sites s, investigators i
WHERE si.site_id = s.site_id AND si.investigator_id = i.investigator_id
AND s.name = 'Test Site' AND i.last_name = 'Test';

DELETE FROM sites WHERE name = 'Test Site';
DELETE FROM investigators WHERE last_name = 'Test';
