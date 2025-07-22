--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-json.sql

--Student ID: 33684669
--Student Name: Shruthi Shashidhara Shastry
--Unit Code: FIT9132
--Applied Class No: A01 Wednesday 8am G16

/* Comments for your marker:

*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SET PAGESIZE 300

SELECT
        JSON_OBJECT(
            '_id' VALUE appt_no,
                    'datetime' VALUE to_char(appt_datetime, 'dd/MM/yyyy hh24:mi'),
                    'provider_code' VALUE provider_code,
                    'provider_name' VALUE provider_title
                                          || '. '
                                          || ltrim(provider_fname
                                                   || ' '
                                                   || provider_lname),
                    'item_totalcost' VALUE SUM(item_stdcost * as_item_quantity),
                    'no_of_items' VALUE COUNT(item_id),
                    'items' VALUE JSON_ARRAYAGG(
                            JSON_OBJECT(
                                    'id' VALUE item_id,
                                    'desc' VALUE item_desc,
                                    'standardcost' VALUE item_stdcost,
                                    'quantity' VALUE as_item_quantity
                             )
            )
        FORMAT JSON)
        || ','
FROM
         mns.item
    NATURAL JOIN mns.apptservice_item
    NATURAL JOIN mns.appt_serv
    NATURAL JOIN mns.appointment
    NATURAL JOIN mns.provider
GROUP BY
    appt_no,
    appt_datetime,
    provider_code,
    provider_title,
    provider_fname,
    provider_lname
HAVING
    COUNT(as_item_quantity) >= 1
ORDER BY
    appt_no;

