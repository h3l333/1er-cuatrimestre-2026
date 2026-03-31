-- Punto 1

CREATE TABLE ALUMNO 
(
    matricula int not null,
    nombre varchar(100),
    constraint pk_alumno primary key (matricula)
);

CREATE GENERATOR gen_alumno_mat;
SET GENERATOR gen_alumno_mat TO 0;

SET TERM ^;

CREATE TRIGGER trg_bi_mat_alumno
before insert on alumno
position 0
AS
begin
    IF(NEW.matricula IS NULL) then
        NEW.matricula = gen_id(gen_alumno_mat, 1);
end^

SET TERM ;^

INSERT INTO ALUMNO (nombre) VALUES ('Susana Martinez');
INSERT INTO ALUMNO (nombre) VALUES ('Juan Pérez');
INSERT INTO ALUMNO (nombre) VALUES ('María García');
INSERT INTO ALUMNO (nombre) VALUES ('Lucas Rodríguez');
INSERT INTO ALUMNO (nombre) VALUES ('Sofía Martínez');

-- Punto 2

CREATE TABLE ALUMNO_SECUNDARIA
(
    matricula int,
    COD_ESCUELA_SECUNDARIA int,
    constraint pk_alumno_secu PRIMARY KEY (matricula),
    constraint fk_alumno_secu FOREIGN KEY (matricula) REFERENCES alumno(matricula)
);

CREATE TABLE ALUMNO_PRIMARIA
(
    matricula int,
    COD_ESCUELA_PRIMARIA int,
    constraint pk_alumno_pri PRIMARY KEY (matricula),
    constraint fk_alumno_pri FOREIGN KEY (matricula) REFERENCES alumno(matricula)
);

CREATE EXCEPTION secundaria_primaria 'Un alumno no puede estar en el secundario y primario a la vez.';

SET TERM ^;

CREATE TRIGGER trg_bi_alu_secu
before insert on alumno_secundaria
position 0
as
begin
    IF (EXISTS (
            SELECT 1 FROM ALUMNO_PRIMARIA 
            WHERE MATRICULA = NEW.MATRICULA
        )) THEN
            EXCEPTION SECUNDARIA_PRIMARIA;
end^

SET TERM ;^

INSERT INTO ALUMNO_PRIMARIA
VALUES (1, 20);
INSERT INTO ALUMNO_SECUNDARIA
VALUES (1, 40);

-- Punto 3

CREATE EXCEPTION cupo_limite 'Un alumno de secundaria solo puede estar inscriptos a hasta dos deportes y no más.';

CREATE TABLE deporte (
    cod_deporte int not null,
    descr varchar(100),
    constraint pk_deporte primary key (cod_deporte)
);

CREATE TABLE inscripcion_deporte (
    cod_deporte int not null,
    matricula int not null,
    fecha date,
    constraint pk_inscripcion_deporte primary key (cod_deporte, matricula),
    constraint fk_inscripcion_deporte_1 foreign key (cod_deporte) references deporte (cod_deporte),
    constraint fk_inscripcion_deporte_2 foreign key (matricula) references alumno (matricula)
);

set term ^;

CREATE TRIGGER trg_bi_inscr_deporte 
before insert on inscripcion_deporte
position 0
as
begin
    if ((select count(*) from inscripcion_deporte where matricula = NEW.matricula) >= 2) then
        exception cupo_limite;
end^

set term ;^

INSERT INTO DEPORTE 
VALUES (1, 'Basket');
INSERT INTO DEPORTE
VALUES (2, 'Natación');
INSERT INTO DEPORTE
VALUES (3, 'Voley');

INSERT INTO INSCRIPCION_DEPORTE
VALUES (1, 2, '2026-03-08');
INSERT INTO INSCRIPCION_DEPORTE
VALUES (2, 2, '2026-03-09');
INSERT INTO INSCRIPCION_DEPORTE
VALUES (3, 2, '2026-03-21');

-- Punto 4

CREATE TABLE BOLETIN (
    matricula INT NOT NULL,
    nro_boletin INT NOT NULL,
    observaciones VARCHAR(200),
    fecha_entrega DATE,
    CONSTRAINT pk_boletin PRIMARY KEY (matricula, nro_boletin),
    CONSTRAINT fk_boletin_alumno FOREIGN KEY (matricula) REFERENCES ALUMNO(matricula)
);

SET TERM ^;

CREATE OR ALTER TRIGGER trg_bi_boletin_descendente
BEFORE INSERT ON BOLETIN
POSITION 0
AS
DECLARE VARIABLE max_actual INT;
BEGIN
    SELECT MAX(nro_boletin) 
    FROM BOLETIN 
    WHERE matricula = NEW.matricula
    INTO :max_actual;

    IF (max_actual IS NULL) THEN
        NEW.nro_boletin = 1;
    ELSE
        NEW.nro_boletin = :max_actual + 1;
END^

SET TERM ;^
