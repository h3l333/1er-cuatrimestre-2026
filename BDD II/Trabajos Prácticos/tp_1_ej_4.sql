-- Se guarda en una BDD registros de estudiantes. Cada uno puede tener varias carpetas.

CREATE TABLE estudiante
(
    mat INT NOT NULL,
    nombre VARCHAR(50),
    CONSTRAINT pk_estudiante PRIMARY KEY (mat)
);

CREATE TABLE carpeta
(
    mat_estudiante INT NOT NULL,
    nro_carpeta INT NOT NULL,
    materia VARCHAR(50),
    CONSTRAINT pk_carpeta PRIMARY KEY (mat_estudiante, nro_carpeta),
    CONSTRAINT fk_carpeta FOREIGN KEY (mat_estudiante) REFERENCES estudiante(mat) ON DELETE CASCADE
);

CREATE GENERATOR gen_nro_carpeta;
SET GENERATOR gen_nro_carpeta TO 0;

SET TERM ^;

CREATE TRIGGER trg_bi_carpeta FOR carpeta
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    NEW.NRO_CARPETA = GEN_ID(gen_nro_carpeta, 1); 
END^

SET TERM ;^

-- Compruebo

INSERT INTO estudiante
VALUES (100, 'Catalina Bordeau');

INSERT INTO carpeta (mat_estudiante, materia)
values (100, 'Biología');

INSERT INTO carpeta (mat_estudiante, materia)
values (100, 'Historia');

INSERT INTO carpeta (mat_estudiante, materia)
values (101, 'Química');

SELECT * FROM carpeta;