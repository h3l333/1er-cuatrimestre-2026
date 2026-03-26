SET TERM ^;
CREATE PROCEDURE P_CIERRE(
    IN anio INT,
    IN mes INT,
    OUT facturas_borradas INT
)
AS BEGIN
    DECLARE contador INT;

    -- Contar las facturas a eliminar
    SELECT COUNT(*) INTO contador
    FROM FACTURA
    WHERE EXTRACT(YEAR FROM FECHA) = anio AND EXTRACT(MONTH FROM FECHA) = mes;

    -- Borrar los detalles de las facturas correspondientes
    DELETE FROM DETALLE
    WHERE NRO IN (SELECT NRO FROM FACTURA WHERE EXTRACT(YEAR FROM FECHA) = anio AND EXTRACT(MONTH FROM FECHA) = mes);

    -- Borrar las facturas correspondientes
    DELETE FROM FACTURA
    WHERE EXTRACT(YEAR FROM FECHA) = anio AND EXTRACT(MONTH FROM FECHA) = mes;

    -- Devolver la cantidad de facturas borradas
    SET facturas_borradas = contador;
END^
SET TERM ;^
