--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-mns-schema.sql

--Student ID:33684669
--Student Name:Shruthi Shashidhara Shastry
--Unit Code:FIT9132
--Applied Class No: A01 Wednesday 8am class G16 room

/* Comments for your marker:
*/

-- Task 1 Add Create table statements for the white TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script


-- TABLE: APPOINTMENT
CREATE TABLE appointment (
    appt_no           NUMBER(7) NOT NULL,
    appt_datetime     DATE NOT NULL,
    appt_roomno       NUMBER(2) NOT NULL,
    appt_length       CHAR(1) NOT NULL,
    patient_no        NUMBER(4) NOT NULL,
    provider_code     CHAR(6) NOT NULL,
    nurse_no          NUMBER(3) NOT NULL,
    appt_prior_apptno NUMBER(7)
);

COMMENT ON COLUMN appointment.appt_no IS
    'Appointment number (identifier)';

COMMENT ON COLUMN appointment.appt_datetime IS
    'Date and time of the appointment';

COMMENT ON COLUMN appointment.appt_roomno IS
    'Room in which appointment is scheduled to take place';

COMMENT ON COLUMN appointment.appt_length IS
    'Aength of appointment - Short, Standard or Long (S,T or L)';

COMMENT ON COLUMN appointment.patient_no IS
    'Patient who books the appointment';

COMMENT ON COLUMN appointment.provider_code IS
    'Provider who is assigned to the appointment';

COMMENT ON COLUMN appointment.nurse_no IS
    'Nurse who is assigned to the appointment';

COMMENT ON COLUMN appointment.appt_prior_apptno IS
    'Prior appointment number which leads to this appointment (unique)';

ALTER TABLE appointment ADD CONSTRAINT appointment_pk PRIMARY KEY ( appt_no );

ALTER TABLE appointment
    ADD CONSTRAINT appointment_chk CHECK ( appt_length IN ( 'S', 'T', 'L' ) );

ALTER TABLE appointment
    ADD CONSTRAINT appointment_unique UNIQUE ( appt_datetime,
                                               appt_roomno,
                                               patient_no,
                                               provider_code,
                                               appt_prior_apptno );
                                               
                                               
-- TABLE: EMERGENCY_CONTACT
CREATE TABLE emergency_contact (
    ec_id    NUMBER(4) NOT NULL,
    ec_fname VARCHAR2(30),
    ec_lname VARCHAR2(30),
    ec_phone CHAR(10) NOT NULL
);

COMMENT ON COLUMN emergency_contact.ec_id IS
    'Emergency contact identifier';

COMMENT ON COLUMN emergency_contact.ec_fname IS
    'Emergency contact first name';

COMMENT ON COLUMN emergency_contact.ec_lname IS
    'Emergency contact last name';

COMMENT ON COLUMN emergency_contact.ec_phone IS
    'Emergency contact phone number';

ALTER TABLE emergency_contact ADD CONSTRAINT emergency_contact_pk PRIMARY KEY ( ec_id );

ALTER TABLE emergency_contact ADD CONSTRAINT emergency_contact_unique UNIQUE ( ec_phone );

-- TABLE: PATIENT

CREATE TABLE patient (
    patient_no            NUMBER(4) NOT NULL,
    patient_fname         VARCHAR2(30),
    patient_lname         VARCHAR2(30),
    patient_street        VARCHAR2(50) NOT NULL,
    patient_city          VARCHAR2(20) NOT NULL,
    patient_state         VARCHAR2(3) NOT NULL,
    patient_postcode      CHAR(4) NOT NULL,
    patient_dob           DATE NOT NULL,
    patient_contactmobile CHAR(10) NOT NULL,
    patient_contactemail  VARCHAR2(25) NOT NULL,
    ec_id                 NUMBER(4) NOT NULL
);

COMMENT ON COLUMN patient.patient_no IS
    'Patient number (unique for each patient)';

COMMENT ON COLUMN patient.patient_fname IS
    'Patient first name';

COMMENT ON COLUMN patient.patient_lname IS
    'Patient last name';

COMMENT ON COLUMN patient.patient_street IS
    'Patient residential street address';

COMMENT ON COLUMN patient.patient_city IS
    'Patient residential city';

COMMENT ON COLUMN patient.patient_state IS
    'Patient residential state';

COMMENT ON COLUMN patient.patient_postcode IS
    'Patient residential postcode';

COMMENT ON COLUMN patient.patient_dob IS
    'Patient date of birth';

COMMENT ON COLUMN patient.patient_contactmobile IS
    'Patient contact mobile number';

COMMENT ON COLUMN patient.patient_contactemail IS
    'Patient contact email address';

COMMENT ON COLUMN patient.ec_id IS
    'Patient emergency contact identifier';

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patient_no );

ALTER TABLE patient
    ADD CONSTRAINT patient_state_chk CHECK ( patient_state IN ( 'NT', 'QLD', 'NSW', 'ACT', 'VIC',
                                                                'TAS', 'SA', 'WA' ) );

-- Add all missing FK Constraints below here

ALTER TABLE appointment
    ADD CONSTRAINT appt_patient_fk FOREIGN KEY ( patient_no )
        REFERENCES patient ( patient_no );

ALTER TABLE appointment
    ADD CONSTRAINT appt_provider_fk FOREIGN KEY ( provider_code )
        REFERENCES provider ( provider_code );

ALTER TABLE appointment
    ADD CONSTRAINT appt_nurse_fk FOREIGN KEY ( nurse_no )
        REFERENCES nurse ( nurse_no );

ALTER TABLE appointment
    ADD CONSTRAINT appt_followup_fk FOREIGN KEY ( appt_prior_apptno )
        REFERENCES appointment ( appt_no );

ALTER TABLE patient
    ADD CONSTRAINT patient_emergcontact_fk FOREIGN KEY ( ec_id )
        REFERENCES emergency_contact ( ec_id );