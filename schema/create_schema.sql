CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) CHECK(gender IN ('M', 'F')),
    enrollment_date DATE NOT NULL
);

CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    visit_date DATE NOT NULL,
    visit_type VARCHAR(50) CHECK (visit_type IN (
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
    medication_name VARCHAR(100),
    dose VARCHAR(50),
    start_date DATE,
    end_date DATE
);

CREATE TABLE sites (
    site_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    contact_info TEXT
);

CREATE TABLE investigators (
    investigator_id SERIAL PRIMARY KEY,
    first_name VARCHAR (100),
    last_name VARCHAR(100),
    role VARCHAR(100),
    contact_info TEXT
);

CREATE TABLE protocols (
    protocol_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    approval_date DATE,
    status VARCHAR(50) CHECK (status IN (
        'Draft',
        'Approved',
        'Completed',
        'Terminated'
    ))
);

CREATE TABLE site_investigators (
    site_id INT NOT NULL REFERENCES sites(site_id) ON DELETE CASCADE,
    investigator_id INT NOT NULL REFERENCES investigators(investigator_id) ON DELETE CASCADE,
    PRIMARY KEY (site_id, investigator_id)
);

CREATE TABLE protocol_sites (
    protocol_id INT NOT NULL REFERENCES protocols(protocol_id) ON DELETE CASCADE,
    site_id INT NOT NULL REFERENCES sites(site_id) ON DELETE CASCADE,
    PRIMARY KEY, (protocol_id, site_id)
);

CREATE TABLE protocol_investigators (
    protocol_id INT NOT NULL REFERENCES protocols(protocol_id) ON DELETE CASCADE,
    investigator_id INT NOT NULL REFERENCES investigators(investigator_id) ON DELETE CASCADE,
    PRIMARY KEY (protocol_id, investigator_id)
);

