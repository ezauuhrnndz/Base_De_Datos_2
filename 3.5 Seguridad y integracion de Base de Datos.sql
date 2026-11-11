create user DEV_BD
with password '123DEV'

create user QA_BD
with password '123QA'

create user PROD_BD
with password '123PROD'

select * from pg_roles

create role rol_dev nologin
create role rol_qa nologin

grant rol_dev to DEV_BD;