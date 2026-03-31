CREATE TABLE FACTURA
(
    nro_factura int,
    importe double precision,
    estado smallint,
    fecha date,
    CONSTRAINT pk_factura
        PRIMARY KEY (nro_factura)
);

CREATE TABLE PRODUCTO
(
    id_prod int,
    descr varchar(200),
    stock int,
    precio_base double precision,
    precio_costo double precision,
    CONSTRAINT pk_prod
        PRIMARY KEY (id_prod)
);

CREATE TABLE DETALLE
(
    nro_factura int,
    id_prod int,
    cant int,
    precio double precision,
    CONSTRAINT pk_detalle
        PRIMARY KEY (nro_factura, id_prod),
    CONSTRAINT fk_detalle
        FOREIGN KEY (nro_factura) REFERENCES FACTURA(nro_factura),
    CONSTRAINT fk_detalle_2
        FOREIGN KEY (id_prod) REFERENCES PRODUCTO(id_prod)
);

-- Lleno las tablas con datos

INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (1, 'Teclado Mecánico RGB', 50, 85.00, 45.00);
INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (2, 'Mouse Óptico Inalámbrico', 120, 25.50, 12.00);
INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (3, 'Monitor 24" Full HD', 30, 180.00, 110.00);
INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (4, 'Auriculares Noise Cancelling', 45, 120.00, 70.00);
INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (5, 'Memoria RAM 16GB DDR4', 100, 65.00, 40.00);
INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (6, 'Disco SSD 1TB NVMe', 60, 95.00, 55.00);
INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (7, 'Webcam 1080p', 25, 45.00, 22.00);
INSERT INTO PRODUCTO (id_prod, descr, stock, precio_base, precio_costo) VALUES (8, 'Pad Mouse XXL', 200, 15.00, 5.00);

INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (1001, 290.50, 1, '2024-01-15');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (1002, 120.00, 1, '2024-01-16');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (1003, 110.00, 0, '2024-01-17');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (1004, 345.00, 1, '2024-01-18');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (1005, 15.00, 1, '2024-01-19');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (1006, 210.00, 0, '2024-01-20');

/* Detalles de Factura 1001 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1001, 1, 1, 85.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1001, 2, 1, 25.50);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1001, 3, 1, 180.00);

/* Detalles de Factura 1002 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1002, 4, 1, 120.00);

/* Detalles de Factura 1003 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1003, 7, 2, 45.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1003, 8, 1, 20.00);

/* Detalles de Factura 1004 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1004, 5, 2, 65.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1004, 6, 2, 95.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1004, 2, 1, 25.00);

/* Detalles de Factura 1005 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1005, 8, 1, 15.00);

/* Detalles de Factura 1006 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1006, 1, 2, 85.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (1006, 7, 1, 40.00);

-- Punto 1

CREATE EXCEPTION stock_insuficiente 'El stock del producto especificado es insuficiente!';

SET TERM ^;

CREATE TRIGGER bi_detalle_descontar_stock
BEFORE INSERT ON DETALLE
AS
DECLARE VARIABLE stock_prod int;
begin
    SELECT stock from PRODUCTO
    where id_prod = NEW.id_prod
    into :stock_prod;
    
    if(:stock_prod <= NEW.cant) then
    begin
        exception stock_insuficiente;
    end
    else
    begin
        update PRODUCTO
        set stock = stock - NEW.cant
        where id_prod = NEW.id_prod;
    end
END^

SET TERM ;^

-- Prueba

INSERT INTO DETALLE(id_prod, nro_factura, cant, precio)
VALUES(7, 1001, 30, 10);

-- Añado datos 

/* Año 2022 */
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2001, 150.00, 1, '2022-03-10');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2002, 45.00, 1, '2022-08-15');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2003, 210.00, 1, '2022-11-22');

/* Año 2023 */
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2004, 85.00, 1, '2023-01-05');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2005, 300.00, 0, '2023-04-12');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2006, 120.00, 1, '2023-06-30');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2007, 15.00, 1, '2023-09-18');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2008, 65.00, 1, '2023-12-24');

