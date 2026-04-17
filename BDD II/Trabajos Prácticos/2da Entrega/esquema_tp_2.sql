-- Creacion de tablas en el nodo 1

create table localidad(
    id_local int primary key not null,
    codigo_postal int not null
);

create table cliente(
    id_cliente int primary key not null,
    nombre varchar(50) not null,
    id_local int not null,
    
    constraint fk_cliente_local foreign key (id_local)
    references localidad(id_local)
);

-- Generadores y triggers BEFORE INSERT asociados en el nodo 1

CREATE GENERATOR gen_local_id;
SET GENERATOR gen_local_id TO 0;

CREATE GENERATOR gen_cli_id;
SET GENERATOR gen_cli_id TO 0;

SET TERM ^;

CREATE TRIGGER trg_bi_local for localidad
active before insert position 0
as
begin
    new.ID_LOCAL = gen_id(gen_local_id, 1);
end^

SET TERM ;^

SET TERM ^;

CREATE TRIGGER trg_bi_cliente for cliente
active before insert position 0
as
begin
    new.ID_CLIENTE = gen_id(gen_cli_id, 1);
end^

SET TERM ;^