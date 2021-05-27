--****PLEASE ENTER YOUR DETAILS BELOW****
--mh-queries.sql

--Student ID: 30734819
--Student Name: Marcus Lim Tau Whang
--Tutorial No: Tutorial 1, Fri 4-6pm

/* Comments for your marker:




*/


/*
    Q1
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT es.ht_nbr, es.emp_nbr, e.emp_lname, e.emp_fname, to_char(es.end_last_annual_review, 'Dy DD Mon YYYY') AS review_date
FROM (MH.endorsement es JOIN MH.employee e ON es.emp_nbr = e.emp_nbr)
WHERE months_between(es.end_last_annual_review, '31-MAR-2020') > 0
ORDER BY es.end_last_annual_review;


/*
    Q2
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ch.charter_nbr, ch.client_nbr, NVL(cl.client_lname,'-'), NVL(cl.client_fname, '-'), ch.charter_special_reqs
FROM (MH.charter ch JOIN MH.client cl ON ch.client_nbr = cl.client_nbr)
WHERE ch.charter_special_reqs IS NOT NULL
ORDER BY ch.charter_nbr;


/*
    Q3
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ch.charter_nbr, 
        nullif((cl.client_fname || ' '),' ') || cl.client_lname AS FULLNAME,
        ch.charter_cost_per_hour
FROM ((MH.charter ch JOIN MH.client cl ON ch.client_nbr = cl.client_nbr)
      JOIN MH.charter_leg chl ON ch.charter_nbr = chl.charter_nbr)
      JOIN MH.location lc ON chl.location_nbr_destination = lc.location_nbr
WHERE upper(lc.location_name) = upper('Mount Doom')
      AND
      (ch.charter_cost_per_hour < 1000 OR ch.charter_special_reqs IS NULL)
ORDER BY FULLNAME DESC;


/*
    Q4
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ht.ht_nbr, ht.ht_name, count(h.heli_callsign)
FROM (MH.helicopter_type ht LEFT OUTER JOIN MH.helicopter h ON ht.ht_nbr = h.ht_nbr)
GROUP BY ht.ht_nbr, ht.ht_name
HAVING count(h.heli_callsign) >= 2
ORDER BY count(h.heli_callsign) DESC;


/*
    Q5
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT cl.location_nbr_origin, l.location_name, count(cl.location_nbr_origin)
FROM (MH.charter_leg cl LEFT OUTER JOIN MH.location l ON cl.location_nbr_origin = l.location_nbr)
GROUP BY cl.location_nbr_origin, l.location_name
HAVING count(cl.location_nbr_origin) > 1
ORDER BY count(cl.location_nbr_origin);


/*
    Q6
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ht.ht_nbr, ht.ht_name, NVL(SUM(h.heli_hrs_flown),0)
FROM (MH.helicopter_type ht LEFT OUTER JOIN MH.helicopter h ON ht.ht_nbr = h.ht_nbr)
GROUP BY ht.ht_nbr, ht.ht_name
ORDER BY NVL(SUM(h.heli_hrs_flown),0);


/*
    Q7
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT c.charter_nbr, to_char(cl.cl_atd, 'DD Mon YYYY HH24:MI:SS')
FROM (MH.employee e JOIN MH.charter c ON e.emp_nbr = c.emp_nbr)
       JOIN
       MH.charter_leg cl ON c.charter_nbr = cl.charter_nbr
WHERE upper(e.emp_fname) = upper('Frodo') AND upper(e.emp_lname) = upper('Baggins')
      AND
      cl.cl_leg_nbr = 1
      AND 
      cl.charter_nbr NOT IN 
      (SELECT cl2.charter_nbr
        FROM MH.charter_leg cl2 
        WHERE cl2.cl_ata IS NULL)
ORDER BY cl.cl_atd DESC;


/*
    Q8
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ch.charter_nbr, ch.client_nbr, NVL(cl.client_lname, '-') as CLIENT_LNAME , 
        NVL(cl.client_fname, '-') as CLIENT_FNAME,
        lpad(to_char(hours_cost_table.total_cost, '$990.99'),17,' ') AS TOTALCHARTERCOST
FROM ((MH.client cl JOIN MH.charter ch ON cl.client_nbr = ch.client_nbr)
        JOIN
        (SELECT cl.charter_nbr, 
                sum(to_char(cl.cl_ata-cl.cl_atd)*24) as total_hours,
                sum((to_char(cl.cl_ata-cl.cl_atd)*24 * c.charter_cost_per_hour)) as total_cost
        FROM (MH.charter c JOIN MH.charter_leg cl on c.charter_nbr = cl.charter_nbr)
        WHERE cl.cl_ata is not null 
        GROUP BY cl.charter_nbr
            ) 
        hours_cost_table ON ch.charter_nbr = hours_cost_table.charter_nbr)
WHERE hours_cost_table.total_cost < (select avg(total_cost) from (SELECT cl.charter_nbr, 
                                                sum(to_char(cl.cl_ata-cl.cl_atd)*24) as total_hours,
                                                sum((to_char(cl.cl_ata-cl.cl_atd)*24 * c.charter_cost_per_hour)) as total_cost
                                                FROM (MH.charter c JOIN MH.charter_leg cl on c.charter_nbr = cl.charter_nbr)
                                                WHERE cl.cl_ata is not null 
                                                GROUP BY cl.charter_nbr ) )
      AND 
      ch.charter_nbr NOT IN 
      (SELECT cl2.charter_nbr
       FROM MH.charter_leg cl2 
       WHERE cl2.cl_ata IS NULL)
GROUP BY ch.charter_nbr, ch.client_nbr, cl.client_lname, 
        cl.client_fname, hours_cost_table.total_cost
ORDER BY hours_cost_table.total_cost DESC;


/*
    Q9
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT ch.charter_nbr, 
       nullif((e.emp_fname || ' '),' ') || e.emp_lname AS PILOTNAME, 
       nullif((cl.client_fname || ' '),' ') || cl.client_lname AS CLIENTNAME
FROM (MH.client cl JOIN MH.charter ch ON cl.client_nbr = ch.client_nbr)
      JOIN
      MH.employee e ON ch.emp_nbr = e.emp_nbr
WHERE ch.charter_nbr not in 
    (SELECT distinct cl.charter_nbr
     FROM MH.charter_leg cl
     WHERE cl.cl_etd != cl.cl_atd
            OR
           cl.cl_atd is null)
ORDER BY ch.charter_nbr;


/*
    Q10
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer
SELECT cli.client_nbr,  
       nullif((cli.client_fname || ' '),' ') || cli.client_lname AS CLIENTNAME,
       loc.location_name,
       max_table.destination_count
FROM MH.location loc join 
     (
     MH.client cli join 
        (
        SELECT * 
        FROM 
        (
            (SELECT c.client_nbr, cl.location_nbr_destination, count(cl.location_nbr_destination) as destination_count
             FROM (MH.charter_leg cl NATURAL JOIN MH.charter c)
             WHERE cl.cl_ata is not null 
             GROUP BY c.client_nbr, cl.location_nbr_destination
             ORDER BY c.client_nbr, cl.location_nbr_destination) new_table
        )
        WHERE (new_table.client_nbr, new_table.destination_count) in 
            (SELECT new_table.client_nbr, max(new_table.destination_count)
             FROM
                (SELECT c.client_nbr, cl.location_nbr_destination, count(cl.location_nbr_destination) as destination_count
                 FROM (MH.charter_leg cl NATURAL JOIN MH.charter c)
                 WHERE cl.cl_ata is not null 
                 GROUP BY c.client_nbr, cl.location_nbr_destination
                 ORDER BY c.client_nbr, cl.location_nbr_destination) 
                 new_table
             GROUP BY new_table.client_nbr
             )
         ) 
         max_table
         ON cli.client_nbr = max_table.client_nbr
     ) 
     ON loc.location_nbr = max_table.location_nbr_destination
WHERE max_table.location_nbr_destination = loc.location_nbr
ORDER BY client_nbr, location_name;
