

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