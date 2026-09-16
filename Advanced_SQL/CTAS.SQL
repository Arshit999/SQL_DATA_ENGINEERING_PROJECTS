--CTAS #CONTROL TABLE AS SELECT
 CREATE TABLE staging.Job_postings_flat as 
 SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,

FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON cd.company_id = jpf.company_id;



    select count(*) from 
    staging.Job_postings_flat;

/*
┌────────────────┐
│  count_star()  │ 
│     int64      │
├────────────────┤
│    1615930     │
│ (1.62 million) │
└────────────────┘
*/




    select*
    from staging.job_postings_flat as jpf
    left join staging.priority_roles as PR
    on jpf.job_title_short= PR.role_name;