--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-cb-dm.sql

--Student ID: 30734819
--Student Name: Marcus Lim Tau Whang
--Tutorial No: Tutorial 1, Fri 4-6pm

/* Comments for your marker:




*/

/*
Task 2 (c):

Complete the listed DML actions
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

-- (i)
DROP SEQUENCE animal_seq;
CREATE SEQUENCE animal_seq START WITH 500 INCREMENT BY 1;

DROP SEQUENCE brevent_seq;
CREATE SEQUENCE brevent_seq START WITH 500 INCREMENT BY 1;

commit;

-- (ii)
UPDATE animal
  SET animal.centre_id = (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Kruger National Park')
  WHERE animal.centre_id = (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'SanWild Wildlife Sanctuary');

DELETE FROM centre WHERE centre_name = 'SanWild Wildlife Sanctuary';

commit;

-- (iii)
INSERT INTO animal VALUES(
    ANIMAL_SEQ.nextval,
    'F',
    null,
    (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Australia Zoo'),
    (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil'),
    (SELECT s.spec_name FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
);

INSERT INTO animal VALUES(
    ANIMAL_SEQ.nextval,
    'M',
    null,
    (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Werribee Open Range Zoo'),
    (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil'),
    (SELECT s.spec_name FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
);

-- (iv)
INSERT INTO breeding_event VALUES(
    BREVENT_SEQ.nextval,
    to_date('10-Feb-2021'),
    (SELECT a.animal_id FROM animal a 
        WHERE (
               a.spec_genus = (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
               AND
               a.centre_id = (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Australia Zoo')
               )),
     (SELECT a.animal_id FROM animal a 
        WHERE (
               a.spec_genus = (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
               AND
               a.centre_id = (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Werribee Open Range Zoo')
               ))           
);

INSERT INTO animal VALUES(
    ANIMAL_SEQ.nextval,
    'F',
    (SELECT b.brevent_id FROM breeding_event b 
        WHERE 
        b.father_id = 
            (SELECT a.animal_id FROM animal a 
                WHERE (
               a.spec_genus = (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
               AND
               a.centre_id = (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Werribee Open Range Zoo')
               ))),
    (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Australia Zoo'),
    (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil'),
    (SELECT s.spec_name FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
);

INSERT INTO animal VALUES(
    ANIMAL_SEQ.nextval,
    'M',
    (SELECT b.brevent_id FROM breeding_event b 
        WHERE 
        b.father_id = 
            (SELECT a.animal_id FROM animal a 
                WHERE (
               a.spec_genus = (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
               AND
               a.centre_id = (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Werribee Open Range Zoo')
               ))),
    (SELECT c.centre_id FROM centre c WHERE c.centre_name = 'Australia Zoo'),
    (SELECT s.spec_genus FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil'),
    (SELECT s.spec_name FROM species s WHERE s.spec_popular_name = 'Tasmanian Devil')
);

commit;
