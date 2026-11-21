--sesion C

select
    bloqueada.pid             as pid_bloqueado,
    bloqueada.state           as estado_bloqueado,
    bloqueada.wait_event_type as tipo_espera,
    bloqueada.query           as consulta_en_espera,
    bloqueadora.pid           as pid_que_bloquea,
    bloqueadora.state         as estado_bloqueadora,
    bloqueadora.query         as consulta_que_bloquea
from pg_stat_activity bloqueada
join pg_stat_activity bloqueadora
    on bloqueadora.pid = any(pg_blocking_pids(bloqueada.pid));

select * from inventario_concurrencia;