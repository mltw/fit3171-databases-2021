-- Name: Marcus Lim Tau Whang, ID: 30734819, Tutorial no: 1 (FRI, 4-6pm)

set echo on

DROP TABLE TEAM;
DROP TABLE EMPLOYEE;

CREATE TABLE TEAM (
    team_no NUMERIC(3) NOT NULL,
    emp_no NUMERIC(5),
    CONSTRAINT pk_team PRIMARY KEY (team_no)
    );
    
CREATE TABLE EMPLOYEE(
    emp_no NUMERIC(5) NOT NULL,
    emp_fname VARCHAR(30),
    emp_lname VARCHAR(30),
    emp_street VARCHAR(30) NOT NULL,
    emp_town VARCHAR(30) NOT NULL,
    emp_pcode CHAR(4)NOT NULL,
    emp_dob Date NOT NULL,
    emp_taxno VARCHAR(20),
    team_no NUMERIC(3),
    mentor_no NUMERIC(5)
    );
    
ALTER TABLE EMPLOYEE 
    ADD(
        CONSTRAINT pk_employee PRIMARY KEY (emp_no),
        CONSTRAINT fk_employee_team FOREIGN KEY (team_no) REFERENCES TEAM (team_no),
        CONSTRAINT fk_employee_mentor FOREIGN KEY (mentor_no) REFERENCES EMPLOYEE (emp_no)
        );
    
set echo off;