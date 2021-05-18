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


/*
    Q6
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer


/*
    Q7
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer


/*
    Q8
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer


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

