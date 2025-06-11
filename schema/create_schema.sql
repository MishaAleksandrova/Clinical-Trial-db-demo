CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) CHECK(gender IN ('M', 'F')),
    enrollment_date DATE NOT NULL
);

CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    visit_date DATE NOT NULL,
    visit_type TEXT CHECK (visit_type IN (
        'Screening',
        'Baseline',
        'Follow-up'
        )
    ),
    notes TEXT
);

CREATE TABLE labs (
    lab_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    test_name TEXT NOT NULL,
    test_result NUMERIC(5, 2),
    test_date DATE NOT NULL
);

CREATE TABLE adverse_events(
    event_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    event_description TEXT,
    severity TEXT CHECK (severity IN (
        'Mild',
        'Moderate',
        'Severe'
        )
    ),
    event_date DATE
);

CREATE TABLE medications (
    med_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    medication_name TEXT,
    dose TEXT,
    start_date DATE,
    end_date DATE
);