/* Año 2025 */
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2009, 180.00, 1, '2025-02-14');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2010, 25.50, 1, '2025-05-10');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2011, 400.00, 0, '2025-07-22');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2012, 95.00, 1, '2025-08-05');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2013, 110.00, 1, '2025-10-30');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2014, 250.00, 1, '2025-12-15');

/* Año 2026 (Futuro/Actual) */
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2015, 120.00, 0, '2026-01-10');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2016, 30.00, 1, '2026-02-01');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2017, 180.00, 1, '2026-02-28');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2018, 55.00, 1, '2026-03-15');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2019, 90.00, 0, '2026-03-25');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (2020, 25.00, 1, '2026-03-29');

-- Más detalles 

/* Detalles 2022 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2001, 3, 1, 150.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2002, 7, 1, 45.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2003, 1, 2, 85.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2003, 2, 2, 20.00);

/* Detalles 2023 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2004, 1, 1, 85.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2005, 3, 1, 180.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2005, 4, 1, 120.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2006, 4, 1, 120.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2007, 8, 1, 15.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2008, 5, 1, 65.00);

/* Detalles 2025 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2009, 3, 1, 180.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2010, 2, 1, 25.50);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2011, 6, 4, 100.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2012, 6, 1, 95.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2013, 7, 2, 55.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2014, 5, 2, 65.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2014, 4, 1, 120.00);

/* Detalles 2026 */
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2015, 4, 1, 120.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2016, 8, 2, 15.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2017, 3, 1, 180.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2018, 7, 1, 55.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2019, 7, 2, 45.00);
INSERT INTO DETALLE (nro_factura, id_prod, cant, precio) VALUES (2020, 2, 1, 25.00);

-- Punto 2

SET TERM ^;

CREATE OR ALTER TRIGGER ai_detalle_importe_factura 
AFTER INSERT ON DETALLE
POSITION 0
AS
begin
    UPDATE FACTURA
    SET importe = importe + NEW.cant * NEW.precio
    where NEW.nro_factura = nro_factura;
END^

SET TERM ;^

INSERT INTO DETALLE
VALUES (1001, 6, 3, 300);

-- Punto 3

CREATE EXCEPTION precio_bajo_base 'Un producto no puede venderse por debajo de su precio base.';

SET TERM ^;

CREATE OR ALTER TRIGGER bi_detalle_precio_base
BEFORE INSERT ON DETALLE
POSITION 0
AS
DECLARE VARIABLE precio_base double precision;
begin
    SELECT precio_base from PRODUCTO
    where id_prod = NEW.id_prod
    into :precio_base;
    
    if(:precio_base > NEW.precio) then
        exception precio_bajo_base;
END^

SET TERM ;^

INSERT INTO DETALLE
VALUES (1002, 7, 3, 30);

-- Punto 4

SET TERM ^;

CREATE OR ALTER TRIGGER bu_estado_factura
ACTIVE BEFORE UPDATE ON FACTURA
POSITION 0
AS
DECLARE VARIABLE id_producto INT;
DECLARE VARIABLE cantidad INT;
BEGIN
    IF(OLD.estado = 1) then
    begin
        if(NEW.estado = 0) then
        begin
            exception ESTADO_INVALIDO;
        end
        else if (NEW.estado = 2) then
        begin
            -- Recorro detalles que coinciden
            FOR SELECT id_prod, cant FROM DETALLE
            where nro_factura = NEW.nro_factura
            INTO :id_producto, :cantidad
            DO
            begin
                -- Actualizo producto correspondiente a :id_producto
                UPDATE PRODUCTO
                SET STOCK = STOCK + :cantidad
                where id_prod = :id_producto;
            end
        end
    END
    ELSE IF(OLD.estado = 2) then
    begin
       if(NEW.estado = 0) then
        begin
            exception ESTADO_INVALIDO;
        end
        else if (NEW.estado = 2) then
        begin
            -- Recorro detalles que coinciden
            FOR SELECT id_prod, cant FROM DETALLE
            where nro_factura = NEW.nro_factura
            INTO :id_producto, :cantidad
            DO
            begin
                -- Actualizo producto correspondiente a :id_producto
                UPDATE PRODUCTO
                SET STOCK = STOCK - :cantidad
                where id_prod = :id_producto;
            end
        end
    end
