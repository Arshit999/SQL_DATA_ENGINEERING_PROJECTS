select 
sk.skills,
sk.type,
count(jpf.job_id) as demand_count 
from 
job_postings_fact as jpf

left join skills_job_dim as sd
on jpf.job_id = sd.job_id

left join skills_dim as sk
on sk.skill_id = sd.skill_id

where 
jpf.job_location = 'Anywhere' AND
jpf.job_title_short='Data Engineer'
and sk.skills is not null
group by 
sk.skills,
sk.type,
order by demand_count desc
limit 10;



/*
┌────────────┬─────────────┬──────────────┐
  skills   │    type     │ demand_count   │
│  varchar   │   varchar   │    int64     │
├────────────┼─────────────┼──────────────┤
│ sql        │ programming │        29243 │
│ python     │ programming │        28803 │
│ aws        │ cloud       │        17842 │
│ azure      │ cloud       │        14160 │
│ spark      │ libraries   │        12811 │
│ airflow    │ libraries   │         9999 │
│ snowflake  │ cloud       │         8647 │
│ databricks │ cloud       │         8192 │
│ java       │ programming │         7271 │
│ gcp        │ cloud       │         6452 │
├────────────┴─────────────┴──────────────┤
│ 10 rows                       3 columns 
*/