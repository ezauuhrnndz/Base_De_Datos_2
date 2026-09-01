select * from grupos g 

/* =========================================================
   1. trigger - validar cupo del grupo
   ========================================================= */

create or replace function validar_cupo_grupo()
returns trigger
as $$
declare
    total_inscritos int;
    limite_grupo int;
begin

    select count(*)
    into total_inscritos
    from inscripciones
    where id_grupo = new.id_grupo
      and estado = 'inscrito';


    select cupo_maximo
    into limite_grupo
    from grupos
    where id_grupo = new.id_grupo;


    if total_inscritos >= limite_grupo then
        raise exception
        'no se puede realizar la inscripción. el grupo está lleno.';
    end if;


    return new;

end;
$$ language plpgsql;


create trigger trg_validar_cupo_grupo
before insert
on inscripciones
for each row
execute function validar_cupo_grupo();



/* =========================================================
   prueba del trigger
   ========================================================= */

select
    g.id_grupo,
    m.nombre as materia,
    g.grupo,
    g.cupo_maximo,
    count(i.id_inscripcion) as alumnos_inscritos
from grupos g
inner join materias m
    on g.id_materia = m.id_materia
left join inscripciones i
    on g.id_grupo = i.id_grupo
    and i.estado = 'inscrito'
group by
    g.id_grupo,
    m.nombre,
    g.grupo,
    g.cupo_maximo
order by g.id_grupo;



insert into inscripciones
(id_estudiante, id_grupo, id_periodo)
values
(4, 1, 2);

create or replace function validar_monto_pago()
returns trigger
as $$
begin
    if new.monto > 20000 then
        raise exception
        'El monto supera el limite permitido';
    end if;

    return new;

end;
$$ language plpgsql;

create trigger trg_validar_monto_pago
before insert
on pagos
for each row
execute function validar_monto_pago();
