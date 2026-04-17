-- EN EL NODO 1

-- Inserts ------------------------------

SET TERM ^ ;

CREATE OR ALTER PROCEDURE INSERTAR_EN_BDD_EXTERNA_LOCAL (
    cod_post INT
)
AS
    DECLARE VARIABLE sentencia_sql VARCHAR(200);
BEGIN
    -- Armo la sentencia
    sentencia_sql = 'INSERT INTO LOCALIDAD (CODIGO_POSTAL) VALUES (' || :cod_post || ')';
    
    -- La envio al 2do nodo
    EXECUTE STATEMENT :sentencia_sql
    ON EXTERNAL '192.168.100.26/3050:/var/lib/firebird/data/BDD_NODO_2.fdb'
    AS USER 'SYSDBA' PASSWORD 'masterkey';
END^

SET TERM ; ^

SET TERM ^ ;

CREATE OR ALTER PROCEDURE INSERTAR_EN_BDD_EXTERNA_CLI (
     nombre varchar(50),
     id_local int
)
AS
    DECLARE VARIABLE sentencia_sql VARCHAR(200);
BEGIN
    -- Armo la sentencia
    sentencia_sql = 'INSERT INTO CLIENTE (nombre, id_local) VALUES (' 
                    || '''' || :nombre || '''' || ', ' 
                    || :id_local || ')';
    
    -- La envio al 2do nodo
    EXECUTE STATEMENT :sentencia_sql
    ON EXTERNAL '192.168.100.26/3050:/var/lib/firebird/data/BDD_NODO_2.fdb'
    AS USER 'SYSDBA' PASSWORD 'masterkey';
END^

SET TERM ; ^

-- Deletes ------------------------------

SET TERM ^ ;

CREATE OR ALTER PROCEDURE ELIMINAR_EN_BDD_EXTERNA (
     tabla varchar(200),
     nombre_id_tabla varchar(200),
     id int
)
AS
    DECLARE VARIABLE sentencia_sql VARCHAR(200);
BEGIN
    -- Armo la sentencia
    sentencia_sql = 'DELETE FROM ' || :tabla || ' WHERE ' || :nombre_id_tabla || ' = ' || :id || ' ';
    
    -- La envio al 2do nodo
    EXECUTE STATEMENT :sentencia_sql
    ON EXTERNAL '192.168.100.26/3050:/var/lib/firebird/data/BDD_NODO_2.fdb'
    AS USER 'SYSDBA' PASSWORD 'masterkey';
END^

SET TERM ; ^

-- Updates ------------------------------

SET TERM ^ ;

CREATE OR ALTER PROCEDURE UPDATE_SOBRE_BDD_EXTERNA_CLI (
    id_cli INTEGER,
    nuevo_nom VARCHAR(50),
    nueva_loc INTEGER
)
AS
DECLARE VARIABLE sentencia_sql VARCHAR(1000);
BEGIN
    -- Uso COALESCE por temas de eficacia
    -- Hay 4 comillas alrededor de || :nuevo_nom ||: el par externo es para que el motor sepa que estoy empezando y terminando de escribir un texto, el par de adentro forman una sola comilla,
    -- y la 4ta termina el bloque de texto
    sentencia_sql = 'UPDATE CLIENTE
        SET NOMBRE = ' || COALESCE('''' || :nuevo_nom || '''', 'NOMBRE') || ', 
        ID_LOCAL = ' || COALESCE(:nueva_loc, 'ID_LOCAL') || '
        WHERE ID_CLIENTE = ' || :id_cli;

    EXECUTE STATEMENT (:sentencia_sql)
    ON EXTERNAL '192.168.100.26/3050:/var/lib/firebird/data/BDD_NODO_2.fdb'
    AS USER 'SYSDBA' PASSWORD 'masterkey';
END^

SET TERM ; ^

SET TERM ^ ;

CREATE OR ALTER PROCEDURE UPDATE_SOBRE_BDD_EXTERNA_LOCAL (
    id_local INT,
    nuevo_cod_post INT
)
AS
DECLARE VARIABLE sentencia_sql VARCHAR(1000);
BEGIN
    sentencia_sql = 'UPDATE LOCALIDAD
        SET CODIGO_POSTAL = ' || :nuevo_cod_post || ' 
        WHERE ID_LOCAL = ' || :id_local;

    EXECUTE STATEMENT (:sentencia_sql)
    ON EXTERNAL '192.168.100.26/3050:/var/lib/firebird/data/BDD_NODO_2.fdb'
    AS USER 'SYSDBA' PASSWORD 'masterkey';
END^

SET TERM ; ^

-- Triggers asociados ------------------------------

-- Inserts ------------------------------

SET TERM ^;

CREATE TRIGGER TRG_LOCAL_REPLICAR_INSERT_AI FOR LOCALIDAD
AFTER INSERT AS
begin
    EXECUTE PROCEDURE INSERTAR_EN_BDD_EXTERNA_LOCAL(NEW.CODIGO_POSTAL);
END^

SET TERM ;^

SET TERM ^;

CREATE TRIGGER TRG_CLIENTE_REPLICAR_INSERT_AI FOR CLIENTE
AFTER INSERT AS
begin
    EXECUTE PROCEDURE INSERTAR_EN_BDD_EXTERNA_CLI(NEW.NOMBRE, NEW.ID_LOCAL);
END^

SET TERM ;^

-- Deletes ------------------------------

SET TERM ^;

CREATE TRIGGER TRG_LOCAL_REPLICAR_DELETE_AD FOR LOCALIDAD
AFTER DELETE AS
begin
    EXECUTE PROCEDURE ELIMINAR_EN_BDD_EXTERNA('LOCALIDAD', 'ID_LOCAL', old.ID_LOCAL);
END^

SET TERM ;^

SET TERM ^;

CREATE TRIGGER TRG_CLIENTE_REPLICAR_DELETE_AD FOR CLIENTE
AFTER DELETE AS
begin
    EXECUTE PROCEDURE ELIMINAR_EN_BDD_EXTERNA('CLIENTE', 'ID_CLIENTE', old.ID_CLIENTE);
END^

SET TERM ;^

-- Updates ------------------------------

SET TERM ^;

CREATE TRIGGER TRG_CLIENTE_REPLICAR_UPDATE_AU FOR CLIENTE
AFTER UPDATE AS
begin
    EXECUTE PROCEDURE UPDATE_SOBRE_BDD_EXTERNA_CLI(new.ID_CLIENTE, new.NOMBRE, new.ID_LOCAL);
END^

SET TERM ;^

SET TERM ^;

CREATE TRIGGER TRG_LOCAL_REPLICAR_UPDATE_AU FOR LOCALIDAD
AFTER UPDATE AS
begin
    EXECUTE PROCEDURE UPDATE_SOBRE_BDD_EXTERNA_LOCAL(new.ID_LOCAL, new.CODIGO_POSTAL);
END^

SET TERM ;^

-- Pruebas ------------------------------

EXECUTE PROCEDURE INSERTAR_EN_BDD_EXTERNA_LOCAL(1708);
EXECUTE PROCEDURE ELIMINAR_EN_BDD_EXTERNA('LOCALIDAD', 'ID_LOCAL', 1);
EXECUTE PROCEDURE UPDATE_SOBRE_BDD_EXTERNA_LOCAL(3, 2000);
INSERT INTO LOCALIDAD(CODIGO_POSTAL) VALUES(9084);
INSERT INTO CLIENTE(nombre, id_local) VALUES ('Romina', 1);