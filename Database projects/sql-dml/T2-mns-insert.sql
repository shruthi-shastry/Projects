--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-insert.sql

--Student ID:33684669
--Student Name:Shruthi Shashidhara Shastry
--Unit Code:FIT9132
--Applied Class No:A01 wednesday 8am class G16

/* Comments for your marker:



*/

--------------------------------------
--INSERT INTO emergency_contact
--------------------------------------
INSERT INTO emergency_contact VALUES (
    21,
    'John',
    'Smith',
    '0412345678'
);

INSERT INTO emergency_contact VALUES (
    22,
    'Lisa',
    'Miller',
    '0450123456'
);

INSERT INTO emergency_contact VALUES (
    23,
    'Shravan',
    'kumar',
    '0407987654'
);

INSERT INTO emergency_contact VALUES (
    24,
    'Sanketh Ganesh',
    NULL,
    '0478555888'
);

INSERT INTO emergency_contact VALUES (
    25,
    'Sindhu',
    'shastry',
    '0433111222'
);

INSERT INTO emergency_contact VALUES (
    26,
    'Shravya',
    NULL,
    '0466999555'
);

INSERT INTO emergency_contact VALUES (
    27,
    'bindu sharma',
    's',
    '0499876543'
);

INSERT INTO emergency_contact VALUES (
    28,
    'vijay sharma',
    'H S',
    '0434567891'
);

--------------------------------------
--INSERT INTO patient
--------------------------------------
INSERT INTO patient VALUES (
    1,
    'arvinda',
    'rao',
    '123 Main Street',
    'Sydney',
    'NSW',
    '2000',
    TO_DATE('03-Feb-2001', 'dd-Mon-yyyy'),
    '0423456789',
    'arvinda@gmail.com',
    23
);

INSERT INTO patient VALUES (
    2,
    'prathamesh',
    'devadiga',
    '123 Main Street',
    'Sydney',
    'NSW',
    '2000',
    TO_DATE('06-Jun-2015', 'dd-Mon-yyyy'),
    '0401345678',
    'prathaDevadiga@gmail.com',
    23
);

INSERT INTO patient VALUES (
    3,
    'kavana',
    'prakash',
    '108 koonawara street',
    'Brisbane',
    'QLD',
    '4000',
    TO_DATE('16-Dec-1997', 'dd-Mon-yyyy'),
    '0489234567',
    'kavana@yahoo.com',
    24
);

INSERT INTO patient VALUES (
    4,
    'ayesha',
    NULL,
    '101 Pine Road',
    'Perth',
    'WA',
    '3780',
    TO_DATE('12-Mar-2012', 'dd-Mon-yyyy'),
    '0467123456',
    'ayesha@gmail.com',
    22
);

INSERT INTO patient VALUES (
    5,
    'sanjana',
    'sadashiv',
    '321 Cedar Lane',
    'Adelaide',
    'SA',
    '3400',
    TO_DATE('28-Apr-2002', 'dd-Mon-yyyy'),
    '0435678901',
    'sanju@gmail.com',
    21
);

INSERT INTO patient VALUES (
    6,
    'prateek',
    'km',
    '789 Maple Street',
    'Canberra',
    'ACT',
    '2600',
    TO_DATE('14-jul-2010', 'dd-Mon-yyyy'),
    '0412345678',
    'prateek@gmail.com',
    27
);

INSERT INTO patient VALUES (
    7,
    'nikhil',
    'srinivas',
    '555 Birch Road',
    'Darwin',
    'NT',
    '2685',
    TO_DATE('17-Sep-1999', 'dd-Mon-yyyy'),
    '0490123456',
    'srini@gmail.com',
    26
);

INSERT INTO patient VALUES (
    8,
    'jigya',
    NULL,
    '222 Cedar St',
    'Countryside',
    'TAS',
    '5678',
    TO_DATE('30-Sep-2018', 'dd-Mon-yyyy'),
    '0410234567',
    'jing@gmail.com',
    25
);

INSERT INTO patient VALUES (
    9,
    'panchami',
    'tumkur',
    '222 Cedar St',
    'Countryside',
    'TAS',
    '5678',
    TO_DATE('3-Oct-2012', 'dd-Mon-yyyy'),
    '0456789012',
    'panchu@gmail.com',
    25
);

INSERT INTO patient VALUES (
    10,
    'mehek',
    'naval',
    '555 Willow Ln',
    'Newcity',
    'WA',
    '6789',
    TO_DATE('21-mar-2003', 'dd-Mon-yyyy'),
    '0478901234',
    'mehek@gmail.com',
    21
);

