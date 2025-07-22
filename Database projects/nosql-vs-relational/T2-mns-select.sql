--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-select.sql

--Student ID: 33684669
--Student Name: Shruthi Shashidhara Shastry
--Unit Code: FIT9132
--Applied Class No: A01 Wednesday 8am G16

/* Comments for your marker:
*/

/*2(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    item_id,
    item_desc,
    item_stdcost,
    item_stock
FROM
    mns.item
WHERE
        item_stock >= 50
    AND lower(item_desc) LIKE '%composite%'
ORDER BY
    item_stock DESC,
    item_id;


/*2(b)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    provider_code,
    CASE
        WHEN provider_fname IS NOT NULL THEN 
            CASE
                WHEN provider_title IS NOT NULL THEN 
                    provider_title || '. ' || provider_fname || ' ' || provider_lname
                ELSE 
                    provider_fname || ' ' || provider_lname
            END
        ELSE
            CASE
                WHEN provider_title IS NOT NULL THEN
                    provider_title || '. ' || provider_lname
                ELSE
                    provider_lname
            END
    END AS provider_name
FROM
    mns.provider
WHERE
    spec_id = (
        SELECT
            spec_id
        FROM
            mns.specialisation
        WHERE
            upper(spec_name) = 'PAEDIATRIC DENTISTRY'
    )
ORDER BY
    provider_lname,
    provider_fname,
    provider_code;

/*2(c)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    service_code,
    service_desc,
    lpad(to_char(service_stdfee, '$9990.99'),
         20,
         ' ') AS service_standard_fee
FROM
    mns.service
WHERE
    service_stdfee > (
        SELECT
            AVG(service_stdfee)
        FROM
            mns.service
    )
ORDER BY
    service_stdfee DESC,
    service_code;
    
/*2(d)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    a.appt_no,
    to_char(a.appt_datetime, 'dd-Mon-yyyy hh24:mi') AS appointment_datetime,
    p.patient_no,
    ltrim(rtrim(patient_fname
                || ' '
                || patient_lname))                              AS patient_full_name,
    lpad(to_char(SUM(apptserv_fee + nvl(apptserv_itemcost, 0)),
                 '$9990.00'),
         23,
         ' ')                                       AS appointment_total_cost
FROM
         mns.patient p
    JOIN mns.appointment a ON p.patient_no = a.patient_no
    JOIN mns.appt_serv   aps ON a.appt_no = aps.appt_no
GROUP BY
    a.appt_no,
    appt_datetime,
    p.patient_no,
    patient_fname,
    patient_lname
Having
    SUM(apptserv_fee + nvl(apptserv_itemcost, 0)) = (
        SELECT
            MAX(sum(apptserv_fee + nvl(apptserv_itemcost, 0)))
        FROM
                 mns.appt_serv aps
            JOIN mns.appointment a ON aps.appt_no = a.appt_no
        WHERE
            apptserv_fee IS NOT NULL
        GROUP BY
            a.appt_no
    )
ORDER BY
    a.appt_no;



/*2(e)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    s.service_code,
    service_desc,
    lpad(to_char(service_stdfee,'$9990.99'),20,' ') as service_standard_fee,
    lpad(to_char(AVG(aps.apptserv_fee) - s.service_stdfee,
                 '$990.00'),
         25,
         ' ')  AS "Service Fee Differential"
FROM
         mns.service s
    JOIN mns.appt_serv aps ON s.service_code = aps.service_code
GROUP BY
    s.service_code,
    service_desc,
    service_stdfee
ORDER BY
    s.service_code;


/*2(f)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    p.patient_no,
    ltrim(rtrim(patient_fname
                || ' '
                || patient_lname))                   AS patientname,
    trunc(months_between(sysdate, patient_dob) / 12) AS currentage,
    COUNT(appt_no)                                   AS numappts,
    lpad(to_char((COUNT(appt_prior_apptno) / COUNT(appt_no)) * 100,
                 '90.9'),
         15,
         ' ')
    || '%'                                           AS followups
FROM
         mns.patient p
    JOIN mns.appointment a ON a.patient_no = p.patient_no
GROUP BY
    p.patient_no,
    patient_fname,
    patient_lname,
    patient_dob
ORDER BY
    patient_no;

/*2(g)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    provider_code AS pcode,
    lpad(nvl(
        CASE
            WHEN numberappts = 0 THEN
                '-'
            ELSE
                to_char(numberappts, '99')
        END,
        '-'),
         12,
         ' ')     AS numberappts,
    lpad(nvl(
        CASE
            WHEN totalfees IS NULL
                 OR totalfees = 0 THEN
                '-'
            ELSE
                to_char(totalfees, '$99990.99')
        END,
        '-'),
         10,
         ' ')     AS totalfees,
    lpad(nvl(
        CASE
            WHEN noitems IS NULL
                 OR noitems = 0 THEN
                '-'
            ELSE
                to_char(noitems, '99')
        END,
        '-'),
         9,
         ' ')     AS noitems
FROM
    mns.provider p
    LEFT OUTER JOIN (
        SELECT
            provider_code        AS pcode,
            COUNT(a.appt_no)     AS numberappts,
            SUM(totalfees)       AS totalfees,
            SUM(nvl(noitems, 0)) AS noitems
        FROM
            mns.appointment a
            LEFT OUTER JOIN (
                SELECT
                    appt_no,
                    SUM(nvl(apptserv_fee, 0)) AS totalfees
                FROM
                    mns.appt_serv
                GROUP BY
                    appt_no
            )               servicefee ON a.appt_no = servicefee.appt_no
            LEFT OUTER JOIN (
                SELECT
                    appt_no,
                    SUM(as_item_quantity) AS noitems
                FROM
                    mns.apptservice_item
                GROUP BY
                    appt_no
            )               total_item_quantity ON a.appt_no = total_item_quantity.appt_no
        WHERE
            appt_datetime BETWEEN TO_DATE('10-Sep-2023 09:00', 'dd-Mon-yyyy hh24:mi') AND TO_DATE('14-Sep-2023 17:00', 'dd-Mon-yyyy hh24:mi'
            )
        GROUP BY
            provider_code
    )            provider_details ON p.provider_code = provider_details.pcode
ORDER BY
    provider_code;


