--Sub-query, query nested inside a larger query 

select*
from (
    select*
    
    from job_postings_fact
    where salary_year_avg is not null
    or salary_hour_avg is not null
);

--CTE we define the temporary result set at the beginning of the query, also this support recursive solutions
--CTE's are preferred as they're default in postgre12+

with positive_salary as (
 select*
    
    from job_postings_fact
    where salary_year_avg is not null
    --or salary_hour_avg is not null
)
select
job_id,
company_id,
job_title_short,
job_country,
salary_rate,
salary_year_avg
from positive_salary
where salary_year_avg between 200000 and 250000;


--subquery questions 
--query1___show each job's salary next to the overall market median 
--query2___stage only jobs that are remote after aggregating 
--query3___keep only those jobs whose median is above the average median 

select
job_title_short,
salary_year_avg,

(
select median(salary_year_avg)
from job_postings_fact
) as salary_median
from job_postings_fact
where salary_year_avg is not null

limit 10;


--q2
select 
job_title_short,
median(salary_year_avg),
job_work_from_home,
from (
select*
from job_postings_fact
where 
job_work_from_home is true
) 
as remote_or_not
where salary_year_avg is not null
group by job_title_short


 limit 20;

 --q2 updated 

select
job_title_short,
median(salary_year_avg),

(
select median(salary_year_avg)
from job_postings_fact
) as salary_median

from (
    select* from
    job_postings_fact
    where job_work_from_home is true or salary_year_avg is not null
    )
    group by job_title_short
limit 10;
--q3 (salary_year_avg by remote jobs)

select
job_title_short,
median(salary_year_avg) as median_salary,

(
    select
    median(salary_year_avg),
    job_work_from_home
    from job_postings_fact
    where 
    job_work_from_home is true
) 

from

(
    select
    job_work_from_home
    from
    job_postings_fact
    where
    job_work_from_home is true
) as WFH_salary

where 
salary_year_avg is not null
group by job_title_short
limit 10;










