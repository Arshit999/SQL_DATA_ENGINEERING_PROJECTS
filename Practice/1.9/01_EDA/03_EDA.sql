select 
sk.skills,
count(DISTINCT jpf.job_id) as demand_count,
median(jpf.salary_year_avg) as salary_count,

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
having count(*)>50
order by
demand_count desc,
salary_count desc;
/*
┌────────────┬──────────────┬───────────────┐
│   skills   │ demand_count │ salary_count  │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ python     │         1133 │      135000.0 │
│ sql        │         1128 │      130000.0 │
│ aws        │          783 │   137320.3125 │
│ spark      │          503 │      140000.0 │
│ azure      │          475 │      128000.0 │
│ snowflake  │          438 │      135500.0 │
│ airflow    │          386 │      150000.0 │
│ java       │          303 │      135000.0 │
│ kafka      │          292 │      145000.0 │
│ redshift   │          274 │      130000.0 │
│ databricks │          266 │      132750.0 │
│ scala      │          247 │ 137290.484375 │
│ git        │          208 │      140000.0 │
│ hadoop     │          198 │      135000.0 │
│ gcp        │          196 │      136000.0 │
│ terraform  │          193 │      184000.0 │
│ nosql      │          193 │      134415.0 │
│ tableau    │          164 │      115000.0 │
│ pyspark    │          152 │      140000.0 │
│ kubernetes │          147 │      150500.0 │
│   ·        │           ·  │          ·    │
│   ·        │           ·  │          ·    │
│   ·        │           ·  │          ·    │
│ github     │          127 │      135000.0 │
│ bigquery   │          123 │      135000.0 │
│ go         │          113 │      140000.0 │
│ oracle     │          109 │      124500.0 │
│ flow       │          107 │      125500.0 │
│ mysql      │          101 │      130500.0 │
│ pandas     │           98 │      140000.0 │
│ ssis       │           96 │      118500.0 │
│ word       │           92 │      140000.0 │
│ looker     │           87 │      136000.0 │
│ linux      │           86 │      115000.0 │
│ excel      │           77 │      116000.0 │
│ c#         │           72 │      122500.0 │
│ mongodb    │           68 │      135750.0 │
│ jira       │           68 │      110650.0 │
│ shell      │           67 │      125000.0 │
│ javascript │           59 │      117500.0 │
│ jenkins    │           57 │      135000.0 │
│ dynamodb   │           55 │      136000.0 │
│ sas        │           36 │      115000.0 │
├────────────┴──────────────┴───────────────┤
│ 45 rows (40 shown)              3 columns │
└───────────────────────────────────────────┘
*/


SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    LN(COUNT(jpf.*)) AS ln_demand_count,
    MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    optimal_score DESC
LIMIT 25;

/*
┌────────────┬───────────────┬──────────────┬────────────────────┬───────────────────┐
│   skills   │ median_salary │ demand_count │  ln_demand_count   │   optimal_score   │
│  varchar   │    double     │    int64     │       double       │      double       │
├────────────┼───────────────┼──────────────┼────────────────────┼───────────────────┤
│ terraform  │      184000.0 │          193 │  5.262690188904886 │  968334.994758499 │
│ python     │      135000.0 │         1133 │ 7.0326242610280065 │ 949404.2752387809 │
│ aws        │      137320.0 │          783 │  6.663132695990803 │ 914983.4640424246 │
│ sql        │      130000.0 │         1128 │  7.028201432058005 │ 913666.1861675406 │
│ airflow    │      150000.0 │          386 │  5.955837369464831 │ 893375.6054197246 │
│ spark      │      140000.0 │          503 │  6.220590170099739 │ 870882.6238139635 │
│ snowflake  │      135500.0 │          438 │  6.082218910376446 │ 824140.6623560084 │
│ kafka      │      145000.0 │          292 │  5.676753802268282 │ 823129.3013289009 │
│ azure      │      128000.0 │          475 │  6.163314804034641 │ 788904.2949164341 │
│ java       │      135000.0 │          303 │  5.713732805509369 │ 771353.9287437648 │
│ scala      │      137290.0 │          247 │ 5.5093883366279774 │ 756386.5933456306 │
│ kubernetes │      150500.0 │          147 │  4.990432586778736 │ 751060.1043101997 │
│ git        │      140000.0 │          208 │  5.337538079701318 │ 747255.3311581844 │
│ databricks │      132750.0 │          266 │  5.583496308781699 │ 741209.1349907706 │
│ redshift   │      130000.0 │          274 │ 5.6131281063880705 │ 729706.6538304492 │
│ gcp        │      136000.0 │          196 │  5.278114659230517 │ 717823.5936553503 │
│ hadoop     │      135000.0 │          198 │  5.288267030694535 │ 713916.0491437622 │
│ nosql      │      134415.0 │          193 │  5.262690188904886 │ 707384.5017416502 │
│ pyspark    │      140000.0 │          152 │ 5.0238805208462765 │ 703343.2729184787 │
│ docker     │      135000.0 │          144 │  4.969813299576001 │ 670924.7954427601 │
│ mongodb    │      135750.0 │          136 │  4.912654885736052 │ 666892.9007386691 │
│ go         │      140000.0 │          113 │  4.727387818712341 │ 661834.2946197278 │
│ r          │      134775.0 │          133 │  4.890349128221754 │ 659096.8037560869 │
│ github     │      135000.0 │          127 │  4.844187086458591 │ 653965.2566719098 │
│ bigquery   │      135000.0 │          123 │  4.812184355372417 │ 649644.8879752763 │
├────────────┴───────────────┴──────────────┴────────────────────┴───────────────────┤
│ 25 rows                                                                  5 columns │
└────────────────────────────────────────────────────────────────────────────────────┘
*/