CREATE OR REPLACE VIEW view_investigator_assigments AS
SELECT
    i.investigator_id,
    i.first_name,
    i.last_name,
    i.role,
    s.name AS site_name
FROM site_investigators si
JOIN investigators i ON si.investigator_id = i.investigator_id
JOIN sites s ON si.site_id = s.site_id;