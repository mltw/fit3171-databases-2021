--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-cb-insert.sql

--Student ID: 30734819
--Student Name: Marcus Lim Tau Whang
--Tutorial No:  Tutorial 1, Fri 4-6pm

/* Comments for your marker:
inserted 8 animals from the wild; 4 animals from 4 breeding events respectively



*/

/*
Task 2 (b):

Load the ANIMAL and BREEDING_EVENT tables with your own test data using the 
supplied T2-cb-insert.sql file script file, and SQL commands which will  
insert as a minimum, the following sample data -
 - 12 animals, some of which must have been captured from the wild, i.e. 
      are not the offspring from a breeding event, and
- 4 breeding events
Your inserted rows must meet the assignment specification requirements
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

INSERT INTO animal VALUES(
    1,
    'M',
    null,
    'AUS10',
    'Myrmecobius',
    'fasciatus'
);

INSERT INTO animal VALUES(
    2,
    'F',
    null,
    'AUS10',
    'Myrmecobius',
    'fasciatus'
);

INSERT INTO animal VALUES(
    3,
    'F',
    null,
    'AUS40',
    'Sarcophilus',
    'harrisii'
);

INSERT INTO animal VALUES(
    4,
    'M',
    null,
    'AUS40',
    'Sarcophilus',
    'harrisii'
);

INSERT INTO animal VALUES(
    5,
    'M',
    null,
    'SAF10',
    'Equus',
    'grevyi'
);

INSERT INTO animal VALUES(
    6,
    'F',
    null,
    'SAF10',
    'Equus',
    'grevyi'
);

INSERT INTO animal VALUES(
    7,
    'M',
    null,
    'SAF30',
    'Panthera',
    'leo'
);

INSERT INTO animal VALUES(
    8,
    'F',
    null,
    'SAF30',
    'Panthera',
    'leo'
);

INSERT INTO breeding_event VALUES(
    1,
    to_date('10-Jan-2020'),
    6,
    5
);
INSERT INTO animal VALUES(
    9,
    'M',
    1,
    'SAF10',
    'Equus',
    'grevyi'
);

INSERT INTO breeding_event VALUES(
    2,
    to_date('31-Mar-2020'),
    8,
    7
);
INSERT INTO animal VALUES(
    10,
    'F',
    2,
    'SAF30',
    'Panthera',
    'leo'
);

INSERT INTO breeding_event VALUES(
    3,
    to_date('1-Apr-2020'),
    3,
    4
);
INSERT INTO animal VALUES(
    11,
    'F',
    3,
    'AUS40',
    'Sarcophilus',
    'harrisii'
);

INSERT INTO breeding_event VALUES(
    4,
    to_date('10-Oct-2020'),
    2,
    1
);

INSERT INTO animal VALUES(
    12,
    'F',
    4,
    'AUS10',
    'Myrmecobius',
    'fasciatus'
);

commit;