INSERT INTO patient VALUES (
    11,
    'sujay',
    'sharma',
    '108 Allambanan Dr',
    'Melbourne',
    'VIC',
    '3153',
    TO_DATE('21-mar-2005', 'dd-Mon-yyyy'),
    '0456789464',
    'kappi@gmail.com',
    28
);

INSERT INTO patient VALUES (
    12,
    'rocky',
    'sharma',
    '108 Allambanan Dr',
    'Melbourne',
    'VIC',
    '3153',
    TO_DATE('21-mar-2019', 'dd-Mon-yyyy'),
    '0467876486',
    'rockzz@gmail.com',
    28
);

--------------------------------------
--INSERT INTO appointment
--------------------------------------

INSERT INTO appointment VALUES (
    1,
    TO_DATE('28-May-2023 9:00', 'dd-Mon-yyyy hh24:mi'),
    10,
    'S',
    3,
    'AST002',
    12,
    NULL
);

INSERT INTO appointment VALUES (
    2,
    TO_DATE('28-May-2023 11:00', 'dd-Mon-yyyy hh24:mi'),
    5,
    'T',
    10,
    'ORS001',
    1,
    NULL
);

INSERT INTO appointment VALUES (
    3,
    TO_DATE('28-May-2023 11:00', 'dd-Mon-yyyy hh24:mi'),
    7,
    'T',
    1,
    'PED001',
    7,
    NULL
);

INSERT INTO appointment VALUES (
    4,
    TO_DATE('28-May-2023 14:30', 'dd-Mon-yyyy hh24:mi'),
    1,
    'L',
    2,
    'END001',
    10,
    NULL
);

INSERT INTO appointment VALUES (
    5,
    TO_DATE('8-Jul-2023 10:00', 'dd-Mon-yyyy hh24:mi'),
    3,
    'S',
    8,
    'GEN002',
    15,
    NULL
);

INSERT INTO appointment VALUES (
    6,
    TO_DATE('8-Jul-2023 10:00', 'dd-Mon-yyyy hh24:mi'),
    12,
    'L',
    6,
    'PED002',
    4,
    NULL
);

INSERT INTO appointment VALUES (
    7,
    TO_DATE('8-Jul-2023 12:30', 'dd-Mon-yyyy hh24:mi'),
    4,
    'T',
    7,
    'GEN003',
    15,
    NULL
);

INSERT INTO appointment VALUES (
    8,
    TO_DATE('8-Jul-2023 14:30', 'dd-Mon-yyyy hh24:mi'),
    8,
    'S',
    9,
    'PED001',
    7,
    NULL
);

INSERT INTO appointment VALUES (
    9,
    TO_DATE('8-Jul-2023 16:30', 'dd-Mon-yyyy hh24:mi '),
    4,
    'S',
    7,
    'GEN003',
    8,
    7
);


INSERT INTO appointment VALUES (
    10,
    TO_DATE('8-Jul-2023 16:30', 'dd-Mon-yyyy hh24:mi'),
    1, 
    'S',
    2,
    'END001',
    14,
    4
);

INSERT INTO appointment VALUES (
    11,
    TO_DATE('22-Aug-2023 9:00', 'dd-Mon-yyyy hh24:mi'),
    8,
    'T',
    4,
    'ORT001',
    2,
    NULL
);

INSERT INTO appointment VALUES (
    12,
    TO_DATE('22-Aug-2023 12:30', 'dd-Mon-yyyy hh24:mi'),
    11,
    'L',
    5,
    'PER001',
    5,
    NULL
);

INSERT INTO appointment VALUES (
    13,
    TO_DATE('22-Aug-2023 13:00', 'dd-Mon-yyyy hh24:mi'),
    8,
    'S',
    4,
    'ORT001',
    6,
    11
);

INSERT INTO appointment VALUES (
    14,
    TO_DATE('22-Aug-2023 14:00', 'dd-Mon-yyyy hh24:mi'),
    6,
    'T',
    11,
    'PED001',
    13,
    NULL
);

INSERT INTO appointment VALUES (
    15,
    TO_DATE('22-Aug-2023 17:00', 'dd-Mon-yyyy hh24:mi'),
    6,
    'S',
    11,
    'PED001',
    9,
    14
);

INSERT INTO appointment VALUES (
    16,
    TO_DATE('22-Aug-2023 17:00', 'dd-Mon-yyyy hh24:mi'),
    1,
    'S',
    12,
    'END001',
    11,
    NULL
);

COMMIT;

SELECT
    *
FROM
    emergency_contact;

SELECT
    *
FROM
    patient;

SELECT
    *
FROM
    appointment;