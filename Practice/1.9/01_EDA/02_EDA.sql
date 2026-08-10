select 
sk.skills,
count(jpf.*) as demand_count,
median(jpf.salary_year_avg) as salary_count

from job_postings_fact as jpf

left join skills_job_dim as sd
on jpf.job_id = sd.job_id

left join skills_dim as sk
on sk.skill_id = sd.skill_id

where 
job_title_short='Data Engineer' AND
job_work_from_home= 'True' AND 
salary_year_avg is not null
group by 
sk.skills,
having
count(jpf.*)>100
order by
salary_count  desc;


/*
┌────────────┬──────────────┬───────────────┐
│   skills   │ demand_count │ salary_count  │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ terraform  │          193 │      184000.0 │
│ kubernetes │          147 │      150500.0 │
│ airflow    │          386 │      150000.0 │
│ kafka      │          292 │      145000.0 │
│ pyspark    │          152 │      140000.0 │
│ git        │          208 │      140000.0 │
│ spark      │          503 │      140000.0 │
│ go         │          113 │      140000.0 │
│ aws        │          783 │   137320.3125 │
│ scala      │          247 │ 137290.484375 │
│ gcp        │          196 │      136000.0 │
│ mongodb    │          136 │      135750.0 │
│ snowflake  │          438 │      135500.0 │
│ github     │          127 │      135000.0 │
│ java       │          303 │      135000.0 │
│ bigquery   │          123 │      135000.0 │
│ hadoop     │          198 │      135000.0 │
│ docker     │          144 │      135000.0 │
│ python     │         1133 │      135000.0 │
│ r          │          133 │      134775.0 │
│ nosql      │          193 │      134415.0 │
│ databricks │          266 │      132750.0 │
│ mysql      │          101 │      130500.0 │
│ sql        │         1128 │      130000.0 │
│ redshift   │          274 │      130000.0 │
│ azure      │          475 │      128000.0 │
│ flow       │          107 │      125500.0 │
│ oracle     │          109 │      124500.0 │
│ postgresql │          129 │      122500.0 │
│ sql server │          139 │      120000.0 │
│ power bi   │          129 │      120000.0 │
│ tableau    │          164 │      115000.0 │
├────────────┴──────────────┴───────────────┤
│ 32 rows                         3 columns 
*/