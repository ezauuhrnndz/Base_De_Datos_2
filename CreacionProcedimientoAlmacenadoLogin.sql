create table acceso (
    id_acceso serial primary key,
    id_estudiante int not null,
    correo varchar(100) not null,
    contrasena varchar(100) not null,

    constraint fk_acceso_estudiante
        foreign key (id_estudiante)
        references estudiantes(id_estudiantes)
);

insert into acceso (id_estudiante, correo, contrasena)
values
    (1, 'esau@gmail.com', '12345'),
    (2, 'isaac@gmail.com', 'abcde');

create or replace procedure login(
    p_correo varchar,
    p_contrasena varchar
)
language plpgsql
as $$
declare
    contrasena_guardada varchar;
begin
    select contrasena
    into contrasena_guardada
    from acceso
    where correo = p_correo;

    if not found then
        raise notice 'acceso denegado';
    elsif contrasena_guardada = p_contrasena then
        raise notice 'acceso correcto';
    else
        raise notice 'acceso denegado';
    end if;
end;
$$;

call login('esau@gmail.com', '12345');