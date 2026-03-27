SET TERM ^;

CREATE TRIGGER trg_bi_factura_fecha FOR FACTURA
ACTIVE BEFORE INSERT POSITION 1
AS
DECLARE VARIABLE fecha_fact_previa DATE;
begin
    SELECT fecha FROM FACTURA
    WHERE nro_factura = (NEW.NRO_FACTURA - 1)
    INTO :fecha_fact_previa;
    
    IF(:fecha_fact_previa > NEW.FECHA) THEN
        EXCEPTION FECHA_FACTURA_ERRONEA;
END^

SET TERM ;^

-- Consultas

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

-- 2do stored procedure

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