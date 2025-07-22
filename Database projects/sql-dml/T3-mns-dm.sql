--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-dm.sql

--Student ID:33684669
--Student Name:Shruthi Shashidhara Shastry
--Unit Code:FIT9132
--Applied Class No:A01 Wednesday 8 am class G16

/* Comments for your marker:

I have added selected select stattements after insert, update and delete to see the changes done to db.

*/

--3(a)

DROP SEQUENCE emergencycontact_seq;

DROP SEQUENCE patient_seq;

DROP SEQUENCE appointment_seq;

CREATE SEQUENCE emergencycontact_seq START WITH 100 INCREMENT BY 5;

CREATE SEQUENCE patient_seq START WITH 100 INCREMENT BY 5;

CREATE SEQUENCE appointment_seq START WITH 100 INCREMENT BY 5;

--SELECT
--    *
--FROM
--    cat;

--3(b)

INSERT INTO emergency_contact VALUES (
    emergencycontact_seq.NEXTVAL,
    'Jonathan',
    'Robey',
    '0412523122'
);

INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Laura',
    NULL,
    '654 Main Street',
    'Sydney',
    'NSW',
    '2456',
    TO_DATE('14-Feb-2013', 'dd-Mon-yyyy'),
    '0424565689',
    'laura@gmail.com',
    emergencycontact_seq.CURRVAL
);

INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Lachlan',
    NULL,
    '654 Main Street',
    'Sydney',
    'NSW',
    '2456',
    TO_DATE('21-Feb-2016', 'dd-Mon-yyyy'),
    '0456789854',
    'lachlan@gmail.com',
    emergencycontact_seq.CURRVAL
);

INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    TO_DATE('4-Sep-2023 15:30', 'dd-Mon-yyyy hh24:mi'),
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'S',
    (
        SELECT
            patient_no
        FROM
            patient
        WHERE
                upper(patient_fname) = upper('Laura')
            AND ec_id = (
                SELECT
                    ec_id
                FROM
                    emergency_contact
                WHERE
                    ec_phone = '0412523122'
            )
    ),
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    6,
    NULL
);

INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    TO_DATE('4-Sep-2023 16:00', 'dd-Mon-yyyy hh24:mi'),
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'S',
    (
        SELECT
            patient_no
        FROM
            patient
        WHERE
                upper(patient_fname) = upper('Lachlan')
            AND ec_id = (
                SELECT
                    ec_id
                FROM
                    emergency_contact
                WHERE
                    ec_phone = '0412523122'
            )
    ),
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    6,
    NULL
);

COMMIT;

--SELECT
--    *
--FROM
--    emergency_contact;
--
--SELECT
--    *
--FROM
--    patient;
--
--SELECT
--    *
--FROM
--    appointment;

--3(c)

INSERT INTO appointment VALUES (
    appointment_seq.NEXTVAL,
    TO_DATE('4-Sep-2023 16:00', 'dd-Mon-yyyy hh24:mi') + 10,
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'L',
    (
        SELECT
            patient_no
        FROM
            patient
        WHERE
                upper(patient_fname) = upper('Lachlan')
            AND ec_id = (
                SELECT
                    ec_id
                FROM
                    emergency_contact
                WHERE
                    ec_phone = '0412523122'
            )
    ),
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    14,
    (
        SELECT
            appt_no
        FROM
            appointment
        WHERE
                to_char(appt_datetime, 'dd-Mon-yyyy hh24:mi') = '04-Sep-2023 16:00'
            AND patient_no = (
                SELECT
                    patient_no
                FROM
                    patient
                WHERE
                        upper(patient_fname) = upper('Lachlan')
                    AND ec_id = (
                        SELECT
                            ec_id
                        FROM
                            emergency_contact
                        WHERE
                            ec_phone = '0412523122'
                    )
            )
    )
);

COMMIT;

--SELECT
--    *
--FROM
--    appointment;
    
    
--3(d)

/*SELECT
    *
FROM
    appointment;*/

UPDATE appointment
SET
    appt_datetime = (
        SELECT
            appt_datetime + 4
        FROM
            appointment
        WHERE
                patient_no = (
                    SELECT
                        patient_no
                    FROM
                        patient
                    WHERE
                            upper(patient_fname) = upper('Lachlan')
                        AND ec_id = (
                            SELECT
                                ec_id
                            FROM
                                emergency_contact
                            WHERE
                                ec_phone = '0412523122'
                        )
                )
            AND appt_prior_apptno IS NOT NULL
             AND nurse_no = 14
        AND provider_code = (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    )
    )
WHERE
        patient_no = (
            SELECT
                patient_no
            FROM
                patient
            WHERE
                    upper(patient_fname) = upper('Lachlan')
                AND ec_id = (
                    SELECT
                        ec_id
                    FROM
                        emergency_contact
                    WHERE
                        ec_phone = '0412523122'
                )
        )
    AND appt_prior_apptno IS NOT NULL
    AND nurse_no = 14
    AND provider_code = (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    );

COMMIT;

/*SELECT
    *
FROM
    appointment;*/
    

--3(e)

/*SELECT
    *
FROM
    appointment;*/

DELETE FROM appointment
WHERE
    appt_datetime BETWEEN TO_DATE('15-Sep-2023 00:00', 'dd-Mon-yyyy hh24:mi') AND TO_DATE('23-Sep-2023 23:59', 'dd-Mon-yyyy hh24:mi');

COMMIT;

/*SELECT
    *
FROM
    appointment;*/