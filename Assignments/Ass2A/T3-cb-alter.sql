--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-cb-alter.sql

--Student ID: 30734819
--Student Name: Marcus Lim Tau Whang
--Tutorial No: Tutorial 1, Fri 4-6pm

/* Comments for your marker:




*/

/*
Task 3:

Make the listed changes to the "live" database
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW

-- (a)
ALTER TABLE centre ADD(
    centre_total_offspring NUMERIC(4) DEFAULT 0 NOT NULL
);

COMMENT ON COLUMN centre.centre_total_offspring IS
    'Total number of offsrping born at the centre. Default is 0.';

COMMIT;

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
-- check before
select * from animal;

-- make edits
ALTER TABLE animal ADD(
    animal_alive CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT ck_animal_alive CHECK (animal_alive IN ('Y','N'))
);

UPDATE animal 
SET animal_alive ='N'
WHERE animal_id = 12;

commit;

-- check after 
select * from animal;

-- (c)
ALTER TABLE centre ADD(
    centre_type VARCHAR2(100) DEFAULT 'Other' NOT NULL
);

COMMENT ON COLUMN centre.centre_type IS
    'The type of centre. Standard types are: Zoo, Wildlife Park, Sanctuary, Nature Reserve and Other. Can be 
    modified/extended. ';

UPDATE centre 
SET centre_type ='Zoo'
WHERE centre_name LIKE '%Zoo%';

UPDATE centre 
SET centre_type ='Wildlife Park'
WHERE centre_name LIKE '%Park%';

UPDATE centre 
SET centre_type ='Sanctuary'
WHERE centre_name LIKE '%Sanctuary%';

UPDATE centre 
SET centre_type ='Nature Reserve'
WHERE centre_name LIKE '%Reserve%';

commit;