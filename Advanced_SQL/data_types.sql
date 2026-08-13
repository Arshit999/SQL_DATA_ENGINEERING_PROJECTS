select
table_name,
data_type,
column_name
from
information_schema.columns
where
table_name='job_postings_fact';


select 
cast(job_id as varchar) || '--' || cast(company_id as varchar),
cast(salary_hour_avg as int),
cast(salary_year_avg as int),
cast(job_posted_date as date),
cast(job_work_from_home as int),
cast(job_health_insurance as int),
from 
job_postings_fact
where
salary_year_avg is not null or
salary_hour_avg is not null
limit 1000;