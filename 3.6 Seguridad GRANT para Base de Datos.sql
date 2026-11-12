-- invitado_1: control escolar (solo consulta estudiantes)
create role rol_invitado_1 nologin;
create user invitado_1 with password 'Clave_Inv1_2026!';
grant rol_invitado_1 to invitado_1;
grant usage on schema public to rol_invitado_1;
grant select on public.estudiantes to rol_invitado_1;

-- invitado_2: docente (consulta calificaciones y modifica solo la columna calificacion)
create role rol_invitado_2 nologin;
create user invitado_2 with password 'Clave_Inv2_2026!';
grant rol_invitado_2 to invitado_2;
grant usage on schema public to rol_invitado_2;
grant select on public.calificaciones to rol_invitado_2;
grant update (calificacion) on public.calificaciones to rol_invitado_2;

-- invitado_3: caja (consulta y registra pagos, sin alterar los existentes)
create role rol_invitado_3 nologin;
create user invitado_3 with password 'Clave_Inv3_2026!';
grant rol_invitado_3 to invitado_3;
grant usage on schema public to rol_invitado_3;
grant select, insert on public.pagos to rol_invitado_3;
grant usage on sequence public.pagos_id_pago_seq to rol_invitado_3;

-- confidencialidad: vista sin telefono, correo ni fecha de nacimiento
create view public.vista_estudiantes_basica as
select matricula, nombre, apellido
from public.estudiantes;

create role rol_consulta_basica nologin;
create user usuario_consulta_basica with password 'Clave_Basica_2026!';
grant rol_consulta_basica to usuario_consulta_basica;
grant usage on schema public to rol_consulta_basica;
grant select on public.vista_estudiantes_basica to rol_consulta_basica;

set role invitado_1;
select * from estudiantes; 
reset role;

revoke rol_invitado_1 from invitado_1;

set role invitado_1;
select * from estudiantes;          -- permission denied (error 42501)
reset role;