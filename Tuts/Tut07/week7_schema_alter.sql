SET ECHO ON

SPOOL week7_schema_alter_output.txt

/*
Databases Week 7 Tutorial Sample Solution
week7_schema_alter.sql

Author:

*/

-- 7.1
-- DDL for Student-Unit-Enrolment model (using ALTER TABLE)
--

--
-- Place DROP commands at head of schema file
--
drop table enrolment purge;
drop table student purge;
drop table unit purge;

-- Create Tables
-- Here using both table and column constraints
--

CREATE TABLE student (
    stu_nbr     NUMBER(8) NOT NULL,
    stu_lname   VARCHAR2(50) NOT NULL,
    stu_fname   VARCHAR2(50) NOT NULL,
    stu_dob     DATE NOT NULL
);

COMMENT ON COLUMN student.stu_nbr IS
    'Student number';

COMMENT ON COLUMN student.stu_lname IS
    'Student last name';

COMMENT ON COLUMN student.stu_fname IS
    'Student first name';

COMMENT ON COLUMN student.stu_dob IS
    'Student date of birth';

/* Add STUDENT constraints here */
alter table student add constraint student_pk primary key (stu_nbr);
alter table student add constraint chk_stu_nbr check (stu_nbr>10000000);

/* Add UNIT data types here */
CREATE TABLE unit (
    unit_code   char(7) NOT NULL,
    unit_name   varchar2(50) not null --varchar also can 
);

COMMENT ON COLUMN unit.unit_code IS
    'Unit code';

COMMENT ON COLUMN unit.unit_name IS
    'Unit name';

/* Add UNIT constraints here */
alter table unit add constraint unit_pk primary key (unit_code);
alter table unit add constraint un_unit_name unique(unit_name);

/* Add EMROLMENT attributes and data types here */
CREATE TABLE enrolment (
    stu_nbr number(8) not null,
    unit_code char(7) not null,
    enrol_year number(4) not null, 
    enrol_semester char(1) not null,
    enrol_mark number(3),
    enrol_grade char(2)

);

COMMENT ON COLUMN enrolment.stu_nbr IS
    'Student number';

COMMENT ON COLUMN enrolment.unit_code IS
    'Unit code';

COMMENT ON COLUMN enrolment.enrol_year IS
    'Enrolment year';

COMMENT ON COLUMN enrolment.enrol_semester IS
    'Enrolment semester';

COMMENT ON COLUMN enrolment.enrol_mark IS
    'Enrolment mark (real)';

COMMENT ON COLUMN enrolment.enrol_grade IS
    'Enrolment grade (letter)';

/* Add ENROLMENT constraints here */
alter table enrolment add constraint enrolment_pk 
primary key(unit_code, stu_nbr, enrol_semester, enrol_year);

alter table enrolment add constraint student_enrolment_fk
foreign key (stu_nbr) references student(stu_nbr); 

alter table enrolment add constraint unit_enrolment_fk
foreign key (unit_code) references unit(unit_code); 

alter table enrolment add constraint chek_enrol_semester
check (enrol_semester in ('1','2','3'));


SPOOL OFF

SET ECHO OFF