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

