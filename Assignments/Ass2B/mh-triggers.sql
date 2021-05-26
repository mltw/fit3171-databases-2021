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
--close transaction
rollback;


/* 
    Q2
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/
CREATE OR REPLACE TRIGGER check_charter_cost_seats_num
    BEFORE INSERT OR UPDATE ON charter
    FOR EACH ROW
DECLARE
    heli_num helicopter.ht_nbr%type;
--    heli_num_of_seats NUMBER(2);
BEGIN
    SELECT ht_nbr INTO heli_num
    FROM helicopter 
    WHERE heli_callsign = :old.heli_callsign;

    if :new.charter_cost_per_hour < (SELECT ht_cost_per_hour 
                                     FROM helicopter_type ht
                                     WHERE ht.ht_nbr = heli_num)
    
    
    
--    (select ht_cost_per_hour
--                                   from (helicopter h join helicopter_type ht on h.ht_nbr = ht.ht_nbr)
--                                   where h.heli_callsign = :old.heli_callsign)
                                   
--                                   select ht_cost_per_hour 
--from (helicopter h join helicopter_type ht on h.ht_nbr = ht.ht_nbr)
--where h.heli_callsign = 'BI-BAC';
                                   
--                                   (select AVG(ENROL_MARK) from ENROLMENT where stu_nbr = student.stu_nbr
--        OR
--       :new.charter_nbr_passengers > (select ht.ht_nbr_seats 
--                                    from (helicopter_type ht join helicopter h on ht.ht_nbr = h.ht_nbr)
--                                      where charter.heli_callsign = h.heli_callsign)
        THEN
        raise_application_error(-20000, 'Charter cost per hour must >= helicopter''s, and 
                                         num of passengers must <= charter num. of seats');
    end if;
END;
/
    








/* 
    Q3
*/
/*Please copy your trigger code and any other necessary SQL statements after this line*/
CREATE OR REPLACE TRIGGER check_heli_hours_flown
    BEFORE UPDATE ON charter_leg
    FOR EACH ROW
DECLARE 
    hours_flown helicopter.heli_hrs_flown%type;
BEGIN
    if :old.cl_ata is not null THEN
        raise_application_error(-20000, 'Actual time of departure and arrival have been entered, can''t be updated again.');
    elsif ((:new.cl_ata - :new.cl_atd) *24) <= 0 THEN
        raise_application_error(-20000, 'Arrival time must be later than departure time.');
    elsif ((:new.cl_ata - :new.cl_atd) *24) > 0 THEN
            hours_flown := (:new.cl_ata - :new.cl_atd) *24;
        
    end if;
    
    UPDATE helicopter
    SET
        heli_hrs_flown = hours_flown
    WHERE
        heli_callsign = (select heli_callsign from charter ch where ch.charter_nbr = :old.charter_nbr);

END;
/

-- display before values
select * from charter_leg;

-- test trigger
-- (when updating the departure time to be later than arrival time)
UPDATE charter_leg
SET
    cl_atd = TO_DATE('01/06/2020 16:03', 'dd/mm/yyyy hh24:mi'),
    cl_ata = TO_DATE('01/06/2020 14:08', 'dd/mm/yyyy hh24:mi')
WHERE
    cl_leg_nbr = 2
    AND 
    charter_nbr = 1;

-- (normal updating when arrival time is later than departure time)
UPDATE charter_leg
SET
    cl_atd = TO_DATE('01/06/2020 16:03', 'dd/mm/yyyy hh24:mi'),
    cl_ata = TO_DATE('01/06/2020 18:08', 'dd/mm/yyyy hh24:mi')
WHERE
    cl_leg_nbr = 2
    AND 
    charter_nbr = 1;

-- (updating again when arrival and departure has already been updated)
UPDATE charter_leg
SET
    cl_atd = TO_DATE('01/06/2020 16:03', 'dd/mm/yyyy hh24:mi'),
    cl_ata = TO_DATE('01/06/2020 18:08', 'dd/mm/yyyy hh24:mi')
WHERE
    cl_leg_nbr = 2
    AND 
    charter_nbr = 1;

-- display after values
select * from charter_leg;
select * from helicopter;
--close transaction
rollback;
