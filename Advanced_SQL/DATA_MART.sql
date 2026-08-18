--.read Advanced_SQL/DATA_MART.sql

drop database if exists job_mart;

create database is not exists job_mart;

show databases;
       
use job_mart;

select *
from information_schema.schemata;

create schema if not exists staging;

create table if not exists staging.preferred_roles(
    role_id integer,
    role_name varchar
);

select *
from information_schema.schemata
where catalog_name='job_mart';


select *
from information_schema.tables
where table_catalog='job_mart';

 drop table if exists main.preferred_roles;



 /*D .read Advanced_SQL/DATA_MART.sql
Binder Error:
Failed to create database: database with name "job_mart" already exists
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
Catalog Error:
Schema with name "staging" already exists!
D .read Advanced_SQL/DATA_MART.sql
Binder Error:
Failed to create database: database with name "job_mart" already exists
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
Catalog Error:
Schema with name "staging" already exists!
D .read Advanced_SQL/DATA_MART.sql
Binder Error:
Failed to create database: database with name "job_mart" already exists
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
│ 15 rows                                                                                             7 columns (6 shown) │*/

