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
SELECT ch.charter_nbr, ch.client_nbr, cl.client_lname, cl.client_fname, ch.charter_special_reqs
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
      JOIN MH.location lc ON (chl.location_nbr_origin = lc.location_nbr
                              OR
                              chl.location_nbr_destination = lc.location_nbr)
WHERE lc.location_name = 'Mount Doom'
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
SELECT cl.charter_nbr, to_char(cl.cl_atd, 'DD Mon YYYY HH24:MI:SS')
FROM ((MH.employee e JOIN MH.charter c ON e.emp_nbr = c.emp_nbr)
       JOIN
       MH.charter_leg cl ON c.charter_nbr = cl.charter_nbr)
WHERE e.emp_fname = 'Frodo' AND e.emp_lname = 'Baggins'
      AND
      cl.cl_leg_nbr = 1
ORDER BY cl.cl_atd DESC;


/*
    Q8
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer

SELECT ch.charter_nbr, ch.client_nbr, NVL(cl.client_lname, '-'), NVL(cl.client_fname, '-'),
        ((to_char(chl.cl_ata, 'HH') - to_char(chl.cl_atd, 'HH')) * ch.charter_cost_per_hour) AS "TOTALCHARTERCOST"
--select * 
FROM ((MH.client cl JOIN MH.charter ch ON cl.client_nbr = ch.client_nbr)
       JOIN
       MH.charter_leg chl ON ch.charter_nbr = chl.charter_nbr)
where ((to_char(chl.cl_ata, 'HH') - to_char(chl.cl_atd, 'HH')) * ch.charter_cost_per_hour) 
        <
--        AVG((to_char(chl.cl_ata, 'HH') - to_char(chl.cl_atd, 'HH')) * ch.charter_cost_per_hour) ;   
        any(select avg((to_char(chl.cl_ata, 'HH') - to_char(chl.cl_atd, 'HH')) * ch.charter_cost_per_hour) 
        from (MH.charter_leg chl JOIN MH.charter ch on ch.charter_nbr = chl.charter_nbr)
        GROUP BY ch.charter_nbr);

/*
    Q9
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer


/*
    Q10
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer

