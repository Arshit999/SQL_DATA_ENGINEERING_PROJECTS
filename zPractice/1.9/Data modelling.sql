select
job_id,
company_id,
salary_year_avg,
job_title_short
from 
job_postings_fact
limit 10;



select *
from information_schema.tables
where 
table_catalog='data_jobs';


pragma show_tables_expanded;

select 
jpf.job_title_short,
jpf.job_id,
jpf.salary_year_avg not null,
jpf.job_via,
cd.company_id
from 
job_postings_fact as jpf 
left join Company_dim as cd 
on jpf.Company_id= cd.Company_id
limit 10;



select*
from skills_dim
limit 10;

select*
from skills_job_dim
limit 10;


select 
job_country
from
job_postings_fact;

select 
job_postings_fact.*,
skills_job_dim.*


from job_postings_fact 
inner join skills_job_dim 
on job_postings_fact.job_id = skills_job_dim.job_id;



select 
jpf.job_title_short,
jpf.job_id,
sd.skill_id,
sk.skills


from job_postings_fact as jpf
left join skills_job_dim as sd
on jpf.job_id = sd.job_id
left join skills_dim as sk 
on sk.skill_id= sd.skill_id;
 


 select 
jpf.job_title_short,
jpf.job_id,
sd.skill_id,
sk.skills


from job_postings_fact as jpf
Inner join skills_job_dim as sd
on jpf.job_id = sd.job_id
Inner join skills_dim as sk 
on sk.skill_id= sd.skill_id;



