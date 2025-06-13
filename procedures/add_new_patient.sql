-- Procedure: add_new_patient.sql
-- Description: Inserts a new patient into the system.

CREATE OR REPLACE PROCEDURE add_new_patient(
    IN first_name TEXT,
    IN last_name TEXT,
    IN birth_date DATE,
    IN gender CHAR(1),
    IN enrollment_date DATE
)

LANGUAGE plpgsql
AS $$
BEGIN
    IF LENGTH(first_name) > 100 THEN
        RAISE EXCEPTION 'First name too long (max 100 chars)';
    END IF;
    IF LENGTH(last_name) > 100 THEN
        RAISE EXCEPTION 'Last name too long (max 100 chars)';
    END IF;
    IF gender NOT IN ('M', 'F') THEN
        RAISE EXCEPTION 'Invalid gender. Must be M or F.';
    END IF;

    -- Insert new patient
    INSERT INTO patients (
        first_name,
        last_name,
        birth_date,
        gender,
        enrollment_date
    )
    VALUES (
        first_name,
        last_name,
        birth_date,
        gender,
        enrollment_date
    );
END;
$$;


