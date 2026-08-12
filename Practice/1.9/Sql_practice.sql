select 
job_title_short,
job_country,
salary_year_avg
from
job_postings_fact
where 
salary_year_avg is between 100000 and 200000
AND 
job_title_short ='Data Engineer'
