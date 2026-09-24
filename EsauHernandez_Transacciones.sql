select * from estudiantes
where id_estudiantes = 1;

begin;

update estudiantes
set telefono = '6129999999'
where id_estudiantes = 1;

select * from estudiantes
where id_estudiantes = 1;

commit;

select * from estudiantes
where id_estudiantes = 1;

select * from estudiantes where id_estudiantes = 2;

begin;

update estudiantes
set estado = 'inactivo'
where id_estudiantes = 2;

select * from estudiantes
where id_estudiantes = 2;

rollback;

select * from estudiantes
where id_estudiantes = 2;