END^

SET TERM ;^

-- Punto 5

CREATE EXCEPTION fecha_invalida_factura 'No puede insertar una fecha anterior a la de la factura anterior.';

SET TERM ^;

CREATE TRIGGER trg_bi_factura_fecha ACTIVE
BEFORE INSERT ON FACTURA
POSITION 1
AS
declare variable fecha_factura_ant date;
begin
    SELECT fecha from factura
    where nro_factura = NEW.nro_factura - 1
    into fecha_factura_ant;
    
    IF(fecha_factura_ant > NEW.fecha) then
        exception fecha_invalida_factura;
end^

SET TERM ;^

-- SELECT PROCEDURES

-- Punto 1

SET TERM ^;

-- 'SP' solo quiere decir 'stored procedure'
CREATE PROCEDURE SP_FACT_POR_RANGO (
    in_desde DOUBLE PRECISION,
    in_hasta DOUBLE PRECISION
)
RETURNS (
    OUT_NRO_FACTURA INT,
    OUT_FECHA DATE,
    OUT_ESTADO SMALLINT,
    OUT_IMPORTE DOUBLE PRECISION
)
AS
begin
    FOR SELECT nro_factura, fecha, estado, importe
        FROM factura
        WHERE importe BETWEEN :in_desde AND :in_hasta
        INTO :out_nro_factura, :out_fecha, :out_estado, :out_importe
    DO
    begin
        suspend;
        -- suspend es el comando que "empuja" la fila actual a la pantalla del usuario
    end
END^

SET TERM ;^

-- Punto 2

SET TERM ^;

CREATE PROCEDURE SP_FACT_POR_RANGO_2 (
    in_desde DOUBLE PRECISION,
    in_hasta DOUBLE PRECISION
)
RETURNS (
    OUT_NRO_FACTURA INT,
    OUT_FECHA DATE,
    OUT_ESTADO SMALLINT,
    OUT_IMPORTE DOUBLE PRECISION
)
AS
begin
    IF (in_desde IS null) then
    begin
        SELECT MIN(importe) 
        FROM FACTURA 
        INTO :in_desde;
    end
    
    IF(in_hasta IS NULL) then
    begin
        SELECT MAX(importe)
        FROM FACTURA
        INTO :in_hasta;
    end
    
    FOR SELECT nro_factura, fecha, estado, importe
        FROM factura
        WHERE importe BETWEEN :in_desde AND :in_hasta
        INTO :out_nro_factura, :out_fecha, :out_estado, :out_importe
    DO
    begin
        suspend;
        -- suspend es el comando que "empuja" la fila actual a la pantalla del usuario
    end
END^

SET TERM ;^

-- Punto 3

SET TERM ^;

CREATE PROCEDURE LISTAR_FACTURAS_RANGO (
    in_desde_nro_fact int,
    in_hasta_nro_fact int
)
RETURNS (
    OUT_ID_PROD INT,
    OUT_DESC_PROD VARCHAR(100),
    OUT_STOCK INT,
    OUT_TOTAL_CANTIDAD int,
    out_total_pesos double precision
)
AS
begin
    -- Agrupo por producto para obtener los totales
    FOR SELECT P.id_prod, P.descr, P.stock, SUM(D.cant), SUM(D.cant * D.precio) FROM PRODUCTO P
    INNER JOIN DETALLE D on P.ID_PROD = D.ID_PROD
    WHERE D.nro_factura BETWEEN :in_desde_nro_fact AND :in_hasta_nro_fact
    GROUP BY P.id_prod, P.DESCR, P.STOCK
    INTO :OUT_ID_PROD, :OUT_DESC_PROD, OUT_STOCK, :OUT_TOTAL_CANTIDAD, :OUT_TOTAL_PESOS
    DO 
    begin
        suspend;
    end
END^

SET TERM ;^

-- Punto 4

SET TERM ^;

-- Selecciono el producto, hago una subquery para encontrar la factura mas reciente y "devolverla" como factura1 y así para las subsiguientes 2 facturas 

