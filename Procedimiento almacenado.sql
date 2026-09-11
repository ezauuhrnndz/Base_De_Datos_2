create or replace procedure cambiar_docente_grupo(
    p_id_grupo int,
    p_id_docente int
)
language plpgsql
as $$
begin
    update grupos
    set id_docente = p_id_docente
    where id_grupo = p_id_grupo;
end;
$$;

call cambiar_docente_grupo(1, 2);