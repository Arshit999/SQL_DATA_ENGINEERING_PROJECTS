-- .read Advanced_SQL/CTAS.SQL
 CREATE OR replace TABLE staging.Job_postings_flat as 
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

--preference '1' includes on senior data engineer and senior data engineer

create OR replace view staging.priority_jobs_view_table AS 
    select
    jpf.*
    from staging.job_postings_flat as jpf
    left join staging.priority_roles as PR
    on jpf.job_title_short= PR.role_name
    where preference_lvl=1;

select count(*) from 
    staging.priority_jobs_view_table;

/*
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│    150678    │
└──────────────┘
*/

select 
job_title_short,
count(*) as job_count
from staging.priority_jobs_view_table
group by job_title_short
order by job_count desc;

/*
┌──────────────────────┬───────────┐
│   job_title_short    │ job_count │
│       varchar        │   int64   │
├──────────────────────┼───────────┤
│ Senior Data Engineer │     91295 │
│ Senior Data Analyst  │     59383 │
└──────────────────────┴───────────┘
*/

create or replace temp table senior_jobs_flat_table as 
select*
from staging.priority_jobs_view_table
where 
job_title_short ='Senior Data Engineer';


select
salary_year_avg,
job_title_short,
job_id,
company_name
from senior_jobs_flat_table
where 
salary_year_avg between 100000 and 200000;
/*
┌─────────────────┬──────────────────────┬─────────┬─────────────────────┐
│ salary_year_avg │   job_title_short    │ job_id  │    company_name     │
│     double      │       varchar        │  int32  │       varchar       │
├─────────────────┼──────────────────────┼─────────┼─────────────────────┤
│        145000.0 │ Senior Data Engineer │ 1177680 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1180500 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1181963 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1183514 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1184950 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1186418 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1189007 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1190349 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1191770 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1193130 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1194499 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1196928 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1198132 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1199321 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1200461 │ X4 Technology       │
│        145000.0 │ Senior Data Engineer │ 1201613 │ X4 Technology       │
│        175500.0 │ Senior Data Engineer │ 1202729 │ Peraton             │
│        115500.0 │ Senior Data Engineer │ 1202842 │ Cognizant           │
│        137500.0 │ Senior Data Engineer │ 1203658 │ eNGINE              │
│        130000.0 │ Senior Data Engineer │ 1203737 │ Resource Data       │
│            ·    │          ·           │     ·   │      ·              │
│            ·    │          ·           │     ·   │      ·              │
│            ·    │          ·           │     ·   │      ·              │
│        120000.0 │ Senior Data Engineer │  241532 │ Mathematica         │
│        173500.0 │ Senior Data Engineer │  242240 │ Capital One         │
│        150000.0 │ Senior Data Engineer │  242566 │ The Phoenix Group   │
│        180000.0 │ Senior Data Engineer │  242592 │ Rearc               │
│        147500.0 │ Senior Data Engineer │  243061 │ Vattenfall          │
│        170000.0 │ Senior Data Engineer │  243432 │ Motion Recruitment  │
│        115000.0 │ Senior Data Engineer │  244028 │ Booz Allen Hamilton │
│        147500.0 │ Senior Data Engineer │  244222 │ Pagaya              │
│        160000.0 │ Senior Data Engineer │  244328 │ Nace Partners       │
│        147500.0 │ Senior Data Engineer │  244699 │ Visa                │
│        160000.0 │ Senior Data Engineer │  244704 │ Intelletec          │
│        170000.0 │ Senior Data Engineer │  245100 │ Alldus              │
│        150000.0 │ Senior Data Engineer │  245731 │ CoStar Group        │
│        147500.0 │ Senior Data Engineer │  247079 │ Visa                │
│        125000.0 │ Senior Data Engineer │  248660 │ Sobeys              │
│        175000.0 │ Senior Data Engineer │  248903 │ Ariel Partners      │
│        147500.0 │ Senior Data Engineer │  249071 │ Snowflake Inc.      │
│        147500.0 │ Senior Data Engineer │  249130 │ Deezer              │
│        183046.0 │ Senior Data Engineer │  249660 │ AT&T                │
│        147500.0 │ Senior Data Engineer │  250080 │ Dun & Bradstreet    │
├─────────────────┴──────────────────────┴─────────┴─────────────────────┤
│ 2667 rows (40 shown)                                         4 columns │
└────────────────────────────────────────────────────────────────────────┘
*/

select count(*)
from staging.job_postings_flat;

select count(*)
from staging.priority_jobs_view_table;

select count(*)
from senior_jobs_flat_table;



delete from staging.job_postings_flat
where job_posted_date > '2024-01-01';