CREATE PROCEDURE IMPRIMIR_PRODUCTOS
RETURNS(
    OUT_ID_PROD int,
    OUT_DESCR VARCHAR(100),
    OUT_STOCK INT,
    OUT_FACTURA1 INT,
    OUT_FACTURA2 INT,
    OUT_FACTURA3 int
)
AS
begin
    for select p.id_prod, p.descr, p.stock,
        (SELECT FIRST 1 D1.NRO_FACTURA FROM DETALLE D1 
         WHERE D1.ID_PROD = P.ID_PROD ORDER BY D1.NRO_FACTURA DESC),
        (SELECT FIRST 1 SKIP 1 D2.NRO_FACTURA FROM DETALLE D2 
         WHERE D2.ID_PROD = P.ID_PROD ORDER BY D2.NRO_FACTURA DESC),
        (SELECT FIRST 1 SKIP 2 D3.NRO_FACTURA FROM DETALLE D3 
         WHERE D3.ID_PROD = P.ID_PROD ORDER BY D3.NRO_FACTURA DESC)
    from producto p
    into
        :OUT_ID_PROD, 
        :OUT_DESCR, 
        :OUT_STOCK, 
        :OUT_FACTURA1, 
        :OUT_FACTURA2, 
        :OUT_FACTURA3
    do
    begin
        suspend;
    end
END^

SET TERM ;^

-- Punto 5

SET TERM ^;

CREATE OR ALTER PROCEDURE DEVOLVER_FACTURAS_IMPORTES
RETURNS
(
    OUT_FAC_100 INT,
    OUT_FAC_1000 INT,
    OUT_FAC_10000 INT,
    OUT_FAC_100000 INT
)
AS
BEGIN
    SELECT 
        SUM(CASE WHEN IMPORTE <= 100 THEN 1 ELSE 0 END),
        SUM(CASE WHEN IMPORTE > 100 AND IMPORTE <= 1000 THEN 1 ELSE 0 END),
        SUM(CASE WHEN IMPORTE > 1000 AND IMPORTE <= 10000 THEN 1 ELSE 0 END),
        SUM(CASE WHEN IMPORTE > 10000 AND IMPORTE <= 100000 THEN 1 ELSE 0 END)
    FROM FACTURA
    INTO :OUT_FAC_100, :OUT_FAC_1000, :OUT_FAC_10000, :OUT_FAC_100000;
    SUSPEND; 
END^

SET TERM ;^

-- Punto 6

-- Imprimir datos facturas cuyo segundo producto tenga un stock actual menor a 100

SET TERM ^;

CREATE procedure ENUMERAR_PRODUCTOS_FACTURA
returns
(
    out_nro_fact int,
    out_importe double precision,
    out_fecha date,
    out_estado smallint
)
AS
begin
    FOR SELECT nro_factura, importe, fecha, estado
    from FACTURA F
    where (
        (SELECT FIRST 1 skip 1 stock 
        FROM producto p
        join detalle d
        on D.ID_PROD = p.ID_PROD
        where D.NRO_FACTURA = f.NRO_FACTURA
        order by D.id_prod)
        < 100
    )
    into
        :out_nro_fact,
        :out_importe,
        :out_fecha,
        :out_estado
    DO
    begin
        suspend;
    end
END^

SET TERM ;^

-- Punto 7

SET TERM ^ ;
CREATE PROCEDURE SELECT_TOTAL_ANIO (ANIO smallint)
RETURNS (MES smallint , TOTAL double precision)
AS
begin
    MES = 1;
    while (MES <= 12) do begin
        TOTAL = 0;
        select sum( F.IMPORTE ) from FACTURA as F
        where extract(year from F.FECHA) = :ANIO
            and extract(month from F.FECHA) = :MES
                into :TOTAL;
        suspend;
        MES = MES + 1;
    end
end^
SET TERM ; ^

SELECT * FROM SELECT_TOTAL_ANIO(2026);

--- EXECUTE PROCEDURES

-- Punto 1

