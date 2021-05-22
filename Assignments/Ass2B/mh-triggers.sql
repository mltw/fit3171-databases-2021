--****PLEASE ENTER YOUR DETAILS BELOW****
--mh-triggers.sql

--Student ID: 30734819
--Student Name: Marcus Lim Tau Whang
--Tutorial No: Tutorial 1, Fri 4-6pm

/* Comments for your marker:




*/

/* 
    Q1 
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/
CREATE OR REPLACE TRIGGER check_ori_dest_location 
    BEFORE INSERT OR UPDATE ON charter_leg
    FOR EACH ROW
BEGIN 
    if :old.location_nbr_origin = :new.location_nbr_destination 
        OR
        :old.location_nbr_destination = :new.location_nbr_origin 
        OR
        :new.location_nbr_destination = :new.location_nbr_origin THEN 
        raise_application_error(-20000, 'Location origin and destination must be different');
    end if;
END;
/

-- Test Harness
-- display before value
select * from charter_leg;

-- test trigger
-- (when updating origin nbr to be same as destination nbr)
update charter_leg set location_nbr_origin = 101 where cl_leg_nbr = 1 and charter_nbr = 1;

-- (when updating destination nbr to be same as origin nbr)
update charter_leg set location_nbr_destination = 100 where cl_leg_nbr = 1 and charter_nbr = 1;

-- (when inserting a both origin and destination same nbr)
insert into charter_leg values
(4,
 1,
 to_date('01 Jan 2021 13:00:00','DD Mon YYYY HH24:MI:SS'), 
 to_date('01 Jan 2021 15:00:00','DD Mon YYYY HH24:MI:SS'), 
 null,
 null,
 103,
 103
 );
 
-- display after value
select * from charter_leg;
--closes transaction
rollback;


/* 
    Q2
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/









/* 
    Q3
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/





