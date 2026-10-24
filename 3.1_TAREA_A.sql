--MIERCOLES 21
select pg_backend_pid()

select * from pg_stat_activity

select * from estudiantes e where e.id_estudiantes=3  

begin;
update grupos 
set cupo_maximo =25 
where id_grupo = 5;
commit;

select * from grupos g where id_grupo = 5;

rollback;

--JUEVES 22

--id de la sesion 35
--actualizar las calificaciones pero en las sesion a
-- se realizara un rollback y en b vamos a ver que sucede
select pg_backend_pid()

begin;

update calificaciones 
set calificacion = 40
where id_calificacion = 6;

select calificacion from calificaciones where id_calificacion = 6;

rollback;

--perdida de datos (informacion)

select * from pagos;

select monto from pagos where id_pago = 2 for update;

begin;

update pagos p 
set monto = 2000
where p.id_pago = 2;

rollback ;

--bloqueo de for update



