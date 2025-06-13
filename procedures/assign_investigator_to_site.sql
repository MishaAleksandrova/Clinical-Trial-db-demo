-- Procedure: assign_investigator_to_site.sql
-- Description: Links an investigator to a clinical site.

CREATE OR REPLACE PROCEDURE assign_investigator_to_site(
    IN p_site_id INT,
    IN p_investigator_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM sites WHERE site_id = p_site_id) THEN
        RAISE EXCEPTION 'Site ID % does not exist.', p_site_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM investigators WHERE investigator_id = p_investigator_id) THEN
        RAISE EXCEPTION 'Investigator ID % does not exist.', p_investigator_id;
    END IF;

    INSERT INTO site_investigators (site_id, investigator_id)
    VALUES (p_site_id, p_investigator_id)
    ON CONFLICT DO NOTHING;
END;
$$;