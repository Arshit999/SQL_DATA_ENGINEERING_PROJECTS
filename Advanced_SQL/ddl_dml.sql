/*Sub queries can be done in 3 different ways
select statement
from statement 
where statement */
--sub query inside of select statement
select 
 job_id,
 company_id,
 job_title_short,
 (select AVG(salary_year_avg)from job_postings_fact)
 from job_postings_fact;

 -- sub query in from statement (average salary of 5 countries)
 select distinct
 job_country
 from 
 job_postings_fact
 
 order by job_country asc;


 select
 job_id,
 salary_year_avg,
 job_country,
 job_title_short
 from
 
 
