--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-mns-alter.sql

--Student ID:33684669
--Student Name:Shruthi Shashidhara Shastry
--Unit Code:FIT9132
--Applied Class No:A01 wednesday 8am G16

/* Comments for your marker:
After normalistaion the resulting table is nurse_training_details

*/

--4(a)

ALTER TABLE patient ADD (
    total_appointments NUMBER(2) DEFAULT 0 NOT NULL
);

DESC patient;

SELECT
    *
FROM
    patient;

UPDATE PATIENT p 
SET total_appointments = (
    SELECT COUNT(appt_no)
    FROM APPOINTMENT a
    where a.patient_no = p.patient_no
);

COMMIT;

SELECT
    *
FROM
    patient;
    

--4(b)

SELECT
    *
FROM
    patient;
     
DROP TABLE patient_emergencyContact CASCADE CONSTRAINTS;

CREATE TABLE patient_emergencyContact as select patient_no,ec_id from patient;   

COMMENT ON COLUMN patient_emergencyContact.patient_no IS
    'Patient number (unique) from patient table';

COMMENT ON COLUMN patient_emergencyContact.ec_id IS
    'Emergency contact identifier from emergencyContact table';
    
ALTER TABLE patient_emergencycontact ADD CONSTRAINT patient_emergencycontact_pk PRIMARY KEY ( patient_no,
                                                                                              ec_id );

ALTER TABLE patient_emergencycontact
    ADD CONSTRAINT patient_emergencycontact_patientfk FOREIGN KEY ( patient_no )
        REFERENCES patient ( patient_no );
        
ALTER TABLE patient_emergencycontact
    ADD CONSTRAINT patient_emergencycontact_ecfk FOREIGN KEY ( ec_id )
        REFERENCES emergency_contact ( ec_id );
        
desc patient_emergencyContact;

SELECT
    *
FROM
    patient_emergencycontact;

ALTER TABLE patient DROP column ec_id;

desc patient;

SELECT
    *
FROM
    patient;
 
--4(c)

DROP TABLE nurse_training_details CASCADE CONSTRAINTS;

CREATE TABLE nurse_training_details (

    nurse_train_id   NUMBER(3) NOT NULL,
    nurse_trainee_no NUMBER(3) NOT NULL,
    nurse_trainer_no NUMBER(3) NOT NULL,
    start_date_time  DATE NOT NULL,
    end_date_time    DATE NOT NULL,
    description      VARCHAR2(40) NOT NULL
);

COMMENT ON COLUMN nurse_training_details.nurse_train_id IS
    'Nurse training details Identifier (surrogate key)';

COMMENT ON COLUMN nurse_training_details.nurse_trainee_no IS
    'Trainee nurse number (unique)';

COMMENT ON COLUMN nurse_training_details.nurse_trainer_no IS
    'Trainer nurse number (unique)';
    
COMMENT ON COLUMN nurse_training_details.start_date_time IS
    'Training start date and time(unique)';

COMMENT ON COLUMN nurse_training_details.end_date_time IS
    'Training end date and time';

COMMENT ON COLUMN nurse_training_details.description IS
    'Training Description';
    
ALTER TABLE nurse_training_details ADD CONSTRAINT nurse_training_details_pk PRIMARY KEY ( nurse_train_id );

ALTER TABLE nurse_training_details ADD CONSTRAINT nurse_training_details_unique UNIQUE ( nurse_trainee_no,nurse_trainer_no,start_date_time );

ALTER TABLE nurse_training_details
    ADD CONSTRAINT nurse_training_details_traineeNurse_FK FOREIGN KEY ( nurse_trainee_no )
        REFERENCES nurse ( nurse_no );
        
ALTER TABLE nurse_training_details
    ADD CONSTRAINT nurse_training_details_NurseTrainer_FK FOREIGN KEY (nurse_trainer_no )
        REFERENCES nurse ( nurse_no );

Desc nurse_training_details;



