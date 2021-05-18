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


/*
    Q4
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE your query has a semicolon (;) at the end of this answer


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

