-- El ejercicio 3b lo manejo con 2 triggers

-- Aca comienzo con el primer trigger -> TRG_NRO_PAGO_ID

--Creo una tabla aux para manejar el ultimo numero de pago de cada factura
CREATE TABLE ULTIMO_NRO_PAGO_FACTURA (
    NRO INT PRIMARY KEY,
    FOREIGN KEY (NRO) REFERENCES FACTURA(NRO),
    ULTIMO_NRO_PAGO INT
);
--
SET TERM ^;
CREATE TRIGGER TRG_NRO_PAGO_ID FOR PAGO ACTIVE
BEFORE INSERT POSITION 0
BEGIN
    DECLARE ultimo_nro_pago INT;
    
    -- Obtener el último NROPAGO registrado en la tabla auxiliar para la factura actual
    SELECT ULTIMO_NRO_PAGO INTO ultimo_nro_pago
    FROM ULTIMO_NRO_PAGO_FACTURA
    WHERE NRO = NEW.NRO;
    
    -- Si no se encuentra ningún registro para la factura actual, se asume 0 como último número de pago
    IF ultimo_nro_pago IS NULL THEN
        SET ultimo_nro_pago = 0;
    END IF;
    
    -- Asignar el nuevo NROPAGO como el máximo actual + 1
    SET NEW.NROPAGO = ultimo_nro_pago + 1;
    
    -- Actualizar la tabla auxiliar si ya existe un registro, de lo contrario, ingresarlo
    IF ultimo_nro_pago > 0 THEN
        UPDATE ULTIMO_NRO_PAGO_FACTURA
        SET ULTIMO_NRO_PAGO = NEW.NROPAGO
        WHERE NRO = NEW.NRO;
    ELSE
        INSERT INTO ULTIMO_NRO_PAGO_FACTURA (NRO, ULTIMO_NRO_PAGO)
        VALUES (NEW.NRO, NEW.NROPAGO);
    END IF;
END^
SET TERM ;^

-- Aca continuo con el segudo trigger -> TRG_ELIMINAR_PAGOS
SET TERM ^;
CREATE TRIGGER TRG_ELIMINAR_PAGOS FOR PAGO ACTIVE
BEFORE DELETE POSITION 0
BEGIN
    DECLARE ultimo_nro_pago INT;
    
    -- Obtener el último NROPAGO registrado para la factura actual
    SELECT ULTIMO_NRO_PAGO INTO ultimo_nro_pago
    FROM ULTIMO_NRO_PAGO_FACTURA
    WHERE NRO = OLD.NRO;

    -- Si el número del pago que se está eliminando no es el último, se eliminarán los pagos posteriores
    IF OLD.NROPAGO < ultimo_nro_pago THEN
        DELETE FROM PAGO
        WHERE NRO = OLD.NRO AND NROPAGO > OLD.NROPAGO;
    END IF;
END^
SET TERM ;^