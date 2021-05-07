--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-cb-schm.sql

--Student ID: 30734819
--Student Name: Marcus Lim Tau Whang
--Tutorial No: Tutorial 1, Fri 4-6pm

/* Comments for your marker:




*/

/*
Using the model and details supplied, and the supplied T1-cb-schm.sql
file, create an SQL schema file which can be used to create this database in
Oracle.
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) BELOW
DROP TABLE species PURGE;
DROP TABLE animal PURGE;
DROP TABLE centre PURGE;
DROP TABLE breeding_event PURGE;

CREATE TABLE species (
    spec_genus VARCHAR(20) NOT NULL,
    spec_name VARCHAR(20) NOT NULL,
    spec_popular_name VARCHAR(40) NOT NULL,
    spec_family VARCHAR(20) NOT NULL,
    spec_natural_range VARCHAR(100) NOT NULL,
    CONSTRAINT spec_pk PRIMARY KEY (spec_genus, spec_name),
    CONSTRAINT spec_un UNIQUE (spec_popular_name)
);

COMMENT ON COLUMN species.spec_genus IS
    'The species genus';

COMMENT ON COLUMN species.spec_name IS
    'The species name';
    
COMMENT ON COLUMN species.spec_popular_name IS
    'The species popular name';

COMMENT ON COLUMN species.spec_family IS
    'The species family name';
    
COMMENT ON COLUMN species.spec_natural_range IS
    'Description of the natural range of the species';
    
    
CREATE TABLE animal (
    animal_id NUMERIC(6) NOT NULL,
    animal_sex CHAR(1) NOT NULL,
    brevent_id NUMERIC(6),
    centre_id CHAR(6) NOT NULL,
    spec_genus VARCHAR(20) NOT NULL,
    spec_name VARCHAR(20) NOT NULL,
    CONSTRAINT animal_pk PRIMARY KEY (animal_id),
    CONSTRAINT ck_animal_sex CHECK ( animal_sex IN ('M', 'F')),
    CONSTRAINT spec_animal_fk FOREIGN KEY (spec_genus, spec_name) REFERENCES species (spec_genus, spec_name)
);

COMMENT ON COLUMN animal.animal_id IS
    'The identifier for the animal';

COMMENT ON COLUMN animal.animal_sex IS
    'The animal sex (M of F)';
    
COMMENT ON COLUMN animal.brevent_id IS
    'If bred in captivity (i.e. at a centre), the id of the breeding event 
    which produced the animal. Animals which have been captured
    from the wild will have no brevent_id assigned';
   
COMMENT ON COLUMN animal.centre_id IS
    'The "home" center where the animal is normally located.
    Animals are sometimes located at other centres for a breeding
    event'; 
    
COMMENT ON COLUMN animal.spec_genus IS
    'The species genus for the animal';
    
COMMENT ON COLUMN animal.spec_name IS
    'The species name for the animal';
    
    
CREATE TABLE breeding_event (
    brevent_id NUMERIC(6) NOT NULL,
    brevent_date Date NOT NULL,
    mother_id NUMERIC(6) NOT NULL,
    father_id NUMERIC(6) NOT NULL,
    CONSTRAINT brevent_pk PRIMARY KEY (brevent_id),
    CONSTRAINT animal_brevent_mother_fk FOREIGN KEY (mother_id) REFERENCES animal (animal_id),
    CONSTRAINT animal_brevent_father_fk FOREIGN KEY (father_id) REFERENCES animal (animal_id)
);

COMMENT ON COLUMN breeding_event.brevent_id IS
    'The identifier for the breeding event';
    
COMMENT ON COLUMN breeding_event.brevent_date IS
    'The date on which the breeding event took place';
    
COMMENT ON COLUMN breeding_event.mother_id IS
    'The animal_id of the animal who was the mother';
    
COMMENT ON COLUMN breeding_event.father_id IS
    'The animal_id of the animal who was the father';
    
    
CREATE TABLE centre (
    centre_id CHAR(6) NOT NULL,
    centre_name VARCHAR(40) NOT NULL,
    centre_address VARCHAR(100) NOT NULL,
    centre_director VARCHAR(30) NOT NULL,
    centre_phone_no VARCHAR(20) NOT NULL,
    CONSTRAINT centre_pk PRIMARY KEY (centre_id),
    CONSTRAINT centre_un UNIQUE (centre_name)
);

COMMENT ON COLUMN centre.centre_id IS
    'The identifier for the center';
    
COMMENT ON COLUMN centre.centre_name IS
    'The centre name';
    
COMMENT ON COLUMN centre.centre_address IS
    'The centre address';
    
COMMENT ON COLUMN centre.centre_director IS
    'The name of the centres director';
    
COMMENT ON COLUMN centre.centre_phone_no IS
    'The centres phone contact number';

ALTER TABLE animal
    ADD (
        CONSTRAINT brevent_animal_fk FOREIGN KEY (brevent_id) REFERENCES breeding_event (brevent_id),
        CONSTRAINT centre_animal_fk FOREIGN KEY (centre_id) REFERENCES centre (centre_id)
        );

--ALTER TABLE vendor ADD CONSTRAINT vendor_pk PRIMARY KEY ( vendor_id );
--ALTER TABLE vendor ADD CONSTRAINT vendor_un UNIQUE ( vendor_name );
--CREATE TABLE student (
--    stu_nbr     NUMBER(8) NOT NULL,
--    stu_lname   VARCHAR2(50) NOT NULL,
--    stu_fname   VARCHAR2(50) NOT NULL,
--    stu_dob     DATE NOT NULL,
--    CONSTRAINT student_pk PRIMARY KEY ( stu_nbr ),
--    CONSTRAINT ck_stu_nbr CHECK ( stu_nbr > 10000000 )
--);
--
--COMMENT ON COLUMN student.stu_nbr IS
--    'Student number';
--
--COMMENT ON COLUMN student.stu_lname IS
--    'Student last name';


