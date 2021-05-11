--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-cb-alter.sql

--Student ID: 30734819
--Student Name: Marcus Lim Tau Whang
--Tutorial No: Tutorial 1, Fri 4-6pm

/* Comments for your marker:
task3c: due to us not being able to use subquery when setting a defualt value for a column,
I've assumed that the centre type of 'Other' would always have a PK of 100 (thus the hardcoded
value when setting the default)



*/

/*
Task 3:

Make the listed changes to the "live" database
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

-- (a)
ALTER TABLE centre ADD(
    centre_total_offspring NUMBER(4) DEFAULT 0 NOT NULL
);

COMMENT ON COLUMN centre.centre_total_offspring IS
    'Total number of offsrping born at the centre. Default is 0.';

-- (b)
/*
******* Explain here your selected approach and its advantage/s *********
The appropriate approach is to create a new attribute to determine whether each animal is still alive,
we can set its default to Y(yes).
Then, if an animal dies, we just change its alive status to N (no).

In my opinion, using this approach is better than deleting the entire dead animal's row, because this maintains
data referential integrity, since the animal's id is a FK to the table breeding_event.
Besides that, if we delete the animal's row and suppose our deletion contraints are set to on cascade, if we delete all
relevant/related rows, it will cause data loss, leading the data stored to be inaccurate and inconsistent.

Also, we should do a commit at the end when the transaction is done, so as to preserve
the Atomicity and Isolation property.
*/
select * from animal;

ALTER TABLE animal ADD(
    animal_alive CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT ck_animal_alive CHECK (animal_alive IN ('Y','N'))
);

UPDATE animal 
SET animal_alive ='N'
WHERE animal_id = 12;

commit;

select * from animal;

-- (c)
DROP SEQUENCE centre_type_seq;
CREATE SEQUENCE centre_type_seq START WITH 100 INCREMENT BY 1;

DROP TABLE centre_type CASCADE CONSTRAINTS PURGE;

CREATE TABLE centre_type (
    centre_type_id NUMBER(6) NOT NULL,
    centre_type_desc VARCHAR2(100) NOT NULL,
    CONSTRAINT centre_type_pk PRIMARY KEY (centre_type_id)
);

COMMENT ON COLUMN centre_type.centre_type_id IS
    'The identifier for thecentre type.';
    
COMMENT ON COLUMN centre_type.centre_type_desc IS
    'The type of centre.'; 
    
INSERT INTO centre_type VALUES(
    CENTRE_TYPE_SEQ.nextval,
    'Other'
);
INSERT INTO centre_type VALUES(
    CENTRE_TYPE_SEQ.nextval,
    'Zoo'
);
INSERT INTO centre_type VALUES(
    CENTRE_TYPE_SEQ.nextval,
    'Wildlife Park'
);
INSERT INTO centre_type VALUES(
    CENTRE_TYPE_SEQ.nextval,
    'Sanctuary'
);
INSERT INTO centre_type VALUES(
    CENTRE_TYPE_SEQ.nextval,
    'Nature Reserve'
);

ALTER TABLE centre ADD(
    centre_type_id NUMBER(6) DEFAULT 100 NOT NULL,
    CONSTRAINT centre_type_centre_fk FOREIGN KEY (centre_type_id) REFERENCES centre_type (centre_type_id)
);

COMMENT ON COLUMN centre.centre_type_id IS
    'The identifier for the centre type. ';

UPDATE centre 
SET centre_type_id = (SELECT c.centre_type_id FROM centre_type c WHERE c.centre_type_desc = 'Zoo')
WHERE centre_name LIKE '%Zoo%';

UPDATE centre 
SET centre_type_id = (SELECT c.centre_type_id FROM centre_type c WHERE c.centre_type_desc = 'Wildlife Park')
WHERE centre_name LIKE '%Park%';

UPDATE centre 
SET centre_type_id =(SELECT c.centre_type_id FROM centre_type c WHERE c.centre_type_desc = 'Sanctuary')
WHERE centre_name LIKE '%Sanctuary%';

UPDATE centre 
SET centre_type_id = (SELECT c.centre_type_id FROM centre_type c WHERE c.centre_type_desc = 'Nature Reserve')
WHERE centre_name LIKE '%Reserve%';

commit;