/* Estado 0: Pendientes */
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3001, 250.00, 0, '2024-02-10');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3002, 85.00, 0, '2024-03-15');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3003, 120.00, 0, '2024-06-20');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3004, 310.00, 0, '2024-09-05');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3005, 45.00, 0, '2024-11-12');

/* Estado 2: Especiales (Anuladas/Otras) */
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3006, 180.00, 2, '2024-01-25');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3007, 65.00, 2, '2024-04-18');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3008, 95.00, 2, '2024-05-30');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3009, 25.50, 2, '2024-08-14');
INSERT INTO FACTURA (nro_factura, importe, estado, fecha) VALUES (3010, 150.00, 2, '2024-10-02');

SET TERM ^;
CREATE PROCEDURE EXE_BORRAR_ANULADAS ( DESDE date, HASTA date )
AS
begin
    delete from DETALLE
    where nro_factura in
    (
        SELECT nro_factura from FACTURA
        where fecha >= :desde AND fecha <= :hasta AND estado = 2
    );

    delete from FACTURA
    where ESTADO = 2 and FECHA >= :DESDE and FECHA <= :HASTA;
end^
SET TERM ;^

EXECUTE PROCEDURE EXE_BORRAR_ANULADAS ('2024-01-01', '2024-12-31' );

SELECT * FROM factura;

-- Punto 2

CREATE EXCEPTION argumento_invalido 'La accion insertada no existe.';

SET TERM ^;
CREATE PROCEDURE ABM_PROD (
    IN_ACCION CHAR(1), 
    IN_ID_PROD INT,
    IN_DESCR VARCHAR(200),
    in_STOCK INT
    )
RETURNS (ERROR INT)
AS
begin
    if(:in_accion = 'A') then
    begin
        INSERT INTO PRODUCTO (id_prod, descr, stock)
        VALUES (:in_id_prod, :in_descr, :in_stock);
        ERROR = 0;
    end
    else if (:in_accion = 'B') then
    begin
        DELETE FROM PRODUCTO
        WHERE id_prod = :in_id_prod;
        ERROR = 0;
    end
    else if (:in_accion = 'C') then
    begin
        IF (:in_descr is not null) then
        begin
            update PRODUCTO
            set descr = :in_descr
            where id_prod = :in_id_prod;
        end
        IF (:in_stock is not null) then
        begin
            update PRODUCTO
            set stock = :in_stock
            where id_prod = :in_id_prod;
        end
        ERROR = 0;
    end
    else
    begin
        EXCEPTION argumento_invalido;
    end
    
    when any do
    begin
        ERROR = gdscode;
    end
end^
SET TERM ;^

-- Pruebo

EXECUTE PROCEDURE ABM_PROD ('C', 1, NULL, 52);
EXECUTE PROCEDURE ABM_PROD ('A', 1, 'Auriculares Bluetooth', 52);

-- Punto 3

CREATE GENERATOR generador_factura;
SET GENERATOR generador_factura TO 5000;

SET TERM ^;

CREATE TRIGGER trg_bi_factura FOR factura
ACTIVE BEFORE INSERT
POSITION 0
AS
begin
    IF(NEW.nro_factura is null) then
        NEW.nro_factura = GEN_ID(generador_factura, 1);
END^

SET TERM ;^

SET TERM ^;

CREATE PROCEDURE GENERAR_FACTURAS_MASIVAS (
    CANTIDAD INT,
    FECHA_DESDE DATE
)
AS
DECLARE VARIABLE I INT = 0;
DECLARE VARIABLE FECHA_ACTUAL DATE;
begin
    FECHA_ACTUAL = :FECHA_DESDE;

    while (I < :CANTIDAD) do
    begin
        begin
            INSERT INTO FACTURA (FECHA, ESTADO, IMPORTE)
            VALUES (:FECHA_ACTUAL, 0, 0);
            
            I = I + 1;
            FECHA_ACTUAL = FECHA_ACTUAL + 1;
        end
        
        WHEN ANY DO 
        BEGIN 
            --
        END
    end
end^

SET TERM ;^

EXECUTE PROCEDURE GENERAR_FACTURAS_MASIVAS(5, '2023-01-01');


