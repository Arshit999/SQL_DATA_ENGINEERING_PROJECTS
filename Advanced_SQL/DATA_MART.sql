--.read Advanced_SQL/DATA_MART.sql



-- Note: CREATE DATABASE IF NOT EXISTS still throws a Binder Error in DuckDB
-- if the target database is currently in use. Fix: switch to another
-- database first, or DROP DATABASE before recreating.


use my_db;  


drop database if exists job_mart;

create database if not exists job_mart;

show databases;
       
use job_mart;

select *
from information_schema.schemata;

create schema if not exists staging;

create table if not exists staging.preferred_roles(
    role_id integer PRIMARY KEY,
    role_name varchar
);

create table if not exists details(
    person_id int PRIMARY KEY,
    age int,
    name varchar,
    address varchar,
    city varchar,
    street_number int,
);

select *
from information_schema.schemata
where catalog_name='job_mart'; 

select *
--from details;
--from staging.preferred_roles;
from information_schema.schemata
where catalog_name='job_mart';



insert into staging.preferred_roles(role_id,role_name)
values 
(1,'DE'),
(2,'SDE'),
(3,'ADE');


select*
from 
staging.priority_roles;

insert into staging.preferred_roles(role_id,role_name)
values 
(4,'DA'),
(5,'SDA'),
(6,'ADA');

alter table staging.preferred_roles
add column preferred_roles boolean;

update staging.preferred_roles
set preferred_roles= TRUE
WHERE role_id=1 or role_id=2 or role_id=5;

update staging.preferred_roles
set preferred_roles= FALSE
WHERE role_id=3 or role_id=4 or role_id=6;

select*
from 
staging.priority_roles;

 
alter table staging.preferred_roles
rename to priority_roles;


alter table staging.priority_roles
rename column preferred_roles to preference_lvl;


alter table staging.priority_roles
alter column preference_lvl type int;

update staging.priority_roles
set preference_lvl = 3
where role_id=3 or role_id=4 or role_id=6;



/*.read Advanced_SQL/DATA_MART.sql



D .read Advanced_SQL/DATA_MART.sql
┌───────────────────────┐
│     database_name     │
│        varchar        │
├───────────────────────┤
│ data_jobs             │
│ job_mart              │
│ md_information_schema │
│ my_db                 │
│ sample_data           │
└───────────────────────┘
┌──────────────────────┬──────────────────────┬──────────────┬───┬──────────────────────┬──────────────────────┬──────────┐
│     catalog_name     │     schema_name      │ schema_owner │ … │ default_character_…  │ default_character_…  │ sql_path │
│       varchar        │       varchar        │   varchar    │   │       varchar        │       varchar        │ varchar  │
├──────────────────────┼──────────────────────┼──────────────┼───┼──────────────────────┼──────────────────────┼──────────┤
│ data_jobs            │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ job_mart             │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ md_information_sch…  │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ my_db                │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ sample_data          │ hn                   │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ sample_data          │ kaggle               │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ sample_data          │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ sample_data          │ nyc                  │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ sample_data          │ stackoverflow_survey │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ sample_data          │ who                  │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ system               │ information_schema   │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ system               │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ system               │ pg_catalog           │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ temp                 │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
├──────────────────────┴──────────────────────┴──────────────┴───┴──────────────────────┴──────────────────────┴──────────┤
│ 14 rows                                                                                             7 columns (6 shown) │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
┌──────────────┬─────────────┬──────────────┬───────────────────────┬──────────────────────────────┬────────────────────────────┬──────────┐
│ catalog_name │ schema_name │ schema_owner │ default_character_s…  │ default_character_set_schema │ default_character_set_name │ sql_path │
│   varchar    │   varchar   │   varchar    │        varchar        │           varchar            │          varchar           │ varchar  │
├──────────────┼─────────────┼──────────────┼───────────────────────┼──────────────────────────────┼────────────────────────────┼──────────┤
│ job_mart     │ main        │ duckdb       │ NULL                  │ NULL                         │ NULL                       │ NULL     │
│ job_mart     │ staging     │ duckdb       │ NULL                  │ NULL                         │ NULL                       │ NULL     │
└──────────────┴─────────────┴──────────────┴───────────────────────┴──────────────────────────────┴────────────────────────────┴──────────┘
┌──────────────┬─────────────┬──────────────┬───────────────────────┬──────────────────────────────┬────────────────────────────┬──────────┐
│ catalog_name │ schema_name │ schema_owner │ default_character_s…  │ default_character_set_schema │ default_character_set_name │ sql_path │
│   varchar    │   varchar   │   varchar    │        varchar        │           varchar            │          varchar           │ varchar  │
├──────────────┼─────────────┼──────────────┼───────────────────────┼──────────────────────────────┼────────────────────────────┼──────────┤
│ job_mart     │ main        │ duckdb       │ NULL                  │ NULL                         │ NULL                       │ NULL     │
│ job_mart     │ staging     │ duckdb       │ NULL                  │ NULL                         │ NULL                       │ NULL     │
└──────────────┴─────────────┴──────────────┴───────────────────────┴──────────────────────────────┴────────────────────────────┴──────────┘
┌─────────┬───────────┐
│ role_id │ role_name │
│  int32  │  varchar  │
├─────────┼───────────┤
│       1 │ DE        │
│       2 │ SDE       │
│       3 │ ADE       │
└─────────┴───────────┘

D
select*
  from 
  staging.priority_roles;
┌─────────┬───────────┬────────────────┐
│ role_id │ role_name │ preference_lvl │
│  int32  │  varchar  │     int32      │
├─────────┼───────────┼────────────────┤
│       1 │ DE        │              1 │
│       2 │ SDE       │              1 │
│       3 │ ADE       │              0 │
│       4 │ DA        │              0 │
│       5 │ SDA       │              1 │
│       6 │ ADA       │              0 │
└─────────┴───────────┴────────────────┘

D update staging.priority_roles
  set preference_lvl = 3
  where role_id=3 or role_id=4 or role_id=6;


D select*
  from 
  staging.priority_roles;
┌─────────┬───────────┬────────────────┐
│ role_id │ role_name │ preference_lvl │
│  int32  │  varchar  │     int32      │
├─────────┼───────────┼────────────────┤
│       1 │ DE        │              1 │
│       2 │ SDE       │              1 │
│       3 │ ADE       │              3 │
│       4 │ DA        │              3 │
│       5 │ SDA       │              1 │
│       6 │ ADA       │              3 │
└─────────┴───────────┴────────────────┘
*/
