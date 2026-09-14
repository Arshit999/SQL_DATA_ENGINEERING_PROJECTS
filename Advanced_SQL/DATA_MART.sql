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
staging.preferred_roles;

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




/*.read Advanced_SQL/DATA_MART.sql
D create database if not exists job_mart;
D 
D show databases;
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
D        
D use job_mart;
D 
D select *
  from information_schema.schemata;
┌──────────────────────┬──────────────────────┬──────────────┬───┬──────────────────────┬──────────────────────┬──────────┐
│     catalog_name     │     schema_name      │ schema_owner │ … │ default_character_…  │ default_character_…  │ sql_path │
│       varchar        │       varchar        │   varchar    │   │       varchar        │       varchar        │ varchar  │
├──────────────────────┼──────────────────────┼──────────────┼───┼──────────────────────┼──────────────────────┼──────────┤
│ data_jobs            │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ job_mart             │ main                 │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
│ job_mart             │ staging              │ duckdb       │ … │ NULL                 │ NULL                 │ NULL     │
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
│ 15 rows                                                                                             7 columns (6 shown) │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
D 
D create schema if not exists staging;
D 
D create table if not exists staging.preferred_roles(
      role_id integer,
      role_name varchar
  );
D 
D create table if not exists details(
      age int,
      name varchar,
      address varchar,
      city varchar,
      street_number int,
  );
D 
D select *
  from information_schema.schemata
  where catalog_name='job_mart';
┌──────────────┬─────────────┬──────────────┬──────────────────────┬───────────────────────────┬────────────────────────────┬──────────┐
│ catalog_name │ schema_name │ schema_owner │ default_character_…  │ default_character_set_s…  │ default_character_set_name │ sql_path │
│   varchar    │   varchar   │   varchar    │       varchar        │          varchar          │          varchar           │ varchar  │
├──────────────┼─────────────┼──────────────┼──────────────────────┼───────────────────────────┼────────────────────────────┼──────────┤
│ job_mart     │ main        │ duckdb       │ NULL                 │ NULL                      │ NULL                       │ NULL     │
│ job_mart     │ staging     │ duckdb       │ NULL                 │ NULL                      │ NULL                       │ NULL     │
└──────────────┴─────────────┴──────────────┴──────────────────────┴───────────────────────────┴────────────────────────────┴──────────┘
D 
D select *
  --from details;
  --from staging.preferred_roles;
  from information_schema.schemata
  where catalog_name='job_mart';
┌──────────────┬─────────────┬──────────────┬──────────────────────┬───────────────────────────┬────────────────────────────┬──────────┐
│ catalog_name │ schema_name │ schema_owner │ default_character_…  │ default_character_set_s…  │ default_character_set_name │ sql_path │
│   varchar    │   varchar   │   varchar    │       varchar        │          varchar          │          varchar           │ varchar  │
├──────────────┼─────────────┼──────────────┼──────────────────────┼───────────────────────────┼────────────────────────────┼──────────┤
│ job_mart     │ main        │ duckdb       │ NULL                 │ NULL                      │ NULL                       │ NULL     │
│ job_mart     │ staging     │ duckdb       │ NULL                 │ NULL                      │ NULL                       │ NULL     │
└──────────────┴─────────────┴──────────────┴──────────────────────┴───────────────────────────┴────────────────────────────┴──────────┘
D 
D 
D 
D  drop table if exists main.preferred_roles;
*/
